
-----------------------------------------------------------------------------
-- ach
-----------------------------------------------------------------------------
drop table ach;

CREATE TABLE ach
(
                    id INTEGER NOT NULL,
                    user_id INTEGER,
                aba_routing VARCHAR (40) NOT NULL,
                bank_account VARCHAR (60) NOT NULL,
                    account_type INTEGER NOT NULL,
                bank_name VARCHAR (50) NOT NULL,
                account_name VARCHAR (100) NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE ach
    ADD PRIMARY KEY (id);


CREATE  INDEX ach_i_2 ON ach (user_id);





-----------------------------------------------------------------------------
-- ageing_entity_step
-----------------------------------------------------------------------------
drop table ageing_entity_step;

CREATE TABLE ageing_entity_step
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER,
                    status_id INTEGER,
                    days INTEGER NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE ageing_entity_step
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- base_user
-----------------------------------------------------------------------------
drop table base_user;

CREATE TABLE base_user
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER,
                password VARCHAR (40),
                deleted SMALLINT default 0 NOT NULL,
                    language_id INTEGER,
                    status_id INTEGER,
                    subscriber_status INTEGER default 1,
                    currency_id INTEGER,
                create_datetime TIMESTAMP NOT NULL,
                last_status_change TIMESTAMP,
                last_login TIMESTAMP,
                user_name VARCHAR (50),
                    failed_attempts INTEGER default 0 NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE base_user
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_base_user_un ON base_user (entity_id, user_name);





-----------------------------------------------------------------------------
-- billing_process
-----------------------------------------------------------------------------
drop table billing_process;

CREATE TABLE billing_process
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER NOT NULL,
                billing_date DATE NOT NULL,
                    period_unit_id INTEGER NOT NULL,
                    period_value INTEGER NOT NULL,
                    is_review INTEGER NOT NULL,
                    paper_invoice_batch_id INTEGER,
                    retries_to_do INTEGER default 0 NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE billing_process
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- billing_process_configuration
-----------------------------------------------------------------------------
drop table billing_process_configuration;

CREATE TABLE billing_process_configuration
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER,
                next_run_date DATE NOT NULL,
                generate_report SMALLINT NOT NULL,
                    retries INTEGER,
                    days_for_retry INTEGER,
                    days_for_report INTEGER,
                    review_status INTEGER NOT NULL,
                    period_unit_id INTEGER NOT NULL,
                    period_value INTEGER NOT NULL,
                    due_date_unit_id INTEGER NOT NULL,
                    due_date_value INTEGER NOT NULL,
                df_fm SMALLINT,
                only_recurring SMALLINT default 1 NOT NULL,
                invoice_date_process SMALLINT NOT NULL,
                    OPTLOCK INTEGER NOT NULL,
                auto_payment SMALLINT default 0 NOT NULL,
                    maximum_periods INTEGER default 1 NOT NULL,
                    auto_payment_application INTEGER default 0 NOT NULL
);

ALTER TABLE billing_process_configuration
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- process_run
-----------------------------------------------------------------------------
drop table process_run;

CREATE TABLE process_run
(
                    id INTEGER NOT NULL,
                    process_id INTEGER,
                run_date DATE NOT NULL,
                started TIMESTAMP NOT NULL,
                finished TIMESTAMP,
                payment_finished TIMESTAMP,
                    invoices_generated INTEGER,
                    OPTLOCK INTEGER NOT NULL,
                    status_id INTEGER NOT NULL
);

ALTER TABLE process_run
    ADD PRIMARY KEY (id);


CREATE  INDEX bp_run_process_ix ON process_run (process_id);





-----------------------------------------------------------------------------
-- process_run_total
-----------------------------------------------------------------------------
drop table process_run_total;

CREATE TABLE process_run_total
(
                    id INTEGER NOT NULL,
                    process_run_id INTEGER,
                    currency_id INTEGER NOT NULL,
                total_invoiced NUMERIC (22,10),
                total_paid NUMERIC (22,10),
                total_not_paid NUMERIC (22,10),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE process_run_total
    ADD PRIMARY KEY (id);


CREATE  INDEX bp_run_total_run_ix ON process_run_total (process_run_id);





-----------------------------------------------------------------------------
-- process_run_total_pm
-----------------------------------------------------------------------------
drop table process_run_total_pm;

CREATE TABLE process_run_total_pm
(
                    id INTEGER NOT NULL,
                    process_run_total_id INTEGER,
                    payment_method_id INTEGER,
                total NUMERIC (22,10) NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE process_run_total_pm
    ADD PRIMARY KEY (id);


CREATE  INDEX bp_pm_index_total ON process_run_total_pm (process_run_total_id);





-----------------------------------------------------------------------------
-- process_run_user
-----------------------------------------------------------------------------
drop table process_run_user;

CREATE TABLE process_run_user
(
                    id INTEGER NOT NULL,
                    process_run_id INTEGER NOT NULL,
                    user_id INTEGER NOT NULL,
                    status INTEGER NOT NULL,
                created DATE NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE process_run_user
    ADD PRIMARY KEY (id);


CREATE  INDEX bp_run_user_run_ix ON process_run_user (process_run_id);
CREATE  INDEX bp_run_user_user_ix ON process_run_user (user_id);





-----------------------------------------------------------------------------
-- contact
-----------------------------------------------------------------------------
drop table contact;

CREATE TABLE contact
(
                    id INTEGER NOT NULL,
                organization_name VARCHAR (200),
                street_addres1 VARCHAR (100),
                street_addres2 VARCHAR (100),
                city VARCHAR (50),
                state_province VARCHAR (30),
                postal_code VARCHAR (15),
                country_code VARCHAR (2),
                last_name VARCHAR (30),
                first_name VARCHAR (30),
                person_initial VARCHAR (5),
                person_title VARCHAR (40),
                    phone_country_code INTEGER,
                    phone_area_code INTEGER,
                phone_phone_number VARCHAR (20),
                    fax_country_code INTEGER,
                    fax_area_code INTEGER,
                fax_phone_number VARCHAR (20),
                email VARCHAR (200),
                create_datetime TIMESTAMP NOT NULL,
                deleted SMALLINT default 0 NOT NULL,
                notification_include SMALLINT default 1,
                    user_id INTEGER,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE contact
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_contact_fname ON contact (first_name);
CREATE  INDEX ix_contact_lname ON contact (last_name);
CREATE  INDEX ix_contact_orgname ON contact (organization_name);
CREATE  INDEX contact_i_del ON contact (deleted);
CREATE  INDEX ix_contact_fname_lname ON contact (first_name, last_name);
CREATE  INDEX ix_contact_address ON contact (street_addres1, city, postal_code, street_addres2, state_province, country_code);
CREATE  INDEX ix_contact_phone ON contact (phone_phone_number, phone_area_code, phone_country_code);





-----------------------------------------------------------------------------
-- contact_field
-----------------------------------------------------------------------------
drop table contact_field;

CREATE TABLE contact_field
(
                    id INTEGER NOT NULL,
                    type_id INTEGER,
                    contact_id INTEGER,
                content VARCHAR (100) NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE contact_field
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_contact_field_cid ON contact_field (contact_id);
CREATE  INDEX ix_contact_field_content ON contact_field (content);





-----------------------------------------------------------------------------
-- contact_field_type
-----------------------------------------------------------------------------
drop table contact_field_type;

CREATE TABLE contact_field_type
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER,
                prompt_key VARCHAR (50) NOT NULL,
                data_type VARCHAR (10) NOT NULL,
                customer_readonly SMALLINT
);

ALTER TABLE contact_field_type
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_cf_type_entity ON contact_field_type (entity_id);





-----------------------------------------------------------------------------
-- contact_map
-----------------------------------------------------------------------------
drop table contact_map;

CREATE TABLE contact_map
(
                    id INTEGER NOT NULL,
                    contact_id INTEGER,
                    type_id INTEGER NOT NULL,
                    table_id INTEGER NOT NULL,
                    foreign_id INTEGER NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE contact_map
    ADD PRIMARY KEY (id);


CREATE  INDEX contact_map_i_3 ON contact_map (contact_id);
CREATE  INDEX contact_map_i_1 ON contact_map (table_id, foreign_id, type_id);





-----------------------------------------------------------------------------
-- contact_type
-----------------------------------------------------------------------------
drop table contact_type;

CREATE TABLE contact_type
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER,
                is_primary SMALLINT
);

ALTER TABLE contact_type
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- country
-----------------------------------------------------------------------------
drop table country;

CREATE TABLE country
(
                    id INTEGER NOT NULL,
                code VARCHAR (2) NOT NULL
);

ALTER TABLE country
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- credit_card
-----------------------------------------------------------------------------
drop table credit_card;

CREATE TABLE credit_card
(
                    id INTEGER NOT NULL,
                cc_number VARCHAR (100) NOT NULL,
                cc_number_plain VARCHAR (20),
                cc_expiry DATE NOT NULL,
                name VARCHAR (150),
                    cc_type INTEGER NOT NULL,
                deleted SMALLINT default 0 NOT NULL,
                gateway_key VARCHAR (100),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE credit_card
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_cc_number ON credit_card (cc_number_plain);
CREATE  INDEX ix_cc_number_encrypted ON credit_card (cc_number);





-----------------------------------------------------------------------------
-- currency
-----------------------------------------------------------------------------
drop table currency;

CREATE TABLE currency
(
                    id INTEGER NOT NULL,
                symbol VARCHAR (10) NOT NULL,
                code VARCHAR (3) NOT NULL,
                country_code VARCHAR (2) NOT NULL
);

ALTER TABLE currency
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- currency_entity_map
-----------------------------------------------------------------------------
drop table currency_entity_map;

CREATE TABLE currency_entity_map
(
                    currency_id INTEGER,
                    entity_id INTEGER
);



CREATE  INDEX currency_entity_map_i_2 ON currency_entity_map (currency_id, entity_id);





-----------------------------------------------------------------------------
-- currency_exchange
-----------------------------------------------------------------------------
drop table currency_exchange;

CREATE TABLE currency_exchange
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER,
                    currency_id INTEGER,
                rate NUMERIC (22,10) NOT NULL,
                create_datetime TIMESTAMP NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE currency_exchange
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- customer
-----------------------------------------------------------------------------
drop table customer;

CREATE TABLE customer
(
                    id INTEGER NOT NULL,
                    user_id INTEGER,
                    partner_id INTEGER,
                referral_fee_paid SMALLINT,
                    invoice_delivery_method_id INTEGER NOT NULL,
                notes VARCHAR (1000),
                    auto_payment_type INTEGER,
                    due_date_unit_id INTEGER,
                    due_date_value INTEGER,
                df_fm SMALLINT,
                    parent_id INTEGER,
                is_parent SMALLINT,
                exclude_aging SMALLINT default 0 NOT NULL,
                invoice_child SMALLINT,
                    current_order_id INTEGER,
                    balance_type INTEGER default 1 NOT NULL,
                dynamic_balance NUMERIC (22,10),
                credit_limit NUMERIC (22,10),
                auto_recharge NUMERIC (22,10),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE customer
    ADD PRIMARY KEY (id);


CREATE  INDEX customer_i_2 ON customer (user_id);





-----------------------------------------------------------------------------
-- entity
-----------------------------------------------------------------------------
drop table entity;

CREATE TABLE entity
(
                    id INTEGER NOT NULL,
                external_id VARCHAR (20),
                description VARCHAR (100) NOT NULL,
                create_datetime TIMESTAMP NOT NULL,
                    language_id INTEGER NOT NULL,
                    currency_id INTEGER NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE entity
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- entity_delivery_method_map
-----------------------------------------------------------------------------
drop table entity_delivery_method_map;

CREATE TABLE entity_delivery_method_map
(
                    method_id INTEGER,
                    entity_id INTEGER
);








-----------------------------------------------------------------------------
-- entity_payment_method_map
-----------------------------------------------------------------------------
drop table entity_payment_method_map;

CREATE TABLE entity_payment_method_map
(
                    entity_id INTEGER,
                    payment_method_id INTEGER
);








-----------------------------------------------------------------------------
-- event_log
-----------------------------------------------------------------------------
drop table event_log;

CREATE TABLE event_log
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER,
                    user_id INTEGER,
                    affected_user_id INTEGER,
                    table_id INTEGER,
                    foreign_id INTEGER NOT NULL,
                create_datetime TIMESTAMP NOT NULL,
                    level_field INTEGER NOT NULL,
                    module_id INTEGER NOT NULL,
                    message_id INTEGER NOT NULL,
                    old_num INTEGER,
                old_str VARCHAR (1000),
                old_date TIMESTAMP,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE event_log
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_el_main ON event_log (module_id, message_id, create_datetime);





-----------------------------------------------------------------------------
-- event_log_message
-----------------------------------------------------------------------------
drop table event_log_message;

CREATE TABLE event_log_message
(
                    id INTEGER NOT NULL
);

ALTER TABLE event_log_message
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- event_log_module
-----------------------------------------------------------------------------
drop table event_log_module;

CREATE TABLE event_log_module
(
                    id INTEGER NOT NULL
);

ALTER TABLE event_log_module
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- international_description
-----------------------------------------------------------------------------
drop table international_description;

CREATE TABLE international_description
(
                    table_id INTEGER NOT NULL,
                    foreign_id INTEGER NOT NULL,
                psudo_column VARCHAR (20) NOT NULL,
                    language_id INTEGER NOT NULL,
                content VARCHAR (4000) NOT NULL
);

ALTER TABLE international_description
    ADD PRIMARY KEY (table_id,foreign_id,psudo_column,language_id);


CREATE  INDEX international_description_i_2 ON international_description (table_id, foreign_id, language_id);
CREATE  INDEX int_description_i_lan ON international_description (language_id);





-----------------------------------------------------------------------------
-- invoice
-----------------------------------------------------------------------------
drop table invoice;

CREATE TABLE invoice
(
                    id INTEGER NOT NULL,
                create_datetime TIMESTAMP NOT NULL,
                    billing_process_id INTEGER,
                    user_id INTEGER,
                    status_id INTEGER NOT NULL,
                    delegated_invoice_id INTEGER,
                due_date DATE NOT NULL,
                total NUMERIC (22,10) NOT NULL,
                    payment_attempts INTEGER default 0 NOT NULL,
                balance NUMERIC (22,10),
                carried_balance NUMERIC (22,10) NOT NULL,
                in_process_payment SMALLINT default 1 NOT NULL,
                    is_review INTEGER NOT NULL,
                    currency_id INTEGER NOT NULL,
                deleted SMALLINT default 0 NOT NULL,
                    paper_invoice_batch_id INTEGER,
                customer_notes VARCHAR (1000),
                public_number VARCHAR (40),
                last_reminder DATE,
                    overdue_step INTEGER,
                create_timestamp TIMESTAMP NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE invoice
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_invoice_user_id ON invoice (user_id, deleted);
CREATE  INDEX ix_invoice_date ON invoice (create_datetime);
CREATE  INDEX ix_invoice_number ON invoice (user_id, public_number);
CREATE  INDEX ix_invoice_due_date ON invoice (user_id, due_date);
CREATE  INDEX ix_invoice_ts ON invoice (create_timestamp, user_id);
CREATE  INDEX ix_invoice_process ON invoice (billing_process_id);





-----------------------------------------------------------------------------
-- invoice_delivery_method
-----------------------------------------------------------------------------
drop table invoice_delivery_method;

CREATE TABLE invoice_delivery_method
(
                    id INTEGER NOT NULL
);

ALTER TABLE invoice_delivery_method
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- invoice_line
-----------------------------------------------------------------------------
drop table invoice_line;

CREATE TABLE invoice_line
(
                    id INTEGER NOT NULL,
                    invoice_id INTEGER,
                    type_id INTEGER,
                amount NUMERIC (22,10) NOT NULL,
                quantity NUMERIC (22,10),
                price NUMERIC (22,10),
                deleted SMALLINT default 0 NOT NULL,
                    item_id INTEGER,
                description VARCHAR (1000),
                    source_user_id INTEGER,
                is_percentage SMALLINT default 0 NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE invoice_line
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_invoice_line_invoice_id ON invoice_line (invoice_id);





-----------------------------------------------------------------------------
-- invoice_line_type
-----------------------------------------------------------------------------
drop table invoice_line_type;

CREATE TABLE invoice_line_type
(
                    id INTEGER NOT NULL,
                description VARCHAR (50) NOT NULL,
                    order_position INTEGER NOT NULL
);

ALTER TABLE invoice_line_type
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- item
-----------------------------------------------------------------------------
drop table item;

CREATE TABLE item
(
                    id INTEGER NOT NULL,
                internal_number VARCHAR (50),
                    entity_id INTEGER,
                percentage NUMERIC (22,10),
                price_manual SMALLINT NOT NULL,
                deleted SMALLINT default 0 NOT NULL,
                has_decimals SMALLINT default 0 NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE item
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_item_ent ON item (entity_id, internal_number);





-----------------------------------------------------------------------------
-- item_price
-----------------------------------------------------------------------------
drop table item_price;

CREATE TABLE item_price
(
                    id INTEGER NOT NULL,
                    item_id INTEGER,
                    currency_id INTEGER,
                price NUMERIC (22,10) NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE item_price
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- item_type
-----------------------------------------------------------------------------
drop table item_type;

CREATE TABLE item_type
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER NOT NULL,
                description VARCHAR (100),
                    order_line_type_id INTEGER NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE item_type
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- item_type_map
-----------------------------------------------------------------------------
drop table item_type_map;

CREATE TABLE item_type_map
(
                    item_id INTEGER,
                    type_id INTEGER
);








-----------------------------------------------------------------------------
-- jbilling_table
-----------------------------------------------------------------------------
drop table jbilling_table;

CREATE TABLE jbilling_table
(
                    id INTEGER NOT NULL,
                name VARCHAR (50) NOT NULL
);

ALTER TABLE jbilling_table
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- jbilling_seqs
-----------------------------------------------------------------------------
drop table jbilling_seqs;

CREATE TABLE jbilling_seqs
(
                name VARCHAR (50) NOT NULL,
                    next_id INTEGER default 0 NOT NULL
);








-----------------------------------------------------------------------------
-- language
-----------------------------------------------------------------------------
drop table language;

CREATE TABLE language
(
                    id INTEGER NOT NULL,
                code VARCHAR (2) NOT NULL,
                description VARCHAR (50) NOT NULL
);

ALTER TABLE language
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- list
-----------------------------------------------------------------------------
drop table list;

CREATE TABLE list
(
                    id INTEGER NOT NULL,
                legacy_name VARCHAR (30),
                title_key VARCHAR (100) NOT NULL,
                instr_key VARCHAR (100),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE list
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- list_entity
-----------------------------------------------------------------------------
drop table list_entity;

CREATE TABLE list_entity
(
                    id INTEGER NOT NULL,
                    list_id INTEGER,
                    entity_id INTEGER NOT NULL,
                    total_records INTEGER NOT NULL,
                last_update DATE NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE list_entity
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- list_field
-----------------------------------------------------------------------------
drop table list_field;

CREATE TABLE list_field
(
                    id INTEGER NOT NULL,
                    list_id INTEGER,
                title_key VARCHAR (100) NOT NULL,
                column_name VARCHAR (50) NOT NULL,
                ordenable SMALLINT NOT NULL,
                searchable SMALLINT NOT NULL,
                data_type VARCHAR (10) NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE list_field
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- list_field_entity
-----------------------------------------------------------------------------
drop table list_field_entity;

CREATE TABLE list_field_entity
(
                    id INTEGER NOT NULL,
                    list_field_id INTEGER,
                    list_entity_id INTEGER,
                    min_value INTEGER,
                    max_value INTEGER,
                min_str_value VARCHAR (100),
                max_str_value VARCHAR (100),
                min_date_value TIMESTAMP,
                max_date_value TIMESTAMP,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE list_field_entity
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- menu_option
-----------------------------------------------------------------------------
drop table menu_option;

CREATE TABLE menu_option
(
                    id INTEGER NOT NULL,
                link VARCHAR (100) NOT NULL,
                    level_field INTEGER NOT NULL,
                    parent_id INTEGER
);

ALTER TABLE menu_option
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- notification_message
-----------------------------------------------------------------------------
drop table notification_message;

CREATE TABLE notification_message
(
                    id INTEGER NOT NULL,
                    type_id INTEGER,
                    entity_id INTEGER NOT NULL,
                    language_id INTEGER NOT NULL,
                use_flag SMALLINT default 1 NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE notification_message
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- notification_message_arch
-----------------------------------------------------------------------------
drop table notification_message_arch;

CREATE TABLE notification_message_arch
(
                    id INTEGER NOT NULL,
                    type_id INTEGER,
                create_datetime TIMESTAMP NOT NULL,
                    user_id INTEGER,
                result_message VARCHAR (200),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE notification_message_arch
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- notification_message_arch_line
-----------------------------------------------------------------------------
drop table notification_message_arch_line;

CREATE TABLE notification_message_arch_line
(
                    id INTEGER NOT NULL,
                    message_archive_id INTEGER,
                    section INTEGER NOT NULL,
                content VARCHAR (1000) NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE notification_message_arch_line
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- notification_message_line
-----------------------------------------------------------------------------
drop table notification_message_line;

CREATE TABLE notification_message_line
(
                    id INTEGER NOT NULL,
                    message_section_id INTEGER,
                content VARCHAR (1000) NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE notification_message_line
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- notification_message_section
-----------------------------------------------------------------------------
drop table notification_message_section;

CREATE TABLE notification_message_section
(
                    id INTEGER NOT NULL,
                    message_id INTEGER,
                    section INTEGER,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE notification_message_section
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- notification_message_type
-----------------------------------------------------------------------------
drop table notification_message_type;

CREATE TABLE notification_message_type
(
                    id INTEGER NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE notification_message_type
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- order_billing_type
-----------------------------------------------------------------------------
drop table order_billing_type;

CREATE TABLE order_billing_type
(
                    id INTEGER NOT NULL
);

ALTER TABLE order_billing_type
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- order_line
-----------------------------------------------------------------------------
drop table order_line;

CREATE TABLE order_line
(
                    id INTEGER NOT NULL,
                    order_id INTEGER,
                    item_id INTEGER,
                    type_id INTEGER,
                amount NUMERIC (22,10) NOT NULL,
                quantity NUMERIC (22,10),
                price NUMERIC (22,10),
                item_price SMALLINT,
                create_datetime TIMESTAMP NOT NULL,
                deleted SMALLINT default 0 NOT NULL,
                description VARCHAR (1000),
                    provisioning_status INTEGER,
                provisioning_request_id VARCHAR (50),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE order_line
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_order_line_order_id ON order_line (order_id);
CREATE  INDEX ix_order_line_item_id ON order_line (item_id);





-----------------------------------------------------------------------------
-- order_line_type
-----------------------------------------------------------------------------
drop table order_line_type;

CREATE TABLE order_line_type
(
                    id INTEGER NOT NULL,
                editable SMALLINT NOT NULL
);

ALTER TABLE order_line_type
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- order_period
-----------------------------------------------------------------------------
drop table order_period;

CREATE TABLE order_period
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER,
                    value INTEGER,
                    unit_id INTEGER,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE order_period
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- order_process
-----------------------------------------------------------------------------
drop table order_process;

CREATE TABLE order_process
(
                    id INTEGER NOT NULL,
                    order_id INTEGER,
                    invoice_id INTEGER,
                    billing_process_id INTEGER,
                    periods_included INTEGER,
                period_start DATE,
                period_end DATE,
                    is_review INTEGER NOT NULL,
                    origin INTEGER,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE order_process
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_uq_order_process_or_in ON order_process (order_id, invoice_id);
CREATE  INDEX ix_uq_order_process_or_bp ON order_process (order_id, billing_process_id);
CREATE  INDEX ix_order_process_in ON order_process (invoice_id);





-----------------------------------------------------------------------------
-- paper_invoice_batch
-----------------------------------------------------------------------------
drop table paper_invoice_batch;

CREATE TABLE paper_invoice_batch
(
                    id INTEGER NOT NULL,
                    total_invoices INTEGER NOT NULL,
                delivery_date DATE,
                is_self_managed SMALLINT NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE paper_invoice_batch
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- partner
-----------------------------------------------------------------------------
drop table partner;

CREATE TABLE partner
(
                    id INTEGER NOT NULL,
                    user_id INTEGER,
                balance NUMERIC (22,10) NOT NULL,
                total_payments NUMERIC (22,10) NOT NULL,
                total_refunds NUMERIC (22,10) NOT NULL,
                total_payouts NUMERIC (22,10) NOT NULL,
                percentage_rate NUMERIC (22,10),
                referral_fee NUMERIC (22,10),
                    fee_currency_id INTEGER,
                one_time SMALLINT NOT NULL,
                    period_unit_id INTEGER NOT NULL,
                    period_value INTEGER NOT NULL,
                next_payout_date DATE NOT NULL,
                due_payout NUMERIC (22,10),
                automatic_process SMALLINT NOT NULL,
                    related_clerk INTEGER,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE partner
    ADD PRIMARY KEY (id);


CREATE  INDEX partner_i_3 ON partner (user_id);





-----------------------------------------------------------------------------
-- partner_payout
-----------------------------------------------------------------------------
drop table partner_payout;

CREATE TABLE partner_payout
(
                    id INTEGER NOT NULL,
                starting_date DATE NOT NULL,
                ending_date DATE NOT NULL,
                payments_amount NUMERIC (22,10) NOT NULL,
                refunds_amount NUMERIC (22,10) NOT NULL,
                balance_left NUMERIC (22,10) NOT NULL,
                    payment_id INTEGER,
                    partner_id INTEGER,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE partner_payout
    ADD PRIMARY KEY (id);


CREATE  INDEX partner_payout_i_2 ON partner_payout (partner_id);





-----------------------------------------------------------------------------
-- partner_range
-----------------------------------------------------------------------------
drop table partner_range;

CREATE TABLE partner_range
(
                    id INTEGER NOT NULL,
                    partner_id INTEGER,
                percentage_rate NUMERIC (22,10),
                referral_fee NUMERIC (22,10),
                    range_from INTEGER NOT NULL,
                    range_to INTEGER NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE partner_range
    ADD PRIMARY KEY (id);


CREATE  INDEX partner_range_p ON partner_range (partner_id);





-----------------------------------------------------------------------------
-- payment
-----------------------------------------------------------------------------
drop table payment;

CREATE TABLE payment
(
                    id INTEGER NOT NULL,
                    user_id INTEGER,
                    attempt INTEGER,
                    result_id INTEGER,
                amount NUMERIC (22,10) NOT NULL,
                create_datetime TIMESTAMP NOT NULL,
                update_datetime TIMESTAMP,
                payment_date DATE,
                    method_id INTEGER NOT NULL,
                    credit_card_id INTEGER,
                deleted SMALLINT default 0 NOT NULL,
                is_refund SMALLINT default 0 NOT NULL,
                is_preauth SMALLINT default 0 NOT NULL,
                    payment_id INTEGER,
                    currency_id INTEGER NOT NULL,
                    payout_id INTEGER,
                    ach_id INTEGER,
                balance NUMERIC (22,10),
                    payment_period INTEGER,
                payment_notes VARCHAR (500),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE payment
    ADD PRIMARY KEY (id);


CREATE  INDEX payment_i_2 ON payment (user_id, create_datetime);
CREATE  INDEX payment_i_3 ON payment (user_id, balance);





-----------------------------------------------------------------------------
-- payment_authorization
-----------------------------------------------------------------------------
drop table payment_authorization;

CREATE TABLE payment_authorization
(
                    id INTEGER NOT NULL,
                    payment_id INTEGER,
                processor VARCHAR (40) NOT NULL,
                code1 VARCHAR (40) NOT NULL,
                code2 VARCHAR (40),
                code3 VARCHAR (40),
                approval_code VARCHAR (20),
                avs VARCHAR (20),
                transaction_id VARCHAR (20),
                md5 VARCHAR (100),
                card_code VARCHAR (100),
                create_datetime DATE NOT NULL,
                response_message VARCHAR (200),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE payment_authorization
    ADD PRIMARY KEY (id);


CREATE  INDEX create_datetime ON payment_authorization (create_datetime);
CREATE  INDEX transaction_id ON payment_authorization (transaction_id);
CREATE  INDEX ix_pa_payment ON payment_authorization (payment_id);





-----------------------------------------------------------------------------
-- payment_info_cheque
-----------------------------------------------------------------------------
drop table payment_info_cheque;

CREATE TABLE payment_info_cheque
(
                    id INTEGER NOT NULL,
                    payment_id INTEGER,
                bank VARCHAR (50),
                cheque_number VARCHAR (50),
                cheque_date DATE,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE payment_info_cheque
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- payment_invoice
-----------------------------------------------------------------------------
drop table payment_invoice;

CREATE TABLE payment_invoice
(
                    id INTEGER NOT NULL,
                    payment_id INTEGER,
                    invoice_id INTEGER,
                amount NUMERIC (22,10),
                create_datetime TIMESTAMP NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE payment_invoice
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_uq_payment_inv_map_pa_in ON payment_invoice (payment_id, invoice_id);





-----------------------------------------------------------------------------
-- payment_method
-----------------------------------------------------------------------------
drop table payment_method;

CREATE TABLE payment_method
(
                    id INTEGER NOT NULL
);

ALTER TABLE payment_method
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- payment_result
-----------------------------------------------------------------------------
drop table payment_result;

CREATE TABLE payment_result
(
                    id INTEGER NOT NULL
);

ALTER TABLE payment_result
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- period_unit
-----------------------------------------------------------------------------
drop table period_unit;

CREATE TABLE period_unit
(
                    id INTEGER NOT NULL
);

ALTER TABLE period_unit
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- permission
-----------------------------------------------------------------------------
drop table permission;

CREATE TABLE permission
(
                    id INTEGER NOT NULL,
                    type_id INTEGER NOT NULL,
                    foreign_id INTEGER
);

ALTER TABLE permission
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- permission_role_map
-----------------------------------------------------------------------------
drop table permission_role_map;

CREATE TABLE permission_role_map
(
                    permission_id INTEGER,
                    role_id INTEGER
);



CREATE  INDEX permission_role_map_i_2 ON permission_role_map (permission_id, role_id);





-----------------------------------------------------------------------------
-- permission_type
-----------------------------------------------------------------------------
drop table permission_type;

CREATE TABLE permission_type
(
                    id INTEGER NOT NULL,
                description VARCHAR (30) NOT NULL
);

ALTER TABLE permission_type
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- permission_user
-----------------------------------------------------------------------------
drop table permission_user;

CREATE TABLE permission_user
(
                    permission_id INTEGER,
                    user_id INTEGER,
                is_grant SMALLINT NOT NULL,
                    id INTEGER NOT NULL
);

ALTER TABLE permission_user
    ADD PRIMARY KEY (id);


CREATE  INDEX permission_user_map_i_2 ON permission_user (permission_id, user_id);





-----------------------------------------------------------------------------
-- pluggable_task
-----------------------------------------------------------------------------
drop table pluggable_task;

CREATE TABLE pluggable_task
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER NOT NULL,
                    type_id INTEGER,
                    processing_order INTEGER NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE pluggable_task
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- pluggable_task_parameter
-----------------------------------------------------------------------------
drop table pluggable_task_parameter;

CREATE TABLE pluggable_task_parameter
(
                    id INTEGER NOT NULL,
                    task_id INTEGER,
                name VARCHAR (50) NOT NULL,
                    int_value INTEGER,
                str_value VARCHAR (500),
                float_value NUMERIC (22,10),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE pluggable_task_parameter
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- pluggable_task_type
-----------------------------------------------------------------------------
drop table pluggable_task_type;

CREATE TABLE pluggable_task_type
(
                    id INTEGER NOT NULL,
                    category_id INTEGER NOT NULL,
                class_name VARCHAR (200) NOT NULL,
                    min_parameters INTEGER NOT NULL
);

ALTER TABLE pluggable_task_type
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- pluggable_task_type_category
-----------------------------------------------------------------------------
drop table pluggable_task_type_category;

CREATE TABLE pluggable_task_type_category
(
                    id INTEGER NOT NULL,
                description VARCHAR (50) NOT NULL,
                interface_name VARCHAR (200) NOT NULL
);

ALTER TABLE pluggable_task_type_category
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- preference
-----------------------------------------------------------------------------
drop table preference;

CREATE TABLE preference
(
                    id INTEGER NOT NULL,
                    type_id INTEGER,
                    table_id INTEGER NOT NULL,
                    foreign_id INTEGER NOT NULL,
                    int_value INTEGER,
                str_value VARCHAR (200),
                float_value NUMERIC (22,10)
);

ALTER TABLE preference
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- preference_type
-----------------------------------------------------------------------------
drop table preference_type;

CREATE TABLE preference_type
(
                    id INTEGER NOT NULL,
                    int_def_value INTEGER,
                str_def_value VARCHAR (200),
                float_def_value NUMERIC (22,10)
);

ALTER TABLE preference_type
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- promotion
-----------------------------------------------------------------------------
drop table promotion;

CREATE TABLE promotion
(
                    id INTEGER NOT NULL,
                    item_id INTEGER,
                code VARCHAR (50) NOT NULL,
                notes VARCHAR (200),
                once SMALLINT NOT NULL,
                since DATE,
                until DATE
);

ALTER TABLE promotion
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_promotion_code ON promotion (code);





-----------------------------------------------------------------------------
-- purchase_order
-----------------------------------------------------------------------------
drop table purchase_order;

CREATE TABLE purchase_order
(
                    id INTEGER NOT NULL,
                    user_id INTEGER,
                    period_id INTEGER,
                    billing_type_id INTEGER NOT NULL,
                active_since DATE,
                active_until DATE,
                cycle_start DATE,
                create_datetime TIMESTAMP NOT NULL,
                next_billable_day DATE,
                    created_by INTEGER,
                    status_id INTEGER NOT NULL,
                    currency_id INTEGER NOT NULL,
                deleted SMALLINT default 0 NOT NULL,
                notify SMALLINT,
                last_notified TIMESTAMP,
                    notification_step INTEGER,
                    due_date_unit_id INTEGER,
                    due_date_value INTEGER,
                df_fm SMALLINT,
                    anticipate_periods INTEGER,
                own_invoice SMALLINT,
                notes VARCHAR (200),
                notes_in_invoice SMALLINT,
                is_current SMALLINT,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE purchase_order
    ADD PRIMARY KEY (id);


CREATE  INDEX purchase_order_i_user ON purchase_order (user_id, deleted);
CREATE  INDEX purchase_order_i_notif ON purchase_order (active_until, notification_step);
CREATE  INDEX ix_purchase_order_date ON purchase_order (user_id, create_datetime);





-----------------------------------------------------------------------------
-- report
-----------------------------------------------------------------------------
drop table report;

CREATE TABLE report
(
                    id INTEGER NOT NULL,
                titlekey VARCHAR (50),
                instructionskey VARCHAR (50),
                tables_list VARCHAR (1000) NOT NULL,
                where_str VARCHAR (1000) NOT NULL,
                id_column SMALLINT NOT NULL,
                link VARCHAR (200),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE report
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- report_entity_map
-----------------------------------------------------------------------------
drop table report_entity_map;

CREATE TABLE report_entity_map
(
                    entity_id INTEGER,
                    report_id INTEGER
);



CREATE  INDEX report_entity_map_i_2 ON report_entity_map (entity_id, report_id);





-----------------------------------------------------------------------------
-- report_field
-----------------------------------------------------------------------------
drop table report_field;

CREATE TABLE report_field
(
                    id INTEGER NOT NULL,
                    report_id INTEGER,
                    report_user_id INTEGER,
                    position_number INTEGER NOT NULL,
                table_name VARCHAR (50) NOT NULL,
                column_name VARCHAR (50) NOT NULL,
                    order_position INTEGER,
                where_value VARCHAR (50),
                title_key VARCHAR (50),
                function_name VARCHAR (10),
                    is_grouped INTEGER NOT NULL,
                is_shown SMALLINT NOT NULL,
                data_type VARCHAR (10) NOT NULL,
                operator_value VARCHAR (2),
                functionable SMALLINT NOT NULL,
                selectable SMALLINT NOT NULL,
                ordenable SMALLINT NOT NULL,
                operatorable SMALLINT NOT NULL,
                whereable SMALLINT NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE report_field
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- report_type
-----------------------------------------------------------------------------
drop table report_type;

CREATE TABLE report_type
(
                    id INTEGER NOT NULL,
                showable SMALLINT NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE report_type
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- report_type_map
-----------------------------------------------------------------------------
drop table report_type_map;

CREATE TABLE report_type_map
(
                    report_id INTEGER,
                    type_id INTEGER
);








-----------------------------------------------------------------------------
-- report_user
-----------------------------------------------------------------------------
drop table report_user;

CREATE TABLE report_user
(
                    id INTEGER NOT NULL,
                    user_id INTEGER,
                    report_id INTEGER,
                create_datetime TIMESTAMP NOT NULL,
                title VARCHAR (50),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE report_user
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- role
-----------------------------------------------------------------------------
drop table role;

CREATE TABLE role
(
                    id INTEGER NOT NULL
);

ALTER TABLE role
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- user_credit_card_map
-----------------------------------------------------------------------------
drop table user_credit_card_map;

CREATE TABLE user_credit_card_map
(
                    user_id INTEGER,
                    credit_card_id INTEGER
);



CREATE  INDEX user_credit_card_map_i_2 ON user_credit_card_map (user_id, credit_card_id);





-----------------------------------------------------------------------------
-- user_role_map
-----------------------------------------------------------------------------
drop table user_role_map;

CREATE TABLE user_role_map
(
                    user_id INTEGER,
                    role_id INTEGER
);



CREATE  INDEX user_role_map_i_2 ON user_role_map (user_id, role_id);
CREATE  INDEX user_role_map_i_role ON user_role_map (role_id);





-----------------------------------------------------------------------------
-- mediation_cfg
-----------------------------------------------------------------------------
drop table mediation_cfg;

CREATE TABLE mediation_cfg
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER NOT NULL,
                create_datetime TIMESTAMP NOT NULL,
                name VARCHAR (50) NOT NULL,
                    order_value INTEGER NOT NULL,
                    pluggable_task_id INTEGER NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE mediation_cfg
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- mediation_process
-----------------------------------------------------------------------------
drop table mediation_process;

CREATE TABLE mediation_process
(
                    id INTEGER NOT NULL,
                    configuration_id INTEGER NOT NULL,
                start_datetime TIMESTAMP NOT NULL,
                end_datetime TIMESTAMP default 'NULL',
                    orders_affected INTEGER NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE mediation_process
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- mediation_order_map
-----------------------------------------------------------------------------
drop table mediation_order_map;

CREATE TABLE mediation_order_map
(
                    mediation_process_id INTEGER NOT NULL,
                    order_id INTEGER NOT NULL
);








-----------------------------------------------------------------------------
-- mediation_record
-----------------------------------------------------------------------------
drop table mediation_record;

CREATE TABLE mediation_record
(
                id_key VARCHAR (100) NOT NULL,
                start_datetime TIMESTAMP NOT NULL,
                    mediation_process_id INTEGER,
                    status_id INTEGER NOT NULL,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE mediation_record
    ADD PRIMARY KEY (id_key);


CREATE  INDEX mediation_record_i ON mediation_record (id_key, status_id);





-----------------------------------------------------------------------------
-- mediation_record_line
-----------------------------------------------------------------------------
drop table mediation_record_line;

CREATE TABLE mediation_record_line
(
                    id INTEGER NOT NULL,
                mediation_record_id VARCHAR (100) NOT NULL,
                    order_line_id INTEGER NOT NULL,
                event_date TIMESTAMP NOT NULL,
                amount NUMERIC (22,10) NOT NULL,
                quantity NUMERIC (22,10) NOT NULL,
                description VARCHAR (200),
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE mediation_record_line
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_mrl_order_line ON mediation_record_line (order_line_id);





-----------------------------------------------------------------------------
-- blacklist
-----------------------------------------------------------------------------
drop table blacklist;

CREATE TABLE blacklist
(
                    id INTEGER NOT NULL,
                    entity_id INTEGER NOT NULL,
                create_datetime TIMESTAMP NOT NULL,
                    type INTEGER NOT NULL,
                    source INTEGER NOT NULL,
                    credit_card INTEGER,
                    credit_card_id INTEGER,
                    contact_id INTEGER,
                    user_id INTEGER,
                    OPTLOCK INTEGER NOT NULL
);

ALTER TABLE blacklist
    ADD PRIMARY KEY (id);


CREATE  INDEX ix_blacklist_user_type ON blacklist (user_id, type);
CREATE  INDEX ix_blacklist_entity_type ON blacklist (entity_id, type);





-----------------------------------------------------------------------------
-- generic_status_type
-----------------------------------------------------------------------------
drop table generic_status_type;

CREATE TABLE generic_status_type
(
                id VARCHAR (40) NOT NULL
);

ALTER TABLE generic_status_type
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- generic_status
-----------------------------------------------------------------------------
drop table generic_status;

CREATE TABLE generic_status
(
                    id INTEGER NOT NULL,
                dtype VARCHAR (40) NOT NULL,
                    status_value INTEGER NOT NULL,
                can_login SMALLINT
);

ALTER TABLE generic_status
    ADD PRIMARY KEY (id);







-----------------------------------------------------------------------------
-- ach: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE ach
    ADD CONSTRAINT ach_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;


-----------------------------------------------------------------------------
-- ageing_entity_step: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE ageing_entity_step
    ADD CONSTRAINT ageing_entity_FK_1 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
;
ALTER TABLE ageing_entity_step
    ADD CONSTRAINT ageing_entity_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;


-----------------------------------------------------------------------------
-- base_user: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE base_user
    ADD CONSTRAINT base_user_FK_1 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
;
ALTER TABLE base_user
    ADD CONSTRAINT base_user_FK_2 FOREIGN KEY (subscriber_status)
    REFERENCES generic_status (id)
;
ALTER TABLE base_user
    ADD CONSTRAINT base_user_FK_3 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;
ALTER TABLE base_user
    ADD CONSTRAINT base_user_FK_4 FOREIGN KEY (language_id)
    REFERENCES language (id)
;
ALTER TABLE base_user
    ADD CONSTRAINT base_user_FK_5 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;


-----------------------------------------------------------------------------
-- billing_process: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE billing_process
    ADD CONSTRAINT billing_proce_FK_1 FOREIGN KEY (period_unit_id)
    REFERENCES period_unit (id)
;
ALTER TABLE billing_process
    ADD CONSTRAINT billing_proce_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;
ALTER TABLE billing_process
    ADD CONSTRAINT billing_proce_FK_3 FOREIGN KEY (paper_invoice_batch_id)
    REFERENCES paper_invoice_batch (id)
;


-----------------------------------------------------------------------------
-- billing_process_configuration: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE billing_process_configuration
    ADD CONSTRAINT billing_proce_FK_1 FOREIGN KEY (period_unit_id)
    REFERENCES period_unit (id)
;
ALTER TABLE billing_process_configuration
    ADD CONSTRAINT billing_proce_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;


-----------------------------------------------------------------------------
-- process_run: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE process_run
    ADD CONSTRAINT process_run_FK_1 FOREIGN KEY (process_id)
    REFERENCES billing_process (id)
;
ALTER TABLE process_run
    ADD CONSTRAINT process_run_FK_2 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
;


-----------------------------------------------------------------------------
-- process_run_total: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE process_run_total
    ADD CONSTRAINT process_run_t_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;
ALTER TABLE process_run_total
    ADD CONSTRAINT process_run_t_FK_2 FOREIGN KEY (process_run_id)
    REFERENCES process_run (id)
;


-----------------------------------------------------------------------------
-- process_run_total_pm: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE process_run_total_pm
    ADD CONSTRAINT process_run_t_FK_1 FOREIGN KEY (payment_method_id)
    REFERENCES payment_method (id)
;


-----------------------------------------------------------------------------
-- process_run_user: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE process_run_user
    ADD CONSTRAINT process_run_u_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;
ALTER TABLE process_run_user
    ADD CONSTRAINT process_run_u_FK_2 FOREIGN KEY (process_run_id)
    REFERENCES process_run (id)
;


-----------------------------------------------------------------------------
-- contact: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- contact_field: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE contact_field
    ADD CONSTRAINT contact_field_FK_1 FOREIGN KEY (contact_id)
    REFERENCES contact (id)
;
ALTER TABLE contact_field
    ADD CONSTRAINT contact_field_FK_2 FOREIGN KEY (type_id)
    REFERENCES contact_field_type (id)
;


-----------------------------------------------------------------------------
-- contact_field_type: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE contact_field_type
    ADD CONSTRAINT contact_field_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;


-----------------------------------------------------------------------------
-- contact_map: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE contact_map
    ADD CONSTRAINT contact_map_FK_1 FOREIGN KEY (table_id)
    REFERENCES jbilling_table (id)
;
ALTER TABLE contact_map
    ADD CONSTRAINT contact_map_FK_2 FOREIGN KEY (type_id)
    REFERENCES contact_type (id)
;
ALTER TABLE contact_map
    ADD CONSTRAINT contact_map_FK_3 FOREIGN KEY (contact_id)
    REFERENCES contact (id)
;


-----------------------------------------------------------------------------
-- contact_type: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE contact_type
    ADD CONSTRAINT contact_type_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;


-----------------------------------------------------------------------------
-- country: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- credit_card: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- currency: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- currency_entity_map: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE currency_entity_map
    ADD CONSTRAINT currency_enti_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;
ALTER TABLE currency_entity_map
    ADD CONSTRAINT currency_enti_FK_2 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;


-----------------------------------------------------------------------------
-- currency_exchange: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE currency_exchange
    ADD CONSTRAINT currency_exch_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;


-----------------------------------------------------------------------------
-- customer: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE customer
    ADD CONSTRAINT customer_FK_1 FOREIGN KEY (invoice_delivery_method_id)
    REFERENCES invoice_delivery_method (id)
;
ALTER TABLE customer
    ADD CONSTRAINT customer_FK_2 FOREIGN KEY (partner_id)
    REFERENCES partner (id)
;
ALTER TABLE customer
    ADD CONSTRAINT customer_FK_3 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;


-----------------------------------------------------------------------------
-- entity: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE entity
    ADD CONSTRAINT entity_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;
ALTER TABLE entity
    ADD CONSTRAINT entity_FK_2 FOREIGN KEY (language_id)
    REFERENCES language (id)
;


-----------------------------------------------------------------------------
-- entity_delivery_method_map: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE entity_delivery_method_map
    ADD CONSTRAINT entity_delive_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;
ALTER TABLE entity_delivery_method_map
    ADD CONSTRAINT entity_delive_FK_2 FOREIGN KEY (method_id)
    REFERENCES invoice_delivery_method (id)
;


-----------------------------------------------------------------------------
-- entity_payment_method_map: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE entity_payment_method_map
    ADD CONSTRAINT entity_paymen_FK_1 FOREIGN KEY (payment_method_id)
    REFERENCES payment_method (id)
;
ALTER TABLE entity_payment_method_map
    ADD CONSTRAINT entity_paymen_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;


-----------------------------------------------------------------------------
-- event_log: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_1 FOREIGN KEY (module_id)
    REFERENCES event_log_module (id)
;
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_3 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_4 FOREIGN KEY (affected_user_id)
    REFERENCES base_user (id)
;
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_5 FOREIGN KEY (table_id)
    REFERENCES jbilling_table (id)
;
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_6 FOREIGN KEY (message_id)
    REFERENCES event_log_message (id)
;


-----------------------------------------------------------------------------
-- event_log_message: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- event_log_module: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- international_description: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE international_description
    ADD CONSTRAINT international_FK_1 FOREIGN KEY (language_id)
    REFERENCES language (id)
;
ALTER TABLE international_description
    ADD CONSTRAINT international_FK_2 FOREIGN KEY (table_id)
    REFERENCES jbilling_table (id)
;


-----------------------------------------------------------------------------
-- invoice: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE invoice
    ADD CONSTRAINT invoice_FK_1 FOREIGN KEY (billing_process_id)
    REFERENCES billing_process (id)
;
ALTER TABLE invoice
    ADD CONSTRAINT invoice_FK_2 FOREIGN KEY (paper_invoice_batch_id)
    REFERENCES paper_invoice_batch (id)
;
ALTER TABLE invoice
    ADD CONSTRAINT invoice_FK_3 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;
ALTER TABLE invoice
    ADD CONSTRAINT invoice_FK_4 FOREIGN KEY (delegated_invoice_id)
    REFERENCES invoice (id)
;
ALTER TABLE invoice
    ADD CONSTRAINT invoice_FK_5 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
;


-----------------------------------------------------------------------------
-- invoice_delivery_method: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- invoice_line: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE invoice_line
    ADD CONSTRAINT invoice_line_FK_1 FOREIGN KEY (invoice_id)
    REFERENCES invoice (id)
;
ALTER TABLE invoice_line
    ADD CONSTRAINT invoice_line_FK_2 FOREIGN KEY (item_id)
    REFERENCES item (id)
;
ALTER TABLE invoice_line
    ADD CONSTRAINT invoice_line_FK_3 FOREIGN KEY (type_id)
    REFERENCES invoice_line_type (id)
;


-----------------------------------------------------------------------------
-- invoice_line_type: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- item: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE item
    ADD CONSTRAINT item_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;


-----------------------------------------------------------------------------
-- item_price: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE item_price
    ADD CONSTRAINT item_price_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;
ALTER TABLE item_price
    ADD CONSTRAINT item_price_FK_2 FOREIGN KEY (item_id)
    REFERENCES item (id)
;


-----------------------------------------------------------------------------
-- item_type: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE item_type
    ADD CONSTRAINT item_type_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;


-----------------------------------------------------------------------------
-- item_type_map: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE item_type_map
    ADD CONSTRAINT item_type_map_FK_1 FOREIGN KEY (item_id)
    REFERENCES item (id)
;
ALTER TABLE item_type_map
    ADD CONSTRAINT item_type_map_FK_2 FOREIGN KEY (type_id)
    REFERENCES item_type (id)
;


-----------------------------------------------------------------------------
-- jbilling_table: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- jbilling_seqs: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- language: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- list: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- list_entity: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE list_entity
    ADD CONSTRAINT list_entity_FK_1 FOREIGN KEY (list_id)
    REFERENCES list (id)
;
ALTER TABLE list_entity
    ADD CONSTRAINT list_entity_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;


-----------------------------------------------------------------------------
-- list_field: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE list_field
    ADD CONSTRAINT list_field_FK_1 FOREIGN KEY (list_id)
    REFERENCES list (id)
;


-----------------------------------------------------------------------------
-- list_field_entity: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE list_field_entity
    ADD CONSTRAINT list_field_en_FK_1 FOREIGN KEY (list_entity_id)
    REFERENCES list_entity (id)
;
ALTER TABLE list_field_entity
    ADD CONSTRAINT list_field_en_FK_2 FOREIGN KEY (list_field_id)
    REFERENCES list_field (id)
;


-----------------------------------------------------------------------------
-- menu_option: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE menu_option
    ADD CONSTRAINT menu_option_FK_1 FOREIGN KEY (parent_id)
    REFERENCES menu_option (id)
;


-----------------------------------------------------------------------------
-- notification_message: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE notification_message
    ADD CONSTRAINT notification__FK_1 FOREIGN KEY (language_id)
    REFERENCES language (id)
;
ALTER TABLE notification_message
    ADD CONSTRAINT notification__FK_2 FOREIGN KEY (type_id)
    REFERENCES notification_message_type (id)
;
ALTER TABLE notification_message
    ADD CONSTRAINT notification__FK_3 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;


-----------------------------------------------------------------------------
-- notification_message_arch: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- notification_message_arch_line: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE notification_message_arch_line
    ADD CONSTRAINT notif_mess_arch_line_FK_1 FOREIGN KEY (message_archive_id)
    REFERENCES notification_message_arch (id)
;


-----------------------------------------------------------------------------
-- notification_message_line: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE notification_message_line
    ADD CONSTRAINT notification__FK_1 FOREIGN KEY (message_section_id)
    REFERENCES notification_message_section (id)
;


-----------------------------------------------------------------------------
-- notification_message_section: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE notification_message_section
    ADD CONSTRAINT notification__FK_1 FOREIGN KEY (message_id)
    REFERENCES notification_message (id)
;


-----------------------------------------------------------------------------
-- notification_message_type: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- order_billing_type: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- order_line: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE order_line
    ADD CONSTRAINT order_line_FK_1 FOREIGN KEY (item_id)
    REFERENCES item (id)
;
ALTER TABLE order_line
    ADD CONSTRAINT order_line_FK_2 FOREIGN KEY (order_id)
    REFERENCES purchase_order (id)
;
ALTER TABLE order_line
    ADD CONSTRAINT order_line_FK_3 FOREIGN KEY (type_id)
    REFERENCES order_line_type (id)
;


-----------------------------------------------------------------------------
-- order_line_type: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- order_period: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE order_period
    ADD CONSTRAINT order_period_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;
ALTER TABLE order_period
    ADD CONSTRAINT order_period_FK_2 FOREIGN KEY (unit_id)
    REFERENCES period_unit (id)
;


-----------------------------------------------------------------------------
-- order_process: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE order_process
    ADD CONSTRAINT order_process_FK_1 FOREIGN KEY (order_id)
    REFERENCES purchase_order (id)
;


-----------------------------------------------------------------------------
-- paper_invoice_batch: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- partner: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE partner
    ADD CONSTRAINT partner_FK_1 FOREIGN KEY (period_unit_id)
    REFERENCES period_unit (id)
;
ALTER TABLE partner
    ADD CONSTRAINT partner_FK_2 FOREIGN KEY (fee_currency_id)
    REFERENCES currency (id)
;
ALTER TABLE partner
    ADD CONSTRAINT partner_FK_3 FOREIGN KEY (related_clerk)
    REFERENCES base_user (id)
;
ALTER TABLE partner
    ADD CONSTRAINT partner_FK_4 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;


-----------------------------------------------------------------------------
-- partner_payout: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE partner_payout
    ADD CONSTRAINT partner_payou_FK_1 FOREIGN KEY (partner_id)
    REFERENCES partner (id)
;


-----------------------------------------------------------------------------
-- partner_range: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- payment: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_1 FOREIGN KEY (ach_id)
    REFERENCES ach (id)
;
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_2 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_3 FOREIGN KEY (payment_id)
    REFERENCES payment (id)
;
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_4 FOREIGN KEY (credit_card_id)
    REFERENCES credit_card (id)
;
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_5 FOREIGN KEY (result_id)
    REFERENCES payment_result (id)
;
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_6 FOREIGN KEY (method_id)
    REFERENCES payment_method (id)
;


-----------------------------------------------------------------------------
-- payment_authorization: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE payment_authorization
    ADD CONSTRAINT payment_autho_FK_1 FOREIGN KEY (payment_id)
    REFERENCES payment (id)
;


-----------------------------------------------------------------------------
-- payment_info_cheque: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE payment_info_cheque
    ADD CONSTRAINT payment_info__FK_1 FOREIGN KEY (payment_id)
    REFERENCES payment (id)
;


-----------------------------------------------------------------------------
-- payment_invoice: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE payment_invoice
    ADD CONSTRAINT payment_invoi_FK_1 FOREIGN KEY (invoice_id)
    REFERENCES invoice (id)
;
ALTER TABLE payment_invoice
    ADD CONSTRAINT payment_invoi_FK_2 FOREIGN KEY (payment_id)
    REFERENCES payment (id)
;


-----------------------------------------------------------------------------
-- payment_method: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- payment_result: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- period_unit: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- permission: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE permission
    ADD CONSTRAINT permission_FK_1 FOREIGN KEY (type_id)
    REFERENCES permission_type (id)
;


-----------------------------------------------------------------------------
-- permission_role_map: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE permission_role_map
    ADD CONSTRAINT permission_ro_FK_1 FOREIGN KEY (role_id)
    REFERENCES role (id)
;
ALTER TABLE permission_role_map
    ADD CONSTRAINT permission_ro_FK_2 FOREIGN KEY (permission_id)
    REFERENCES permission (id)
;


-----------------------------------------------------------------------------
-- permission_type: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- permission_user: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE permission_user
    ADD CONSTRAINT permission_us_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;
ALTER TABLE permission_user
    ADD CONSTRAINT permission_us_FK_2 FOREIGN KEY (permission_id)
    REFERENCES permission (id)
;


-----------------------------------------------------------------------------
-- pluggable_task: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE pluggable_task
    ADD CONSTRAINT pluggable_tas_FK_1 FOREIGN KEY (type_id)
    REFERENCES pluggable_task_type (id)
;
ALTER TABLE pluggable_task
    ADD CONSTRAINT pluggable_tas_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;


-----------------------------------------------------------------------------
-- pluggable_task_parameter: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE pluggable_task_parameter
    ADD CONSTRAINT pluggable_tas_FK_1 FOREIGN KEY (task_id)
    REFERENCES pluggable_task (id)
;


-----------------------------------------------------------------------------
-- pluggable_task_type: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE pluggable_task_type
    ADD CONSTRAINT pluggable_tas_FK_1 FOREIGN KEY (category_id)
    REFERENCES pluggable_task_type_category (id)
;


-----------------------------------------------------------------------------
-- pluggable_task_type_category: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- preference: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE preference
    ADD CONSTRAINT preference_FK_1 FOREIGN KEY (type_id)
    REFERENCES preference_type (id)
;
ALTER TABLE preference
    ADD CONSTRAINT preference_FK_2 FOREIGN KEY (table_id)
    REFERENCES jbilling_table (id)
;


-----------------------------------------------------------------------------
-- preference_type: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- promotion: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE promotion
    ADD CONSTRAINT promotion_FK_1 FOREIGN KEY (item_id)
    REFERENCES item (id)
;


-----------------------------------------------------------------------------
-- purchase_order: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_orde_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_orde_FK_2 FOREIGN KEY (billing_type_id)
    REFERENCES order_billing_type (id)
;
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_orde_FK_3 FOREIGN KEY (period_id)
    REFERENCES order_period (id)
;
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_orde_FK_4 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_orde_FK_5 FOREIGN KEY (created_by)
    REFERENCES base_user (id)
;
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_orde_FK_6 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
;


-----------------------------------------------------------------------------
-- report: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- report_entity_map: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE report_entity_map
    ADD CONSTRAINT report_entity_FK_1 FOREIGN KEY (report_id)
    REFERENCES report (id)
;
ALTER TABLE report_entity_map
    ADD CONSTRAINT report_entity_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;


-----------------------------------------------------------------------------
-- report_field: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE report_field
    ADD CONSTRAINT report_field_FK_1 FOREIGN KEY (report_id)
    REFERENCES report (id)
;


-----------------------------------------------------------------------------
-- report_type: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- report_type_map: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE report_type_map
    ADD CONSTRAINT report_type_m_FK_1 FOREIGN KEY (type_id)
    REFERENCES report_type (id)
;
ALTER TABLE report_type_map
    ADD CONSTRAINT report_type_m_FK_2 FOREIGN KEY (report_id)
    REFERENCES report (id)
;


-----------------------------------------------------------------------------
-- report_user: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE report_user
    ADD CONSTRAINT report_user_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;
ALTER TABLE report_user
    ADD CONSTRAINT report_user_FK_2 FOREIGN KEY (report_id)
    REFERENCES report (id)
;


-----------------------------------------------------------------------------
-- role: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- user_credit_card_map: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- user_role_map: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE user_role_map
    ADD CONSTRAINT user_role_map_FK_1 FOREIGN KEY (role_id)
    REFERENCES role (id)
;
ALTER TABLE user_role_map
    ADD CONSTRAINT user_role_map_FK_2 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;


-----------------------------------------------------------------------------
-- mediation_cfg: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE mediation_cfg
    ADD CONSTRAINT mediation_cfg_FK_1 FOREIGN KEY (pluggable_task_id)
    REFERENCES pluggable_task (id)
;


-----------------------------------------------------------------------------
-- mediation_process: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE mediation_process
    ADD CONSTRAINT mediation_pro_FK_1 FOREIGN KEY (configuration_id)
    REFERENCES mediation_cfg (id)
;


-----------------------------------------------------------------------------
-- mediation_order_map: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE mediation_order_map
    ADD CONSTRAINT mediation_ord_FK_1 FOREIGN KEY (mediation_process_id)
    REFERENCES mediation_process (id)
;
ALTER TABLE mediation_order_map
    ADD CONSTRAINT mediation_ord_FK_2 FOREIGN KEY (order_id)
    REFERENCES purchase_order (id)
;


-----------------------------------------------------------------------------
-- mediation_record: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE mediation_record
    ADD CONSTRAINT mediation_rec_FK_1 FOREIGN KEY (mediation_process_id)
    REFERENCES mediation_process (id)
;
ALTER TABLE mediation_record
    ADD CONSTRAINT mediation_rec_FK_2 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
;


-----------------------------------------------------------------------------
-- mediation_record_line: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE mediation_record_line
    ADD CONSTRAINT mediation_rec_FK_1 FOREIGN KEY (mediation_record_id)
    REFERENCES mediation_record (id_key)
;
ALTER TABLE mediation_record_line
    ADD CONSTRAINT mediation_rec_FK_2 FOREIGN KEY (order_line_id)
    REFERENCES order_line (id)
;


-----------------------------------------------------------------------------
-- blacklist: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE blacklist
    ADD CONSTRAINT blacklist_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;
ALTER TABLE blacklist
    ADD CONSTRAINT blacklist_FK_2 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;


-----------------------------------------------------------------------------
-- generic_status_type: FOREIGN KEYS
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- generic_status: FOREIGN KEYS
-----------------------------------------------------------------------------
ALTER TABLE generic_status
    ADD CONSTRAINT generic_statu_FK_1 FOREIGN KEY (dtype)
    REFERENCES generic_status_type (id)
;

