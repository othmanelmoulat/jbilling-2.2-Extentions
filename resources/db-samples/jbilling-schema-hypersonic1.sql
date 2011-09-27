
-----------------------------------------------------------------------------
-- ach
-----------------------------------------------------------------------------
drop table ach if exists;

CREATE TABLE ach
(
    id INTEGER NOT NULL,
    user_id INTEGER,
    aba_routing VARCHAR(40) NOT NULL,
    bank_account VARCHAR(60) NOT NULL,
    account_type INTEGER NOT NULL,
    bank_name VARCHAR(50) NOT NULL,
    account_name VARCHAR(100) NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ach_i_2 ON ach (user_id);
-----------------------------------------------------------------------------
-- ageing_entity_step
-----------------------------------------------------------------------------
drop table ageing_entity_step if exists;

CREATE TABLE ageing_entity_step
(
    id INTEGER NOT NULL,
    entity_id INTEGER,
    status_id INTEGER,
    days INTEGER NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- base_user
-----------------------------------------------------------------------------
drop table base_user if exists;

CREATE TABLE base_user
(
    id INTEGER NOT NULL,
    entity_id INTEGER,
    password VARCHAR(40),
    deleted SMALLINT default 0 NOT NULL,
    language_id INTEGER,
    status_id INTEGER,
    subscriber_status INTEGER default 1,
    currency_id INTEGER,
    create_datetime TIMESTAMP NOT NULL,
    last_status_change TIMESTAMP,
    last_login TIMESTAMP,
    user_name VARCHAR(50),
    failed_attempts INTEGER default 0 NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_base_user_un ON base_user (entity_id, user_name);
-----------------------------------------------------------------------------
-- billing_process
-----------------------------------------------------------------------------
drop table billing_process if exists;

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
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- billing_process_configuration
-----------------------------------------------------------------------------
drop table billing_process_configuration if exists;

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
    auto_payment_application INTEGER default 0 NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- process_run
-----------------------------------------------------------------------------
drop table process_run if exists;

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
    status_id INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX bp_run_process_ix ON process_run (process_id);
-----------------------------------------------------------------------------
-- process_run_total
-----------------------------------------------------------------------------
drop table process_run_total if exists;

CREATE TABLE process_run_total
(
    id INTEGER NOT NULL,
    process_run_id INTEGER,
    currency_id INTEGER NOT NULL,
    total_invoiced NUMERIC(22,10),
    total_paid NUMERIC(22,10),
    total_not_paid NUMERIC(22,10),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX bp_run_total_run_ix ON process_run_total (process_run_id);
-----------------------------------------------------------------------------
-- process_run_total_pm
-----------------------------------------------------------------------------
drop table process_run_total_pm if exists;

CREATE TABLE process_run_total_pm
(
    id INTEGER NOT NULL,
    process_run_total_id INTEGER,
    payment_method_id INTEGER,
    total NUMERIC(22,10) NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX bp_pm_index_total ON process_run_total_pm (process_run_total_id);
-----------------------------------------------------------------------------
-- process_run_user
-----------------------------------------------------------------------------
drop table process_run_user if exists;

CREATE TABLE process_run_user
(
    id INTEGER NOT NULL,
    process_run_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    status INTEGER NOT NULL,
    created DATE NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX bp_run_user_run_ix ON process_run_user (process_run_id);
CREATE  INDEX bp_run_user_user_ix ON process_run_user (user_id);
-----------------------------------------------------------------------------
-- contact
-----------------------------------------------------------------------------
drop table contact if exists;

CREATE TABLE contact
(
    id INTEGER NOT NULL,
    organization_name VARCHAR(200),
    street_addres1 VARCHAR(100),
    street_addres2 VARCHAR(100),
    city VARCHAR(50),
    state_province VARCHAR(30),
    postal_code VARCHAR(15),
    country_code VARCHAR(2),
    last_name VARCHAR(30),
    first_name VARCHAR(30),
    person_initial VARCHAR(5),
    person_title VARCHAR(40),
    phone_country_code INTEGER,
    phone_area_code INTEGER,
    phone_phone_number VARCHAR(20),
    fax_country_code INTEGER,
    fax_area_code INTEGER,
    fax_phone_number VARCHAR(20),
    email VARCHAR(200),
    create_datetime TIMESTAMP NOT NULL,
    deleted SMALLINT default 0 NOT NULL,
    notification_include SMALLINT default 1,
    user_id INTEGER,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

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
drop table contact_field if exists;

CREATE TABLE contact_field
(
    id INTEGER NOT NULL,
    type_id INTEGER,
    contact_id INTEGER,
    content VARCHAR(100) NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_contact_field_cid ON contact_field (contact_id);
CREATE  INDEX ix_contact_field_content ON contact_field (content);
-----------------------------------------------------------------------------
-- contact_field_type
-----------------------------------------------------------------------------
drop table contact_field_type if exists;

CREATE TABLE contact_field_type
(
    id INTEGER NOT NULL,
    entity_id INTEGER,
    prompt_key VARCHAR(50) NOT NULL,
    data_type VARCHAR(10) NOT NULL,
    customer_readonly SMALLINT,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_cf_type_entity ON contact_field_type (entity_id);
-----------------------------------------------------------------------------
-- contact_map
-----------------------------------------------------------------------------
drop table contact_map if exists;

CREATE TABLE contact_map
(
    id INTEGER NOT NULL,
    contact_id INTEGER,
    type_id INTEGER NOT NULL,
    table_id INTEGER NOT NULL,
    foreign_id INTEGER NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX contact_map_i_3 ON contact_map (contact_id);
CREATE  INDEX contact_map_i_1 ON contact_map (table_id, foreign_id, type_id);
-----------------------------------------------------------------------------
-- contact_type
-----------------------------------------------------------------------------
drop table contact_type if exists;

CREATE TABLE contact_type
(
    id INTEGER NOT NULL,
    entity_id INTEGER,
    is_primary SMALLINT,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- country
-----------------------------------------------------------------------------
drop table country if exists;

CREATE TABLE country
(
    id INTEGER NOT NULL,
    code VARCHAR(2) NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- credit_card
-----------------------------------------------------------------------------
drop table credit_card if exists;

CREATE TABLE credit_card
(
    id INTEGER NOT NULL,
    cc_number VARCHAR(100) NOT NULL,
    cc_number_plain VARCHAR(20),
    cc_expiry DATE NOT NULL,
    name VARCHAR(150),
    cc_type INTEGER NOT NULL,
    deleted SMALLINT default 0 NOT NULL,
    gateway_key VARCHAR(100),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_cc_number ON credit_card (cc_number_plain);
CREATE  INDEX ix_cc_number_encrypted ON credit_card (cc_number);
-----------------------------------------------------------------------------
-- currency
-----------------------------------------------------------------------------
drop table currency if exists;

CREATE TABLE currency
(
    id INTEGER NOT NULL,
    symbol VARCHAR(10) NOT NULL,
    code VARCHAR(3) NOT NULL,
    country_code VARCHAR(2) NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- currency_entity_map
-----------------------------------------------------------------------------
drop table currency_entity_map if exists;

CREATE TABLE currency_entity_map
(
    currency_id INTEGER,
    entity_id INTEGER
);

CREATE  INDEX currency_entity_map_i_2 ON currency_entity_map (currency_id, entity_id);
-----------------------------------------------------------------------------
-- currency_exchange
-----------------------------------------------------------------------------
drop table currency_exchange if exists;

CREATE TABLE currency_exchange
(
    id INTEGER NOT NULL,
    entity_id INTEGER,
    currency_id INTEGER,
    rate NUMERIC(22,10) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- customer
-----------------------------------------------------------------------------
drop table customer if exists;

CREATE TABLE customer
(
    id INTEGER NOT NULL,
    user_id INTEGER,
    partner_id INTEGER,
    referral_fee_paid SMALLINT,
    invoice_delivery_method_id INTEGER NOT NULL,
    notes VARCHAR(1000),
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
    dynamic_balance NUMERIC(22,10),
    credit_limit NUMERIC(22,10),
    auto_recharge NUMERIC(22,10),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX customer_i_2 ON customer (user_id);
-----------------------------------------------------------------------------
-- entity
-----------------------------------------------------------------------------
drop table entity if exists;

CREATE TABLE entity
(
    id INTEGER NOT NULL,
    external_id VARCHAR(20),
    description VARCHAR(100) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    language_id INTEGER NOT NULL,
    currency_id INTEGER NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- entity_delivery_method_map
-----------------------------------------------------------------------------
drop table entity_delivery_method_map if exists;

CREATE TABLE entity_delivery_method_map
(
    method_id INTEGER,
    entity_id INTEGER
);


-----------------------------------------------------------------------------
-- entity_payment_method_map
-----------------------------------------------------------------------------
drop table entity_payment_method_map if exists;

CREATE TABLE entity_payment_method_map
(
    entity_id INTEGER,
    payment_method_id INTEGER
);


-----------------------------------------------------------------------------
-- event_log
-----------------------------------------------------------------------------
drop table event_log if exists;

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
    old_str VARCHAR(1000),
    old_date TIMESTAMP,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_el_main ON event_log (module_id, message_id, create_datetime);
-----------------------------------------------------------------------------
-- event_log_message
-----------------------------------------------------------------------------
drop table event_log_message if exists;

CREATE TABLE event_log_message
(
    id INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- event_log_module
-----------------------------------------------------------------------------
drop table event_log_module if exists;

CREATE TABLE event_log_module
(
    id INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- international_description
-----------------------------------------------------------------------------
drop table international_description if exists;

CREATE TABLE international_description
(
    table_id INTEGER NOT NULL,
    foreign_id INTEGER NOT NULL,
    psudo_column VARCHAR(20) NOT NULL,
    language_id INTEGER NOT NULL,
    content VARCHAR(4000) NOT NULL,
    PRIMARY KEY(table_id,foreign_id,psudo_column,language_id)
);

CREATE  INDEX international_description_i_2 ON international_description (table_id, foreign_id, language_id);
CREATE  INDEX int_description_i_lan ON international_description (language_id);
-----------------------------------------------------------------------------
-- invoice
-----------------------------------------------------------------------------
drop table invoice if exists;

CREATE TABLE invoice
(
    id INTEGER NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    billing_process_id INTEGER,
    user_id INTEGER,
    status_id INTEGER NOT NULL,
    delegated_invoice_id INTEGER,
    due_date DATE NOT NULL,
    total NUMERIC(22,10) NOT NULL,
    payment_attempts INTEGER default 0 NOT NULL,
    balance NUMERIC(22,10),
    carried_balance NUMERIC(22,10) NOT NULL,
    in_process_payment SMALLINT default 1 NOT NULL,
    is_review INTEGER NOT NULL,
    currency_id INTEGER NOT NULL,
    deleted SMALLINT default 0 NOT NULL,
    paper_invoice_batch_id INTEGER,
    customer_notes VARCHAR(1000),
    public_number VARCHAR(40),
    last_reminder DATE,
    overdue_step INTEGER,
    create_timestamp TIMESTAMP NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_invoice_user_id ON invoice (user_id, deleted);
CREATE  INDEX ix_invoice_date ON invoice (create_datetime);
CREATE  INDEX ix_invoice_number ON invoice (user_id, public_number);
CREATE  INDEX ix_invoice_due_date ON invoice (user_id, due_date);
CREATE  INDEX ix_invoice_ts ON invoice (create_timestamp, user_id);
CREATE  INDEX ix_invoice_process ON invoice (billing_process_id);
-----------------------------------------------------------------------------
-- invoice_delivery_method
-----------------------------------------------------------------------------
drop table invoice_delivery_method if exists;

CREATE TABLE invoice_delivery_method
(
    id INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- invoice_line
-----------------------------------------------------------------------------
drop table invoice_line if exists;

CREATE TABLE invoice_line
(
    id INTEGER NOT NULL,
    invoice_id INTEGER,
    type_id INTEGER,
    amount NUMERIC(22,10) NOT NULL,
    quantity NUMERIC(22,10),
    price NUMERIC(22,10),
    deleted SMALLINT default 0 NOT NULL,
    item_id INTEGER,
    description VARCHAR(1000),
    source_user_id INTEGER,
    is_percentage SMALLINT default 0 NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_invoice_line_invoice_id ON invoice_line (invoice_id);
-----------------------------------------------------------------------------
-- invoice_line_type
-----------------------------------------------------------------------------
drop table invoice_line_type if exists;

CREATE TABLE invoice_line_type
(
    id INTEGER NOT NULL,
    description VARCHAR(50) NOT NULL,
    order_position INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- item
-----------------------------------------------------------------------------
drop table item if exists;

CREATE TABLE item
(
    id INTEGER NOT NULL,
    internal_number VARCHAR(50),
    entity_id INTEGER,
    percentage NUMERIC(22,10),
    price_manual SMALLINT NOT NULL,
    deleted SMALLINT default 0 NOT NULL,
    has_decimals SMALLINT default 0 NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_item_ent ON item (entity_id, internal_number);
-----------------------------------------------------------------------------
-- item_price
-----------------------------------------------------------------------------
drop table item_price if exists;

CREATE TABLE item_price
(
    id INTEGER NOT NULL,
    item_id INTEGER,
    currency_id INTEGER,
    price NUMERIC(22,10) NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- item_type
-----------------------------------------------------------------------------
drop table item_type if exists;

CREATE TABLE item_type
(
    id INTEGER NOT NULL,
    entity_id INTEGER NOT NULL,
    description VARCHAR(100),
    order_line_type_id INTEGER NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- item_type_map
-----------------------------------------------------------------------------
drop table item_type_map if exists;

CREATE TABLE item_type_map
(
    item_id INTEGER,
    type_id INTEGER
);


-----------------------------------------------------------------------------
-- jbilling_table
-----------------------------------------------------------------------------
drop table jbilling_table if exists;

CREATE TABLE jbilling_table
(
    id INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- jbilling_seqs
-----------------------------------------------------------------------------
drop table jbilling_seqs if exists;

CREATE TABLE jbilling_seqs
(
    name VARCHAR(50) NOT NULL,
    next_id INTEGER default 0 NOT NULL
);


-----------------------------------------------------------------------------
-- language
-----------------------------------------------------------------------------
drop table language if exists;

CREATE TABLE language
(
    id INTEGER NOT NULL,
    code VARCHAR(2) NOT NULL,
    description VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- list
-----------------------------------------------------------------------------
drop table list if exists;

CREATE TABLE list
(
    id INTEGER NOT NULL,
    legacy_name VARCHAR(30),
    title_key VARCHAR(100) NOT NULL,
    instr_key VARCHAR(100),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- list_entity
-----------------------------------------------------------------------------
drop table list_entity if exists;

CREATE TABLE list_entity
(
    id INTEGER NOT NULL,
    list_id INTEGER,
    entity_id INTEGER NOT NULL,
    total_records INTEGER NOT NULL,
    last_update DATE NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- list_field
-----------------------------------------------------------------------------
drop table list_field if exists;

CREATE TABLE list_field
(
    id INTEGER NOT NULL,
    list_id INTEGER,
    title_key VARCHAR(100) NOT NULL,
    column_name VARCHAR(50) NOT NULL,
    ordenable SMALLINT NOT NULL,
    searchable SMALLINT NOT NULL,
    data_type VARCHAR(10) NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- list_field_entity
-----------------------------------------------------------------------------
drop table list_field_entity if exists;

CREATE TABLE list_field_entity
(
    id INTEGER NOT NULL,
    list_field_id INTEGER,
    list_entity_id INTEGER,
    min_value INTEGER,
    max_value INTEGER,
    min_str_value VARCHAR(100),
    max_str_value VARCHAR(100),
    min_date_value TIMESTAMP,
    max_date_value TIMESTAMP,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- menu_option
-----------------------------------------------------------------------------
drop table menu_option if exists;

CREATE TABLE menu_option
(
    id INTEGER NOT NULL,
    link VARCHAR(100) NOT NULL,
    level_field INTEGER NOT NULL,
    parent_id INTEGER,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- notification_message
-----------------------------------------------------------------------------
drop table notification_message if exists;

CREATE TABLE notification_message
(
    id INTEGER NOT NULL,
    type_id INTEGER,
    entity_id INTEGER NOT NULL,
    language_id INTEGER NOT NULL,
    use_flag SMALLINT default 1 NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- notification_message_arch
-----------------------------------------------------------------------------
drop table notification_message_arch if exists;

CREATE TABLE notification_message_arch
(
    id INTEGER NOT NULL,
    type_id INTEGER,
    create_datetime TIMESTAMP NOT NULL,
    user_id INTEGER,
    result_message VARCHAR(200),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- notification_message_arch_line
-----------------------------------------------------------------------------
drop table notification_message_arch_line if exists;

CREATE TABLE notification_message_arch_line
(
    id INTEGER NOT NULL,
    message_archive_id INTEGER,
    section INTEGER NOT NULL,
    content VARCHAR(1000) NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- notification_message_line
-----------------------------------------------------------------------------
drop table notification_message_line if exists;

CREATE TABLE notification_message_line
(
    id INTEGER NOT NULL,
    message_section_id INTEGER,
    content VARCHAR(1000) NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- notification_message_section
-----------------------------------------------------------------------------
drop table notification_message_section if exists;

CREATE TABLE notification_message_section
(
    id INTEGER NOT NULL,
    message_id INTEGER,
    section INTEGER,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- notification_message_type
-----------------------------------------------------------------------------
drop table notification_message_type if exists;

CREATE TABLE notification_message_type
(
    id INTEGER NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- order_billing_type
-----------------------------------------------------------------------------
drop table order_billing_type if exists;

CREATE TABLE order_billing_type
(
    id INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- order_line
-----------------------------------------------------------------------------
drop table order_line if exists;

CREATE TABLE order_line
(
    id INTEGER NOT NULL,
    order_id INTEGER,
    item_id INTEGER,
    type_id INTEGER,
    amount NUMERIC(22,10) NOT NULL,
    quantity NUMERIC(22,10),
    price NUMERIC(22,10),
    item_price SMALLINT,
    create_datetime TIMESTAMP NOT NULL,
    deleted SMALLINT default 0 NOT NULL,
    description VARCHAR(1000),
    provisioning_status INTEGER,
    provisioning_request_id VARCHAR(50),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_order_line_order_id ON order_line (order_id);
CREATE  INDEX ix_order_line_item_id ON order_line (item_id);
-----------------------------------------------------------------------------
-- order_line_type
-----------------------------------------------------------------------------
drop table order_line_type if exists;

CREATE TABLE order_line_type
(
    id INTEGER NOT NULL,
    editable SMALLINT NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- order_period
-----------------------------------------------------------------------------
drop table order_period if exists;

CREATE TABLE order_period
(
    id INTEGER NOT NULL,
    entity_id INTEGER,
    value INTEGER,
    unit_id INTEGER,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- order_process
-----------------------------------------------------------------------------
drop table order_process if exists;

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
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_uq_order_process_or_in ON order_process (order_id, invoice_id);
CREATE  INDEX ix_uq_order_process_or_bp ON order_process (order_id, billing_process_id);
CREATE  INDEX ix_order_process_in ON order_process (invoice_id);
-----------------------------------------------------------------------------
-- paper_invoice_batch
-----------------------------------------------------------------------------
drop table paper_invoice_batch if exists;

CREATE TABLE paper_invoice_batch
(
    id INTEGER NOT NULL,
    total_invoices INTEGER NOT NULL,
    delivery_date DATE,
    is_self_managed SMALLINT NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- partner
-----------------------------------------------------------------------------
drop table partner if exists;

CREATE TABLE partner
(
    id INTEGER NOT NULL,
    user_id INTEGER,
    balance NUMERIC(22,10) NOT NULL,
    total_payments NUMERIC(22,10) NOT NULL,
    total_refunds NUMERIC(22,10) NOT NULL,
    total_payouts NUMERIC(22,10) NOT NULL,
    percentage_rate NUMERIC(22,10),
    referral_fee NUMERIC(22,10),
    fee_currency_id INTEGER,
    one_time SMALLINT NOT NULL,
    period_unit_id INTEGER NOT NULL,
    period_value INTEGER NOT NULL,
    next_payout_date DATE NOT NULL,
    due_payout NUMERIC(22,10),
    automatic_process SMALLINT NOT NULL,
    related_clerk INTEGER,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX partner_i_3 ON partner (user_id);
-----------------------------------------------------------------------------
-- partner_payout
-----------------------------------------------------------------------------
drop table partner_payout if exists;

CREATE TABLE partner_payout
(
    id INTEGER NOT NULL,
    starting_date DATE NOT NULL,
    ending_date DATE NOT NULL,
    payments_amount NUMERIC(22,10) NOT NULL,
    refunds_amount NUMERIC(22,10) NOT NULL,
    balance_left NUMERIC(22,10) NOT NULL,
    payment_id INTEGER,
    partner_id INTEGER,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX partner_payout_i_2 ON partner_payout (partner_id);
-----------------------------------------------------------------------------
-- partner_range
-----------------------------------------------------------------------------
drop table partner_range if exists;

CREATE TABLE partner_range
(
    id INTEGER NOT NULL,
    partner_id INTEGER,
    percentage_rate NUMERIC(22,10),
    referral_fee NUMERIC(22,10),
    range_from INTEGER NOT NULL,
    range_to INTEGER NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX partner_range_p ON partner_range (partner_id);
-----------------------------------------------------------------------------
-- payment
-----------------------------------------------------------------------------
drop table payment if exists;

CREATE TABLE payment
(
    id INTEGER NOT NULL,
    user_id INTEGER,
    attempt INTEGER,
    result_id INTEGER,
    amount NUMERIC(22,10) NOT NULL,
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
    balance NUMERIC(22,10),
    payment_period INTEGER,
    payment_notes VARCHAR(500),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX payment_i_2 ON payment (user_id, create_datetime);
CREATE  INDEX payment_i_3 ON payment (user_id, balance);
-----------------------------------------------------------------------------
-- payment_authorization
-----------------------------------------------------------------------------
drop table payment_authorization if exists;

CREATE TABLE payment_authorization
(
    id INTEGER NOT NULL,
    payment_id INTEGER,
    processor VARCHAR(40) NOT NULL,
    code1 VARCHAR(40) NOT NULL,
    code2 VARCHAR(40),
    code3 VARCHAR(40),
    approval_code VARCHAR(20),
    avs VARCHAR(20),
    transaction_id VARCHAR(20),
    md5 VARCHAR(100),
    card_code VARCHAR(100),
    create_datetime DATE NOT NULL,
    response_message VARCHAR(200),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX create_datetime ON payment_authorization (create_datetime);
CREATE  INDEX transaction_id ON payment_authorization (transaction_id);
CREATE  INDEX ix_pa_payment ON payment_authorization (payment_id);
-----------------------------------------------------------------------------
-- payment_info_cheque
-----------------------------------------------------------------------------
drop table payment_info_cheque if exists;

CREATE TABLE payment_info_cheque
(
    id INTEGER NOT NULL,
    payment_id INTEGER,
    bank VARCHAR(50),
    cheque_number VARCHAR(50),
    cheque_date DATE,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- payment_invoice
-----------------------------------------------------------------------------
drop table payment_invoice if exists;

CREATE TABLE payment_invoice
(
    id INTEGER NOT NULL,
    payment_id INTEGER,
    invoice_id INTEGER,
    amount NUMERIC(22,10),
    create_datetime TIMESTAMP NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_uq_payment_inv_map_pa_in ON payment_invoice (payment_id, invoice_id);
-----------------------------------------------------------------------------
-- payment_method
-----------------------------------------------------------------------------
drop table payment_method if exists;

CREATE TABLE payment_method
(
    id INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- payment_result
-----------------------------------------------------------------------------
drop table payment_result if exists;

CREATE TABLE payment_result
(
    id INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- period_unit
-----------------------------------------------------------------------------
drop table period_unit if exists;

CREATE TABLE period_unit
(
    id INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- permission
-----------------------------------------------------------------------------
drop table permission if exists;

CREATE TABLE permission
(
    id INTEGER NOT NULL,
    type_id INTEGER NOT NULL,
    foreign_id INTEGER,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- permission_role_map
-----------------------------------------------------------------------------
drop table permission_role_map if exists;

CREATE TABLE permission_role_map
(
    permission_id INTEGER,
    role_id INTEGER
);

CREATE  INDEX permission_role_map_i_2 ON permission_role_map (permission_id, role_id);
-----------------------------------------------------------------------------
-- permission_type
-----------------------------------------------------------------------------
drop table permission_type if exists;

CREATE TABLE permission_type
(
    id INTEGER NOT NULL,
    description VARCHAR(30) NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- permission_user
-----------------------------------------------------------------------------
drop table permission_user if exists;

CREATE TABLE permission_user
(
    permission_id INTEGER,
    user_id INTEGER,
    is_grant SMALLINT NOT NULL,
    id INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX permission_user_map_i_2 ON permission_user (permission_id, user_id);
-----------------------------------------------------------------------------
-- pluggable_task
-----------------------------------------------------------------------------
drop table pluggable_task if exists;

CREATE TABLE pluggable_task
(
    id INTEGER NOT NULL,
    entity_id INTEGER NOT NULL,
    type_id INTEGER,
    processing_order INTEGER NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- pluggable_task_parameter
-----------------------------------------------------------------------------
drop table pluggable_task_parameter if exists;

CREATE TABLE pluggable_task_parameter
(
    id INTEGER NOT NULL,
    task_id INTEGER,
    name VARCHAR(50) NOT NULL,
    int_value INTEGER,
    str_value VARCHAR(500),
    float_value NUMERIC(22,10),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- pluggable_task_type
-----------------------------------------------------------------------------
drop table pluggable_task_type if exists;

CREATE TABLE pluggable_task_type
(
    id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    class_name VARCHAR(200) NOT NULL,
    min_parameters INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- pluggable_task_type_category
-----------------------------------------------------------------------------
drop table pluggable_task_type_category if exists;

CREATE TABLE pluggable_task_type_category
(
    id INTEGER NOT NULL,
    description VARCHAR(50) NOT NULL,
    interface_name VARCHAR(200) NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- preference
-----------------------------------------------------------------------------
drop table preference if exists;

CREATE TABLE preference
(
    id INTEGER NOT NULL,
    type_id INTEGER,
    table_id INTEGER NOT NULL,
    foreign_id INTEGER NOT NULL,
    int_value INTEGER,
    str_value VARCHAR(200),
    float_value NUMERIC(22,10),
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- preference_type
-----------------------------------------------------------------------------
drop table preference_type if exists;

CREATE TABLE preference_type
(
    id INTEGER NOT NULL,
    int_def_value INTEGER,
    str_def_value VARCHAR(200),
    float_def_value NUMERIC(22,10),
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- promotion
-----------------------------------------------------------------------------
drop table promotion if exists;

CREATE TABLE promotion
(
    id INTEGER NOT NULL,
    item_id INTEGER,
    code VARCHAR(50) NOT NULL,
    notes VARCHAR(200),
    once SMALLINT NOT NULL,
    since DATE,
    until DATE,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_promotion_code ON promotion (code);
-----------------------------------------------------------------------------
-- purchase_order
-----------------------------------------------------------------------------
drop table purchase_order if exists;

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
    notes VARCHAR(200),
    notes_in_invoice SMALLINT,
    is_current SMALLINT,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX purchase_order_i_user ON purchase_order (user_id, deleted);
CREATE  INDEX purchase_order_i_notif ON purchase_order (active_until, notification_step);
CREATE  INDEX ix_purchase_order_date ON purchase_order (user_id, create_datetime);
-----------------------------------------------------------------------------
-- report
-----------------------------------------------------------------------------
drop table report if exists;

CREATE TABLE report
(
    id INTEGER NOT NULL,
    titlekey VARCHAR(50),
    instructionskey VARCHAR(50),
    tables_list VARCHAR(1000) NOT NULL,
    where_str VARCHAR(1000) NOT NULL,
    id_column SMALLINT NOT NULL,
    link VARCHAR(200),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- report_entity_map
-----------------------------------------------------------------------------
drop table report_entity_map if exists;

CREATE TABLE report_entity_map
(
    entity_id INTEGER,
    report_id INTEGER
);

CREATE  INDEX report_entity_map_i_2 ON report_entity_map (entity_id, report_id);
-----------------------------------------------------------------------------
-- report_field
-----------------------------------------------------------------------------
drop table report_field if exists;

CREATE TABLE report_field
(
    id INTEGER NOT NULL,
    report_id INTEGER,
    report_user_id INTEGER,
    position_number INTEGER NOT NULL,
    table_name VARCHAR(50) NOT NULL,
    column_name VARCHAR(50) NOT NULL,
    order_position INTEGER,
    where_value VARCHAR(50),
    title_key VARCHAR(50),
    function_name VARCHAR(10),
    is_grouped INTEGER NOT NULL,
    is_shown SMALLINT NOT NULL,
    data_type VARCHAR(10) NOT NULL,
    operator_value VARCHAR(2),
    functionable SMALLINT NOT NULL,
    selectable SMALLINT NOT NULL,
    ordenable SMALLINT NOT NULL,
    operatorable SMALLINT NOT NULL,
    whereable SMALLINT NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- report_type
-----------------------------------------------------------------------------
drop table report_type if exists;

CREATE TABLE report_type
(
    id INTEGER NOT NULL,
    showable SMALLINT NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- report_type_map
-----------------------------------------------------------------------------
drop table report_type_map if exists;

CREATE TABLE report_type_map
(
    report_id INTEGER,
    type_id INTEGER
);


-----------------------------------------------------------------------------
-- report_user
-----------------------------------------------------------------------------
drop table report_user if exists;

CREATE TABLE report_user
(
    id INTEGER NOT NULL,
    user_id INTEGER,
    report_id INTEGER,
    create_datetime TIMESTAMP NOT NULL,
    title VARCHAR(50),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- role
-----------------------------------------------------------------------------
drop table role if exists;

CREATE TABLE role
(
    id INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- user_credit_card_map
-----------------------------------------------------------------------------
drop table user_credit_card_map if exists;

CREATE TABLE user_credit_card_map
(
    user_id INTEGER,
    credit_card_id INTEGER
);

CREATE  INDEX user_credit_card_map_i_2 ON user_credit_card_map (user_id, credit_card_id);
-----------------------------------------------------------------------------
-- user_role_map
-----------------------------------------------------------------------------
drop table user_role_map if exists;

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
drop table mediation_cfg if exists;

CREATE TABLE mediation_cfg
(
    id INTEGER NOT NULL,
    entity_id INTEGER NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    name VARCHAR(50) NOT NULL,
    order_value INTEGER NOT NULL,
    pluggable_task_id INTEGER NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- mediation_process
-----------------------------------------------------------------------------
drop table mediation_process if exists;

CREATE TABLE mediation_process
(
    id INTEGER NOT NULL,
    configuration_id INTEGER NOT NULL,
    start_datetime TIMESTAMP NOT NULL,
    end_datetime TIMESTAMP default NULL,
    orders_affected INTEGER NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- mediation_order_map
-----------------------------------------------------------------------------
drop table mediation_order_map if exists;

CREATE TABLE mediation_order_map
(
    mediation_process_id INTEGER NOT NULL,
    order_id INTEGER NOT NULL
);


-----------------------------------------------------------------------------
-- mediation_record
-----------------------------------------------------------------------------
drop table mediation_record if exists;

CREATE TABLE mediation_record
(
    id_key VARCHAR(100) NOT NULL,
    start_datetime TIMESTAMP NOT NULL,
    mediation_process_id INTEGER,
    status_id INTEGER NOT NULL,
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id_key)
);

CREATE  INDEX mediation_record_i ON mediation_record (id_key, status_id);
-----------------------------------------------------------------------------
-- mediation_record_line
-----------------------------------------------------------------------------
drop table mediation_record_line if exists;

CREATE TABLE mediation_record_line
(
    id INTEGER NOT NULL,
    mediation_record_id VARCHAR(100) NOT NULL,
    order_line_id INTEGER NOT NULL,
    event_date TIMESTAMP NOT NULL,
    amount NUMERIC(22,10) NOT NULL,
    quantity NUMERIC(22,10) NOT NULL,
    description VARCHAR(200),
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_mrl_order_line ON mediation_record_line (order_line_id);
-----------------------------------------------------------------------------
-- blacklist
-----------------------------------------------------------------------------
drop table blacklist if exists;

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
    OPTLOCK INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE  INDEX ix_blacklist_user_type ON blacklist (user_id, type);
CREATE  INDEX ix_blacklist_entity_type ON blacklist (entity_id, type);
-----------------------------------------------------------------------------
-- generic_status_type
-----------------------------------------------------------------------------
drop table generic_status_type if exists;

CREATE TABLE generic_status_type
(
    id VARCHAR(40) NOT NULL,
    PRIMARY KEY(id)
);


-----------------------------------------------------------------------------
-- generic_status
-----------------------------------------------------------------------------
drop table generic_status if exists;

CREATE TABLE generic_status
(
    id INTEGER NOT NULL,
    dtype VARCHAR(40) NOT NULL,
    status_value INTEGER NOT NULL,
    can_login SMALLINT,
    PRIMARY KEY(id)
);
