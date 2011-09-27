-- this script will upgrade a database schema from the latest jbilling release
-- to the code currently at the tip of the trunk.
-- It is tested on postgreSQL, but it is meant to be ANSI SQL
--
-- MySQL does not support many of the ANSI SQL statements used in this file to upgrade the
-- base schema. If you are using MySQL as your database, you will need to edit this file and
-- comment out the labeled 'postgresql' statements and un-comment the 'mysql' statements.

-- validatePurchase changes
insert into pluggable_task_type_category values (19, 'Validate Purchase', 'com.sapienter.jbilling.server.user.tasks.IValidatePurchaseTask');
insert into pluggable_task_type values (55, 19, 'com.sapienter.jbilling.server.user.tasks.UserBalanceValidatePurchaseTask', 0);
insert into pluggable_task_type values (56, 19, 'com.sapienter.jbilling.server.user.tasks.RulesValidatePurchaseTask', 0);

-- new event log column
alter table event_log add column affected_user_id integer;
alter table event_log add constraint "event_log_fk_6" foreign key (affected_user_id) references base_user(id); -- postgresql
-- alter table event_log add constraint event_log_fk_6 foreign key (affected_user_id) references base_user(id); -- mysql

-- new invoice status for invoice carry over
insert into generic_status_type values ('invoice_status');
insert into generic_status (id, dtype, status_value) values (26, 'invoice_status', 1); -- paid
insert into generic_status (id, dtype, status_value) values (27, 'invoice_status', 2); -- unpaid
insert into generic_status (id, dtype, status_value) values (28, 'invoice_status', 3); -- unpaid and carried over

insert into jbilling_table values (90, 'invoice_status', 4);
update jbilling_table set next_id = 29 where id = 87; -- generic_status

insert into international_description (table_id, foreign_id, psudo_column, language_id, content)  values (90, 1, 'description', 1, 'Paid');
insert into international_description (table_id, foreign_id, psudo_column, language_id, content)  values (90, 2, 'description', 1, 'Unpaid');
insert into international_description (table_id, foreign_id, psudo_column, language_id, content)  values (90, 3, 'description', 1, 'Unpaid, balance carried to new invoice');

update report set tables_list = 'base_user, invoice, currency , international_description, generic_status', where_str = 'base_user.id = invoice.user_id and invoice.currency_id = currency.id and invoice.status_id = generic_status.id and generic_status.dtype = ''invoice_status'' and international_description.foreign_id = generic_status.status_value and international_description.table_id = 90' where id = 2;
update report_field set table_name = 'international_description', column_name = 'content' where report_id = 2 and column_name = 'to_process';
-- migration
alter table invoice add column status_id integer;

update invoice set status_id = 26 where to_process = 0 and delegated_invoice_id is null;     -- mark as paid
update invoice set status_id = 28 where to_process = 0 and delegated_invoice_id is not null; -- mark carried over
update invoice set status_id = 27 where to_process = 1;                                      -- mark as unpaid

-- balance adjustment will need to be handled manually. a carried invoices balance will not be zeroed, and should
-- be equal to the total of all invoice lines for that invoice. a quick script can easily be created to handle this
--
-- psudo-code:
--    for all invoices where status_id = 28
--      for each invoice_line of invoice,
--        add line total to sum
--      update invoice set balance = sum where invoice_id = ?

alter table invoice drop column to_process;

-- external credit card storage
insert into pluggable_task_type (id, category_id, class_name, min_parameters) values (58, 17, 'com.sapienter.jbilling.server.payment.tasks.SaveCreditCardExternallyTask', 1);
insert into pluggable_task_type (id, category_id, class_name, min_parameters) values (59, 6, 'com.sapienter.jbilling.server.pluggableTask.PaymentFakeExternalStorage', 0);

insert into payment_method (id) values (9);
alter table credit_card drop column security_code;
alter table credit_card add column gateway_key varchar(100);
insert into international_description (table_id, foreign_id, psudo_column, language_id, content) values (35, 9, 'description', 1, 'Payment Gateway Key');

-- new rules pricing plug-in
insert into pluggable_task_type (id, category_id, class_name, min_parameters) values (60, 14, 'com.sapienter.jbilling.server.item.tasks.RulesPricingTask2', 0);
insert into pluggable_task_type (id, category_id, class_name, min_parameters) values (61, 13, 'com.sapienter.jbilling.server.order.task.RulesItemManager2', 0);
insert into pluggable_task_type (id, category_id, class_name, min_parameters) values (62, 1, 'com.sapienter.jbilling.server.order.task.RulesLineTotalTask2', 0);

-- new mediation process requires 3 rules packages, lengthen parameter str_value to accept multiple urls
alter table pluggable_task_parameter alter column str_value type varchar(500); -- postgresql
-- alter table pluggable_task_parameter modify str_value varchar(500); -- mysql

-- world pay task
insert into pluggable_task_type (id, category_id, class_name, min_parameters) values (63, 6, 'com.sapienter.jbilling.server.payment.tasks.PaymentWorldPayTask', 3);
insert into pluggable_task_type (id, category_id, class_name, min_parameters) values (64, 6, 'com.sapienter.jbilling.server.payment.tasks.PaymentWorldPayExternalTask', 3);

-- automatic recharge task
alter table customer add column auto_recharge double precision;
insert into preference_type (id, int_def_value, str_def_value, float_def_value) values (49, null, null, null);
insert into pluggable_task_type (id, category_id, class_name, min_parameters) values (65, 17, 'com.sapienter.jbilling.server.user.tasks.AutoRechargeTask', 0);

-- changes in mediation module
alter table mediation_record drop column end_datetime;

-- refactoring of the sequence generator table
create table jbilling_seqs (name VARCHAR(255), next_id integer);
insert into jbilling_seqs select name, next_id from jbilling_table;
alter table jbilling_table drop column next_id;

-- new payment fields
alter table payment add column payment_period integer;
alter table payment add column payment_notes VARCHAR(500);

-- New pluggable task category, type and task for the billing process
insert into pluggable_task_type_category values (20, 'BillingProcessFilterTask', 'com.sapienter.jbilling.server.process.task.IBillingProcessFilterTask');
insert into pluggable_task_type values (69, 20, 'com.sapienter.jbilling.server.process.task.BasicBillingProcessFilterTask',0);
insert into pluggable_task_type values (70, 20, 'com.sapienter.jbilling.server.process.task.BillableUsersBillingProcessFilterTask',0);

-- new mediation_record_status
insert into generic_status_type values ('mediation_record_status');

insert into generic_status (id, dtype, status_value) values (29, 'mediation_record_status', 1); -- done and billable
insert into generic_status (id, dtype, status_value) values (30, 'mediation_record_status', 2); -- done and not billable
insert into generic_status (id, dtype, status_value) values (31, 'mediation_record_status', 3); -- error detected
insert into generic_status (id, dtype, status_value) values (32, 'mediation_record_status', 4); -- error declared

insert into jbilling_table values (91, 'mediation_record_status');

insert into international_description (table_id, foreign_id, psudo_column, language_id, content)  values (91, 1, 'description', 1, 'Done and billable');
insert into international_description (table_id, foreign_id, psudo_column, language_id, content)  values (91, 2, 'description', 1, 'Done and not billable');
insert into international_description (table_id, foreign_id, psudo_column, language_id, content)  values (91, 3, 'description', 1, 'Error detected');
insert into international_description (table_id, foreign_id, psudo_column, language_id, content)  values (91, 4, 'description', 1, 'Error declared');

-- alter mediation_record table for adding status field with previous data update
alter table mediation_record add column status_id integer;
update mediation_record set status_id = 29; -- mark all records as done and billable
alter table mediation_record alter column status_id set NOT NULL; -- postgresql
-- alter table mediation_record modify status_id integer NOT NULL; -- mysql

alter table mediation_record ADD CONSTRAINT mediation_record_FK_2 FOREIGN KEY (status_id) REFERENCES generic_status (id);

create index mediation_record_i on mediation_record using btree (id_key, status_id); -- postgresql
-- alter table mediation_record add index mediation_record_i (id_key, status_id); -- mysql

-- mediation error handler plug-in
insert into pluggable_task_type_category (id, description, interface_name) values (21, 'Mediation Error Handler', 'com.sapienter.jbilling.server.mediation.task.IMediationErrorHandler');
insert into pluggable_task_type  (id, category_id, class_name, min_parameters) values (71, 21, 'com.sapienter.jbilling.server.mediation.task.SaveToFileMediationErrorHandler', 0);
insert into pluggable_task_type  (id, category_id, class_name, min_parameters) values (73, 21, 'com.sapienter.jbilling.server.mediation.task.SaveToJDBCMediationErrorHandler', 1);

-- scheduled task's
insert into pluggable_task_type_category(id, description, interface_name) values(22, 'Scheduled Tasks', 'com.sapienter.jbilling.server.process.task.IScheduledTask');

-- unique id for mediation_record
-- postgresql
alter table mediation_record add column id integer;
create temp sequence mediation_rec_seq;
update mediation_record set id = nextval('mediation_rec_seq');

alter table mediation_record_line drop constraint mediation_record_line_fk_1;
alter table mediation_record drop constraint mediation_record_pkey;
alter table mediation_record add constraint mediation_record_pkey primary key (id);

alter table mediation_record_line add column mediation_record_id_2 integer;
update mediation_record_line set mediation_record_id_2 = r.id from mediation_record r, mediation_record_line l where r.id_key = l.mediation_record_id;
alter table mediation_record_line drop column mediation_record_id;
alter table mediation_record_line rename column mediation_record_id_2 to mediation_record_id;
alter table mediation_record_line alter column mediation_record_id set NOT NULL;
alter table mediation_record_line add constraint mediation_record_line_fk_1 foreign key (mediation_record_id) references mediation_record(id);
 
-- mysql
-- CREATE TABLE mediation_record_2 (
--    id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
--    id_key varchar(100) NOT NULL,
--    start_datetime timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
--    mediation_process_id int,
--    OPTLOCK int NOT NULL,
--    status_id int NOT NULL
-- );
-- insert into mediation_record_2 (id_key, start_datetime, mediation_process_id, status_id, OPTLOCK) (select id_key, start_datetime, mediation_process_id, status_id, OPTLOCK from mediation_record);
-- drop table mediation_record;
-- rename table mediation_record_2 to mediation_record;
-- alter table mediation_record_line modify column id integer;
--
-- alter table mediation_record_line add column mediation_record_id_2 integer;
-- update mediation_record_line as l, mediation_record as r set l.mediation_record_id_2 = r.id where r.id_key = l.mediation_record_id;
-- alter table mediation_record_line drop column mediation_record_id;
-- alter table mediation_record_line change mediation_record_id_2 mediation_record_id integer;
-- alter table mediation_record_line modify mediation_record_id integer NOT NULL;

-- insert new mediation_record next_id value into the jbilling_seqs table.
-- if you have no existing mediation_records, insert 0
insert into jbilling_seqs values ('mediation_record', (select round(max(id)/100)+1 from mediation_record));

-- authorize.net CIM payment task, may already exist in some versions of jbilling
update pluggable_task_type set min_parameters = 2 where class_name = 'com.sapienter.jbilling.server.payment.tasks.PaymentAuthorizeNetCIMTask';
insert into pluggable_task_type  (id, category_id, class_name, min_parameters) values (76, 6, 'com.sapienter.jbilling.server.payment.tasks.PaymentAuthorizeNetCIMTask', 2);

-- mediation process scheduled task
insert into pluggable_task_type (id, category_id, class_name, min_parameters) values (77, 22, 'com.sapienter.jbilling.server.mediation.task.MediationProcessTask', 0);

-- Changed price, amount, quantity, rate, percentage fields to decimal
-- postgresql
alter table currency_exchange alter column rate type numeric(22, 10);
alter table customer alter column dynamic_balance type numeric(22, 10);
alter table customer alter column credit_limit type numeric(22, 10);
alter table customer alter column auto_recharge type numeric(22, 10);
alter table invoice alter column total type numeric(22, 10);
alter table invoice alter column balance type numeric(22, 10);
alter table invoice alter column carried_balance type numeric(22, 10);
alter table invoice_line alter column amount type numeric(22, 10);
alter table invoice_line alter column quantity type numeric(22, 10);
alter table invoice_line alter column price type numeric(22, 10);
alter table item alter column percentage type numeric(22, 10);
alter table item_price alter column price type numeric(22, 10);
alter table mediation_record_line alter column amount type numeric(22, 10);
alter table mediation_record_line alter column quantity type numeric(22, 10);
alter table order_line alter column amount type numeric(22, 10);
alter table order_line alter column quantity type numeric(22, 10);
alter table order_line alter column price type numeric(22, 10);
alter table partner alter column balance type numeric(22, 10);
alter table partner alter column total_payments type numeric(22, 10);
alter table partner alter column total_refunds type numeric(22, 10);
alter table partner alter column total_payouts type numeric(22, 10);
alter table partner alter column percentage_rate type numeric(22, 10);
alter table partner alter column referral_fee type numeric(22, 10);
alter table partner alter column due_payout type numeric(22, 10);
alter table partner_payout alter column payments_amount type numeric(22, 10);
alter table partner_payout alter column refunds_amount type numeric(22, 10);
alter table partner_payout alter column balance_left type numeric(22, 10);
alter table partner_range alter column percentage_rate type numeric(22, 10);
alter table partner_range alter column referral_fee type numeric(22, 10);
alter table payment alter column amount type numeric(22, 10);
alter table payment alter column balance type numeric(22, 10);
alter table payment_invoice alter column amount type numeric(22, 10);
alter table process_run_total alter column total_invoiced type numeric(22, 10);
alter table process_run_total alter column total_paid type numeric(22, 10);
alter table process_run_total alter column total_not_paid type numeric(22, 10);
alter table process_run_total_pm alter column total type numeric(22, 10);
alter table pluggable_task_parameter alter column float_value type numeric(22, 10);
alter table preference alter column float_value type numeric(22, 10);
alter table preference_type alter column float_def_value type numeric(22, 10);
-- mysql
-- alter table currency_exchange modify rate numeric(22, 10);
-- alter table customer modify dynamic_balance numeric(22, 10);
-- alter table customer modify credit_limit numeric(22, 10);
-- alter table customer modify auto_recharge numeric(22, 10);
-- alter table invoice modify total numeric(22, 10);
-- alter table invoice modify balance numeric(22, 10);
-- alter table invoice modify carried_balance numeric(22, 10);
-- alter table invoice_line modify amount numeric(22, 10);
-- alter table invoice_line modify quantity numeric(22, 10);
-- alter table invoice_line modify price numeric(22, 10);
-- alter table item modify percentage numeric(22, 10);
-- alter table item_price modify price numeric(22, 10);
-- alter table mediation_record_line modify amount numeric(22, 10);
-- alter table mediation_record_line modify quantity numeric(22, 10);
-- alter table order_line modify amount numeric(22, 10);
-- alter table order_line modify quantity numeric(22, 10);
-- alter table order_line modify price numeric(22, 10);
-- alter table partner modify balance numeric(22, 10);
-- alter table partner modify total_payments numeric(22, 10);
-- alter table partner modify total_refunds numeric(22, 10);
-- alter table partner modify total_payouts numeric(22, 10);
-- alter table partner modify percentage_rate numeric(22, 10);
-- alter table partner modify referral_fee numeric(22, 10);
-- alter table partner modify due_payout numeric(22, 10);
-- alter table partner_payout modify payments_amount numeric(22, 10);
-- alter table partner_payout modify refunds_amount numeric(22, 10);
-- alter table partner_payout modify balance_left numeric(22, 10);
-- alter table partner_range modify percentage_rate numeric(22, 10);
-- alter table partner_range modify referral_fee numeric(22, 10);
-- alter table payment modify amount numeric(22, 10);
-- alter table payment modify balance numeric(22, 10);
-- alter table payment_invoice modify amount numeric(22, 10);
-- alter table process_run_total modify total_invoiced numeric(22, 10);
-- alter table process_run_total modify total_paid numeric(22, 10);
-- alter table process_run_total modify total_not_paid numeric(22, 10);
-- alter table process_run_total_pm modify total numeric(22, 10);
-- alter table pluggable_task_parameter modify float_value numeric(22, 10);
-- alter table preference modify float_value numeric(22, 10);
-- alter table preference_type modify float_def_value numeric(22, 10);

alter table mediation_process alter column end_datetime type timestamp; -- postgresql
-- alter table mediation_process modify end_datetime timestamp null default null; -- mysql


alter table ach alter column aba_routing type character varying(40); -- postgresql
alter table ach alter column bank_account type character varying(60); -- postgresql
-- alter table ach modify aba_routing varchar(40); -- mysql
-- alter table ach modify bank_account varchar(60); -- mysql
-- new generate rules plug-in category
insert into pluggable_task_type_category values (23, 'Rules Generator', 'com.sapienter.jbilling.server.rule.task.IRulesGenerator');
insert into pluggable_task_type values (78, 23, 'com.sapienter.jbilling.server.rule.task.VelocityRulesGeneratorTask', 2);

-- new process run status
insert into generic_status_type values ('process_run_status');
insert into generic_status (id, dtype, status_value) values (33, 'process_run_status', 1); -- running
insert into generic_status (id, dtype, status_value) values (34, 'process_run_status', 2); -- finished: successful
insert into generic_status (id, dtype, status_value) values (35, 'process_run_status', 3); -- finished: failed

insert into jbilling_table values (92, 'process_run_status');

--update jbilling_table set next_id = 36 where id = 87; -- generic_status

insert into international_description (table_id, foreign_id, psudo_column, language_id, content)  values (92, 1, 'description', 1, 'Running');
insert into international_description (table_id, foreign_id, psudo_column, language_id, content)  values (92, 2, 'description', 1, 'Finished: successful');
insert into international_description (table_id, foreign_id, psudo_column, language_id, content)  values (92, 3, 'description', 1, 'Finished: failed');


alter table process_run add column status_id integer;

update process_run set status_id = 33 where finished is null;
update process_run set status_id = 34 where finished is not null;

alter table process_run alter column status_id set NOT NULL;
alter table process_run ADD CONSTRAINT process_run_FK_2 FOREIGN KEY (status_id) REFERENCES generic_status (id);

-- new table to store user status within process run
drop table if exists process_run_user;
create table process_run_user (
  id int PRIMARY KEY NOT NULL,
  process_run_id int NOT NULL,
  user_id int NOT NULL,
  status int NOT NULL,
  created timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
  OPTLOCK int NOT NULL
);
alter table process_run_user ADD CONSTRAINT process_run_user_FK_1 FOREIGN KEY (process_run_id) REFERENCES process_run (id);
alter table process_run_user ADD CONSTRAINT process_run_user_FK_2 FOREIGN KEY (user_id) REFERENCES base_user (id);