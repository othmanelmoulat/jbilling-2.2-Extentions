
-----------------------------------------------------------------------------
-- ach
-----------------------------------------------------------------------------
DROP TABLE ach CASCADE CONSTRAINTS;

CREATE TABLE ach
(
    id NUMBER(10,0) NOT NULL,
    user_id NUMBER(10,0),
    aba_routing VARCHAR2(40) NOT NULL,
    bank_account VARCHAR2(60) NOT NULL,
    account_type NUMBER(10,0) NOT NULL,
    bank_name VARCHAR2(50) NOT NULL,
    account_name VARCHAR2(100) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE ach
    ADD CONSTRAINT ach_PK
PRIMARY KEY (id);

CREATE INDEX ach_i_2 ON ach (user_id);





-----------------------------------------------------------------------------
-- ageing_entity_step
-----------------------------------------------------------------------------
DROP TABLE ageing_entity_step CASCADE CONSTRAINTS;

CREATE TABLE ageing_entity_step
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0),
    status_id NUMBER(10,0),
    days NUMBER(10,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE ageing_entity_step
    ADD CONSTRAINT ageing_entity_step_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- base_user
-----------------------------------------------------------------------------
DROP TABLE base_user CASCADE CONSTRAINTS;

CREATE TABLE base_user
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0),
    password VARCHAR2(40),
    deleted NUMBER(5,0) default 0 NOT NULL,
    language_id NUMBER(10,0),
    status_id NUMBER(10,0),
    subscriber_status NUMBER(10,0) default 1,
    currency_id NUMBER(10,0),
    create_datetime TIMESTAMP NOT NULL,
    last_status_change TIMESTAMP,
    last_login TIMESTAMP,
    user_name VARCHAR2(50),
    failed_attempts NUMBER(10,0) default 0 NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE base_user
    ADD CONSTRAINT base_user_PK
PRIMARY KEY (id);

CREATE INDEX ix_base_user_un ON base_user (entity_id, user_name);





-----------------------------------------------------------------------------
-- billing_process
-----------------------------------------------------------------------------
DROP TABLE billing_process CASCADE CONSTRAINTS;

CREATE TABLE billing_process
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0) NOT NULL,
    billing_date DATE NOT NULL,
    period_unit_id NUMBER(10,0) NOT NULL,
    period_value NUMBER(10,0) NOT NULL,
    is_review NUMBER(10,0) NOT NULL,
    paper_invoice_batch_id NUMBER(10,0),
    retries_to_do NUMBER(10,0) default 0 NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE billing_process
    ADD CONSTRAINT billing_process_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- billing_process_configuration
-----------------------------------------------------------------------------
DROP TABLE billing_process_configuration CASCADE CONSTRAINTS;

CREATE TABLE billing_process_configuration
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0),
    next_run_date DATE NOT NULL,
    generate_report NUMBER(5,0) NOT NULL,
    retries NUMBER(10,0),
    days_for_retry NUMBER(10,0),
    days_for_report NUMBER(10,0),
    review_status NUMBER(10,0) NOT NULL,
    period_unit_id NUMBER(10,0) NOT NULL,
    period_value NUMBER(10,0) NOT NULL,
    due_date_unit_id NUMBER(10,0) NOT NULL,
    due_date_value NUMBER(10,0) NOT NULL,
    df_fm NUMBER(5,0),
    only_recurring NUMBER(5,0) default 1 NOT NULL,
    invoice_date_process NUMBER(5,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL,
    auto_payment NUMBER(5,0) default 0 NOT NULL,
    maximum_periods NUMBER(10,0) default 1 NOT NULL,
    auto_payment_application NUMBER(10,0) default 0 NOT NULL
);

ALTER TABLE billing_process_configuration
    ADD CONSTRAINT billing_process_configurati_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- process_run
-----------------------------------------------------------------------------
DROP TABLE process_run CASCADE CONSTRAINTS;

CREATE TABLE process_run
(
    id NUMBER(10,0) NOT NULL,
    process_id NUMBER(10,0),
    run_date DATE NOT NULL,
    started TIMESTAMP NOT NULL,
    finished TIMESTAMP,
    payment_finished TIMESTAMP,
    invoices_generated NUMBER(10,0),
    OPTLOCK NUMBER(10,0) NOT NULL,
    status_id NUMBER(10,0) NOT NULL
);

ALTER TABLE process_run
    ADD CONSTRAINT process_run_PK
PRIMARY KEY (id);

CREATE INDEX bp_run_process_ix ON process_run (process_id);





-----------------------------------------------------------------------------
-- process_run_total
-----------------------------------------------------------------------------
DROP TABLE process_run_total CASCADE CONSTRAINTS;

CREATE TABLE process_run_total
(
    id NUMBER(10,0) NOT NULL,
    process_run_id NUMBER(10,0),
    currency_id NUMBER(10,0) NOT NULL,
    total_invoiced NUMBER(22,10),
    total_paid NUMBER(22,10),
    total_not_paid NUMBER(22,10),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE process_run_total
    ADD CONSTRAINT process_run_total_PK
PRIMARY KEY (id);

CREATE INDEX bp_run_total_run_ix ON process_run_total (process_run_id);





-----------------------------------------------------------------------------
-- process_run_total_pm
-----------------------------------------------------------------------------
DROP TABLE process_run_total_pm CASCADE CONSTRAINTS;

CREATE TABLE process_run_total_pm
(
    id NUMBER(10,0) NOT NULL,
    process_run_total_id NUMBER(10,0),
    payment_method_id NUMBER(10,0),
    total NUMBER(22,10) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE process_run_total_pm
    ADD CONSTRAINT process_run_total_pm_PK
PRIMARY KEY (id);

CREATE INDEX bp_pm_index_total ON process_run_total_pm (process_run_total_id);





-----------------------------------------------------------------------------
-- process_run_user
-----------------------------------------------------------------------------
DROP TABLE process_run_user CASCADE CONSTRAINTS;

CREATE TABLE process_run_user
(
    id NUMBER(10,0) NOT NULL,
    process_run_id NUMBER(10,0) NOT NULL,
    user_id NUMBER(10,0) NOT NULL,
    status NUMBER(10,0) NOT NULL,
    created DATE NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE process_run_user
    ADD CONSTRAINT process_run_user_PK
PRIMARY KEY (id);

CREATE INDEX bp_run_user_run_ix ON process_run_user (process_run_id);
CREATE INDEX bp_run_user_user_ix ON process_run_user (user_id);





-----------------------------------------------------------------------------
-- contact
-----------------------------------------------------------------------------
DROP TABLE contact CASCADE CONSTRAINTS;

CREATE TABLE contact
(
    id NUMBER(10,0) NOT NULL,
    organization_name VARCHAR2(200),
    street_addres1 VARCHAR2(100),
    street_addres2 VARCHAR2(100),
    city VARCHAR2(50),
    state_province VARCHAR2(30),
    postal_code VARCHAR2(15),
    country_code VARCHAR2(2),
    last_name VARCHAR2(30),
    first_name VARCHAR2(30),
    person_initial VARCHAR2(5),
    person_title VARCHAR2(40),
    phone_country_code NUMBER(10,0),
    phone_area_code NUMBER(10,0),
    phone_phone_number VARCHAR2(20),
    fax_country_code NUMBER(10,0),
    fax_area_code NUMBER(10,0),
    fax_phone_number VARCHAR2(20),
    email VARCHAR2(200),
    create_datetime TIMESTAMP NOT NULL,
    deleted NUMBER(5,0) default 0 NOT NULL,
    notification_include NUMBER(5,0) default 1,
    user_id NUMBER(10,0),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE contact
    ADD CONSTRAINT contact_PK
PRIMARY KEY (id);

CREATE INDEX ix_contact_fname ON contact (first_name);
CREATE INDEX ix_contact_lname ON contact (last_name);
CREATE INDEX ix_contact_orgname ON contact (organization_name);
CREATE INDEX contact_i_del ON contact (deleted);
CREATE INDEX ix_contact_fname_lname ON contact (first_name, last_name);
CREATE INDEX ix_contact_address ON contact (street_addres1, city, postal_code, street_addres2, state_province, country_code);
CREATE INDEX ix_contact_phone ON contact (phone_phone_number, phone_area_code, phone_country_code);





-----------------------------------------------------------------------------
-- contact_field
-----------------------------------------------------------------------------
DROP TABLE contact_field CASCADE CONSTRAINTS;

CREATE TABLE contact_field
(
    id NUMBER(10,0) NOT NULL,
    type_id NUMBER(10,0),
    contact_id NUMBER(10,0),
    content VARCHAR2(100) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE contact_field
    ADD CONSTRAINT contact_field_PK
PRIMARY KEY (id);

CREATE INDEX ix_contact_field_cid ON contact_field (contact_id);
CREATE INDEX ix_contact_field_content ON contact_field (content);





-----------------------------------------------------------------------------
-- contact_field_type
-----------------------------------------------------------------------------
DROP TABLE contact_field_type CASCADE CONSTRAINTS;

CREATE TABLE contact_field_type
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0),
    prompt_key VARCHAR2(50) NOT NULL,
    data_type VARCHAR2(10) NOT NULL,
    customer_readonly NUMBER(5,0)
);

ALTER TABLE contact_field_type
    ADD CONSTRAINT contact_field_type_PK
PRIMARY KEY (id);

CREATE INDEX ix_cf_type_entity ON contact_field_type (entity_id);





-----------------------------------------------------------------------------
-- contact_map
-----------------------------------------------------------------------------
DROP TABLE contact_map CASCADE CONSTRAINTS;

CREATE TABLE contact_map
(
    id NUMBER(10,0) NOT NULL,
    contact_id NUMBER(10,0),
    type_id NUMBER(10,0) NOT NULL,
    table_id NUMBER(10,0) NOT NULL,
    foreign_id NUMBER(10,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE contact_map
    ADD CONSTRAINT contact_map_PK
PRIMARY KEY (id);

CREATE INDEX contact_map_i_3 ON contact_map (contact_id);
CREATE INDEX contact_map_i_1 ON contact_map (table_id, foreign_id, type_id);





-----------------------------------------------------------------------------
-- contact_type
-----------------------------------------------------------------------------
DROP TABLE contact_type CASCADE CONSTRAINTS;

CREATE TABLE contact_type
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0),
    is_primary NUMBER(5,0)
);

ALTER TABLE contact_type
    ADD CONSTRAINT contact_type_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- country
-----------------------------------------------------------------------------
DROP TABLE country CASCADE CONSTRAINTS;

CREATE TABLE country
(
    id NUMBER(10,0) NOT NULL,
    code VARCHAR2(2) NOT NULL
);

ALTER TABLE country
    ADD CONSTRAINT country_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- credit_card
-----------------------------------------------------------------------------
DROP TABLE credit_card CASCADE CONSTRAINTS;

CREATE TABLE credit_card
(
    id NUMBER(10,0) NOT NULL,
    cc_number VARCHAR2(100) NOT NULL,
    cc_number_plain VARCHAR2(20),
    cc_expiry DATE NOT NULL,
    name VARCHAR2(150),
    cc_type NUMBER(10,0) NOT NULL,
    deleted NUMBER(5,0) default 0 NOT NULL,
    gateway_key VARCHAR2(100),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE credit_card
    ADD CONSTRAINT credit_card_PK
PRIMARY KEY (id);

CREATE INDEX ix_cc_number ON credit_card (cc_number_plain);
CREATE INDEX ix_cc_number_encrypted ON credit_card (cc_number);





-----------------------------------------------------------------------------
-- currency
-----------------------------------------------------------------------------
DROP TABLE currency CASCADE CONSTRAINTS;

CREATE TABLE currency
(
    id NUMBER(10,0) NOT NULL,
    symbol VARCHAR2(10) NOT NULL,
    code VARCHAR2(3) NOT NULL,
    country_code VARCHAR2(2) NOT NULL
);

ALTER TABLE currency
    ADD CONSTRAINT currency_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- currency_entity_map
-----------------------------------------------------------------------------
DROP TABLE currency_entity_map CASCADE CONSTRAINTS;

CREATE TABLE currency_entity_map
(
    currency_id NUMBER(10,0),
    entity_id NUMBER(10,0)
);


CREATE INDEX currency_entity_map_i_2 ON currency_entity_map (currency_id, entity_id);





-----------------------------------------------------------------------------
-- currency_exchange
-----------------------------------------------------------------------------
DROP TABLE currency_exchange CASCADE CONSTRAINTS;

CREATE TABLE currency_exchange
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0),
    currency_id NUMBER(10,0),
    rate NUMBER(22,10) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE currency_exchange
    ADD CONSTRAINT currency_exchange_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- customer
-----------------------------------------------------------------------------
DROP TABLE customer CASCADE CONSTRAINTS;

CREATE TABLE customer
(
    id NUMBER(10,0) NOT NULL,
    user_id NUMBER(10,0),
    partner_id NUMBER(10,0),
    referral_fee_paid NUMBER(5,0),
    invoice_delivery_method_id NUMBER(10,0) NOT NULL,
    notes VARCHAR2(1000),
    auto_payment_type NUMBER(10,0),
    due_date_unit_id NUMBER(10,0),
    due_date_value NUMBER(10,0),
    df_fm NUMBER(5,0),
    parent_id NUMBER(10,0),
    is_parent NUMBER(5,0),
    exclude_aging NUMBER(5,0) default 0 NOT NULL,
    invoice_child NUMBER(5,0),
    current_order_id NUMBER(10,0),
    balance_type NUMBER(10,0) default 1 NOT NULL,
    dynamic_balance NUMBER(22,10),
    credit_limit NUMBER(22,10),
    auto_recharge NUMBER(22,10),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE customer
    ADD CONSTRAINT customer_PK
PRIMARY KEY (id);

CREATE INDEX customer_i_2 ON customer (user_id);





-----------------------------------------------------------------------------
-- entity
-----------------------------------------------------------------------------
DROP TABLE entity CASCADE CONSTRAINTS;

CREATE TABLE entity
(
    id NUMBER(10,0) NOT NULL,
    external_id VARCHAR2(20),
    description VARCHAR2(100) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    language_id NUMBER(10,0) NOT NULL,
    currency_id NUMBER(10,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE entity
    ADD CONSTRAINT entity_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- entity_delivery_method_map
-----------------------------------------------------------------------------
DROP TABLE entity_delivery_method_map CASCADE CONSTRAINTS;

CREATE TABLE entity_delivery_method_map
(
    method_id NUMBER(10,0),
    entity_id NUMBER(10,0)
);







-----------------------------------------------------------------------------
-- entity_payment_method_map
-----------------------------------------------------------------------------
DROP TABLE entity_payment_method_map CASCADE CONSTRAINTS;

CREATE TABLE entity_payment_method_map
(
    entity_id NUMBER(10,0),
    payment_method_id NUMBER(10,0)
);







-----------------------------------------------------------------------------
-- event_log
-----------------------------------------------------------------------------
DROP TABLE event_log CASCADE CONSTRAINTS;

CREATE TABLE event_log
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0),
    user_id NUMBER(10,0),
    affected_user_id NUMBER(10,0),
    table_id NUMBER(10,0),
    foreign_id NUMBER(10,0) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    level_field NUMBER(10,0) NOT NULL,
    module_id NUMBER(10,0) NOT NULL,
    message_id NUMBER(10,0) NOT NULL,
    old_num NUMBER(10,0),
    old_str VARCHAR2(1000),
    old_date TIMESTAMP,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE event_log
    ADD CONSTRAINT event_log_PK
PRIMARY KEY (id);

CREATE INDEX ix_el_main ON event_log (module_id, message_id, create_datetime);





-----------------------------------------------------------------------------
-- event_log_message
-----------------------------------------------------------------------------
DROP TABLE event_log_message CASCADE CONSTRAINTS;

CREATE TABLE event_log_message
(
    id NUMBER(10,0) NOT NULL
);

ALTER TABLE event_log_message
    ADD CONSTRAINT event_log_message_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- event_log_module
-----------------------------------------------------------------------------
DROP TABLE event_log_module CASCADE CONSTRAINTS;

CREATE TABLE event_log_module
(
    id NUMBER(10,0) NOT NULL
);

ALTER TABLE event_log_module
    ADD CONSTRAINT event_log_module_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- international_description
-----------------------------------------------------------------------------
DROP TABLE international_description CASCADE CONSTRAINTS;

CREATE TABLE international_description
(
    table_id NUMBER(10,0) NOT NULL,
    foreign_id NUMBER(10,0) NOT NULL,
    psudo_column VARCHAR2(20) NOT NULL,
    language_id NUMBER(10,0) NOT NULL,
    content VARCHAR2(4000) NOT NULL
);

ALTER TABLE international_description
    ADD CONSTRAINT international_description_PK
PRIMARY KEY (table_id,foreign_id,psudo_column,language_id);

CREATE INDEX international_description_i_2 ON international_description (table_id, foreign_id, language_id);
CREATE INDEX int_description_i_lan ON international_description (language_id);





-----------------------------------------------------------------------------
-- invoice
-----------------------------------------------------------------------------
DROP TABLE invoice CASCADE CONSTRAINTS;

CREATE TABLE invoice
(
    id NUMBER(10,0) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    billing_process_id NUMBER(10,0),
    user_id NUMBER(10,0),
    status_id NUMBER(10,0) NOT NULL,
    delegated_invoice_id NUMBER(10,0),
    due_date DATE NOT NULL,
    total NUMBER(22,10) NOT NULL,
    payment_attempts NUMBER(10,0) default 0 NOT NULL,
    balance NUMBER(22,10),
    carried_balance NUMBER(22,10) NOT NULL,
    in_process_payment NUMBER(5,0) default 1 NOT NULL,
    is_review NUMBER(10,0) NOT NULL,
    currency_id NUMBER(10,0) NOT NULL,
    deleted NUMBER(5,0) default 0 NOT NULL,
    paper_invoice_batch_id NUMBER(10,0),
    customer_notes VARCHAR2(1000),
    public_number VARCHAR2(40),
    last_reminder DATE,
    overdue_step NUMBER(10,0),
    create_timestamp TIMESTAMP NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE invoice
    ADD CONSTRAINT invoice_PK
PRIMARY KEY (id);

CREATE INDEX ix_invoice_user_id ON invoice (user_id, deleted);
CREATE INDEX ix_invoice_date ON invoice (create_datetime);
CREATE INDEX ix_invoice_number ON invoice (user_id, public_number);
CREATE INDEX ix_invoice_due_date ON invoice (user_id, due_date);
CREATE INDEX ix_invoice_ts ON invoice (create_timestamp, user_id);
CREATE INDEX ix_invoice_process ON invoice (billing_process_id);





-----------------------------------------------------------------------------
-- invoice_delivery_method
-----------------------------------------------------------------------------
DROP TABLE invoice_delivery_method CASCADE CONSTRAINTS;

CREATE TABLE invoice_delivery_method
(
    id NUMBER(10,0) NOT NULL
);

ALTER TABLE invoice_delivery_method
    ADD CONSTRAINT invoice_delivery_method_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- invoice_line
-----------------------------------------------------------------------------
DROP TABLE invoice_line CASCADE CONSTRAINTS;

CREATE TABLE invoice_line
(
    id NUMBER(10,0) NOT NULL,
    invoice_id NUMBER(10,0),
    type_id NUMBER(10,0),
    amount NUMBER(22,10) NOT NULL,
    quantity NUMBER(22,10),
    price NUMBER(22,10),
    deleted NUMBER(5,0) default 0 NOT NULL,
    item_id NUMBER(10,0),
    description VARCHAR2(1000),
    source_user_id NUMBER(10,0),
    is_percentage NUMBER(5,0) default 0 NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE invoice_line
    ADD CONSTRAINT invoice_line_PK
PRIMARY KEY (id);

CREATE INDEX ix_invoice_line_invoice_id ON invoice_line (invoice_id);





-----------------------------------------------------------------------------
-- invoice_line_type
-----------------------------------------------------------------------------
DROP TABLE invoice_line_type CASCADE CONSTRAINTS;

CREATE TABLE invoice_line_type
(
    id NUMBER(10,0) NOT NULL,
    description VARCHAR2(50) NOT NULL,
    order_position NUMBER(10,0) NOT NULL
);

ALTER TABLE invoice_line_type
    ADD CONSTRAINT invoice_line_type_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- item
-----------------------------------------------------------------------------
DROP TABLE item CASCADE CONSTRAINTS;

CREATE TABLE item
(
    id NUMBER(10,0) NOT NULL,
    internal_number VARCHAR2(50),
    entity_id NUMBER(10,0),
    percentage NUMBER(22,10),
    price_manual NUMBER(5,0) NOT NULL,
    deleted NUMBER(5,0) default 0 NOT NULL,
    has_decimals NUMBER(5,0) default 0 NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE item
    ADD CONSTRAINT item_PK
PRIMARY KEY (id);

CREATE INDEX ix_item_ent ON item (entity_id, internal_number);





-----------------------------------------------------------------------------
-- item_price
-----------------------------------------------------------------------------
DROP TABLE item_price CASCADE CONSTRAINTS;

CREATE TABLE item_price
(
    id NUMBER(10,0) NOT NULL,
    item_id NUMBER(10,0),
    currency_id NUMBER(10,0),
    price NUMBER(22,10) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE item_price
    ADD CONSTRAINT item_price_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- item_type
-----------------------------------------------------------------------------
DROP TABLE item_type CASCADE CONSTRAINTS;

CREATE TABLE item_type
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0) NOT NULL,
    description VARCHAR2(100),
    order_line_type_id NUMBER(10,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE item_type
    ADD CONSTRAINT item_type_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- item_type_map
-----------------------------------------------------------------------------
DROP TABLE item_type_map CASCADE CONSTRAINTS;

CREATE TABLE item_type_map
(
    item_id NUMBER(10,0),
    type_id NUMBER(10,0)
);







-----------------------------------------------------------------------------
-- jbilling_table
-----------------------------------------------------------------------------
DROP TABLE jbilling_table CASCADE CONSTRAINTS;

CREATE TABLE jbilling_table
(
    id NUMBER(10,0) NOT NULL,
    name VARCHAR2(50) NOT NULL
);

ALTER TABLE jbilling_table
    ADD CONSTRAINT jbilling_table_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- jbilling_seqs
-----------------------------------------------------------------------------
DROP TABLE jbilling_seqs CASCADE CONSTRAINTS;

CREATE TABLE jbilling_seqs
(
    name VARCHAR2(50) NOT NULL,
    next_id NUMBER(10,0) default 0 NOT NULL
);







-----------------------------------------------------------------------------
-- language
-----------------------------------------------------------------------------
DROP TABLE language CASCADE CONSTRAINTS;

CREATE TABLE language
(
    id NUMBER(10,0) NOT NULL,
    code VARCHAR2(2) NOT NULL,
    description VARCHAR2(50) NOT NULL
);

ALTER TABLE language
    ADD CONSTRAINT language_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- list
-----------------------------------------------------------------------------
DROP TABLE list CASCADE CONSTRAINTS;

CREATE TABLE list
(
    id NUMBER(10,0) NOT NULL,
    legacy_name VARCHAR2(30),
    title_key VARCHAR2(100) NOT NULL,
    instr_key VARCHAR2(100),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE list
    ADD CONSTRAINT list_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- list_entity
-----------------------------------------------------------------------------
DROP TABLE list_entity CASCADE CONSTRAINTS;

CREATE TABLE list_entity
(
    id NUMBER(10,0) NOT NULL,
    list_id NUMBER(10,0),
    entity_id NUMBER(10,0) NOT NULL,
    total_records NUMBER(10,0) NOT NULL,
    last_update DATE NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE list_entity
    ADD CONSTRAINT list_entity_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- list_field
-----------------------------------------------------------------------------
DROP TABLE list_field CASCADE CONSTRAINTS;

CREATE TABLE list_field
(
    id NUMBER(10,0) NOT NULL,
    list_id NUMBER(10,0),
    title_key VARCHAR2(100) NOT NULL,
    column_name VARCHAR2(50) NOT NULL,
    ordenable NUMBER(5,0) NOT NULL,
    searchable NUMBER(5,0) NOT NULL,
    data_type VARCHAR2(10) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE list_field
    ADD CONSTRAINT list_field_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- list_field_entity
-----------------------------------------------------------------------------
DROP TABLE list_field_entity CASCADE CONSTRAINTS;

CREATE TABLE list_field_entity
(
    id NUMBER(10,0) NOT NULL,
    list_field_id NUMBER(10,0),
    list_entity_id NUMBER(10,0),
    min_value NUMBER(10,0),
    max_value NUMBER(10,0),
    min_str_value VARCHAR2(100),
    max_str_value VARCHAR2(100),
    min_date_value TIMESTAMP,
    max_date_value TIMESTAMP,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE list_field_entity
    ADD CONSTRAINT list_field_entity_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- menu_option
-----------------------------------------------------------------------------
DROP TABLE menu_option CASCADE CONSTRAINTS;

CREATE TABLE menu_option
(
    id NUMBER(10,0) NOT NULL,
    link VARCHAR2(100) NOT NULL,
    level_field NUMBER(10,0) NOT NULL,
    parent_id NUMBER(10,0)
);

ALTER TABLE menu_option
    ADD CONSTRAINT menu_option_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- notification_message
-----------------------------------------------------------------------------
DROP TABLE notification_message CASCADE CONSTRAINTS;

CREATE TABLE notification_message
(
    id NUMBER(10,0) NOT NULL,
    type_id NUMBER(10,0),
    entity_id NUMBER(10,0) NOT NULL,
    language_id NUMBER(10,0) NOT NULL,
    use_flag NUMBER(5,0) default 1 NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE notification_message
    ADD CONSTRAINT notification_message_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- notification_message_arch
-----------------------------------------------------------------------------
DROP TABLE notification_message_arch CASCADE CONSTRAINTS;

CREATE TABLE notification_message_arch
(
    id NUMBER(10,0) NOT NULL,
    type_id NUMBER(10,0),
    create_datetime TIMESTAMP NOT NULL,
    user_id NUMBER(10,0),
    result_message VARCHAR2(200),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE notification_message_arch
    ADD CONSTRAINT notification_message_arch_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- notification_message_arch_line
-----------------------------------------------------------------------------
DROP TABLE notification_message_arch_line CASCADE CONSTRAINTS;

CREATE TABLE notification_message_arch_line
(
    id NUMBER(10,0) NOT NULL,
    message_archive_id NUMBER(10,0),
    section NUMBER(10,0) NOT NULL,
    content VARCHAR2(1000) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE notification_message_arch_line
    ADD CONSTRAINT notification_message_arch_l_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- notification_message_line
-----------------------------------------------------------------------------
DROP TABLE notification_message_line CASCADE CONSTRAINTS;

CREATE TABLE notification_message_line
(
    id NUMBER(10,0) NOT NULL,
    message_section_id NUMBER(10,0),
    content VARCHAR2(1000) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE notification_message_line
    ADD CONSTRAINT notification_message_line_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- notification_message_section
-----------------------------------------------------------------------------
DROP TABLE notification_message_section CASCADE CONSTRAINTS;

CREATE TABLE notification_message_section
(
    id NUMBER(10,0) NOT NULL,
    message_id NUMBER(10,0),
    section NUMBER(10,0),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE notification_message_section
    ADD CONSTRAINT notification_message_sectio_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- notification_message_type
-----------------------------------------------------------------------------
DROP TABLE notification_message_type CASCADE CONSTRAINTS;

CREATE TABLE notification_message_type
(
    id NUMBER(10,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE notification_message_type
    ADD CONSTRAINT notification_message_type_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- order_billing_type
-----------------------------------------------------------------------------
DROP TABLE order_billing_type CASCADE CONSTRAINTS;

CREATE TABLE order_billing_type
(
    id NUMBER(10,0) NOT NULL
);

ALTER TABLE order_billing_type
    ADD CONSTRAINT order_billing_type_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- order_line
-----------------------------------------------------------------------------
DROP TABLE order_line CASCADE CONSTRAINTS;

CREATE TABLE order_line
(
    id NUMBER(10,0) NOT NULL,
    order_id NUMBER(10,0),
    item_id NUMBER(10,0),
    type_id NUMBER(10,0),
    amount NUMBER(22,10) NOT NULL,
    quantity NUMBER(22,10),
    price NUMBER(22,10),
    item_price NUMBER(5,0),
    create_datetime TIMESTAMP NOT NULL,
    deleted NUMBER(5,0) default 0 NOT NULL,
    description VARCHAR2(1000),
    provisioning_status NUMBER(10,0),
    provisioning_request_id VARCHAR2(50),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE order_line
    ADD CONSTRAINT order_line_PK
PRIMARY KEY (id);

CREATE INDEX ix_order_line_order_id ON order_line (order_id);
CREATE INDEX ix_order_line_item_id ON order_line (item_id);





-----------------------------------------------------------------------------
-- order_line_type
-----------------------------------------------------------------------------
DROP TABLE order_line_type CASCADE CONSTRAINTS;

CREATE TABLE order_line_type
(
    id NUMBER(10,0) NOT NULL,
    editable NUMBER(5,0) NOT NULL
);

ALTER TABLE order_line_type
    ADD CONSTRAINT order_line_type_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- order_period
-----------------------------------------------------------------------------
DROP TABLE order_period CASCADE CONSTRAINTS;

CREATE TABLE order_period
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0),
    value NUMBER(10,0),
    unit_id NUMBER(10,0),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE order_period
    ADD CONSTRAINT order_period_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- order_process
-----------------------------------------------------------------------------
DROP TABLE order_process CASCADE CONSTRAINTS;

CREATE TABLE order_process
(
    id NUMBER(10,0) NOT NULL,
    order_id NUMBER(10,0),
    invoice_id NUMBER(10,0),
    billing_process_id NUMBER(10,0),
    periods_included NUMBER(10,0),
    period_start DATE,
    period_end DATE,
    is_review NUMBER(10,0) NOT NULL,
    origin NUMBER(10,0),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE order_process
    ADD CONSTRAINT order_process_PK
PRIMARY KEY (id);

CREATE INDEX ix_uq_order_process_or_in ON order_process (order_id, invoice_id);
CREATE INDEX ix_uq_order_process_or_bp ON order_process (order_id, billing_process_id);
CREATE INDEX ix_order_process_in ON order_process (invoice_id);





-----------------------------------------------------------------------------
-- paper_invoice_batch
-----------------------------------------------------------------------------
DROP TABLE paper_invoice_batch CASCADE CONSTRAINTS;

CREATE TABLE paper_invoice_batch
(
    id NUMBER(10,0) NOT NULL,
    total_invoices NUMBER(10,0) NOT NULL,
    delivery_date DATE,
    is_self_managed NUMBER(5,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE paper_invoice_batch
    ADD CONSTRAINT paper_invoice_batch_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- partner
-----------------------------------------------------------------------------
DROP TABLE partner CASCADE CONSTRAINTS;

CREATE TABLE partner
(
    id NUMBER(10,0) NOT NULL,
    user_id NUMBER(10,0),
    balance NUMBER(22,10) NOT NULL,
    total_payments NUMBER(22,10) NOT NULL,
    total_refunds NUMBER(22,10) NOT NULL,
    total_payouts NUMBER(22,10) NOT NULL,
    percentage_rate NUMBER(22,10),
    referral_fee NUMBER(22,10),
    fee_currency_id NUMBER(10,0),
    one_time NUMBER(5,0) NOT NULL,
    period_unit_id NUMBER(10,0) NOT NULL,
    period_value NUMBER(10,0) NOT NULL,
    next_payout_date DATE NOT NULL,
    due_payout NUMBER(22,10),
    automatic_process NUMBER(5,0) NOT NULL,
    related_clerk NUMBER(10,0),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE partner
    ADD CONSTRAINT partner_PK
PRIMARY KEY (id);

CREATE INDEX partner_i_3 ON partner (user_id);





-----------------------------------------------------------------------------
-- partner_payout
-----------------------------------------------------------------------------
DROP TABLE partner_payout CASCADE CONSTRAINTS;

CREATE TABLE partner_payout
(
    id NUMBER(10,0) NOT NULL,
    starting_date DATE NOT NULL,
    ending_date DATE NOT NULL,
    payments_amount NUMBER(22,10) NOT NULL,
    refunds_amount NUMBER(22,10) NOT NULL,
    balance_left NUMBER(22,10) NOT NULL,
    payment_id NUMBER(10,0),
    partner_id NUMBER(10,0),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE partner_payout
    ADD CONSTRAINT partner_payout_PK
PRIMARY KEY (id);

CREATE INDEX partner_payout_i_2 ON partner_payout (partner_id);





-----------------------------------------------------------------------------
-- partner_range
-----------------------------------------------------------------------------
DROP TABLE partner_range CASCADE CONSTRAINTS;

CREATE TABLE partner_range
(
    id NUMBER(10,0) NOT NULL,
    partner_id NUMBER(10,0),
    percentage_rate NUMBER(22,10),
    referral_fee NUMBER(22,10),
    range_from NUMBER(10,0) NOT NULL,
    range_to NUMBER(10,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE partner_range
    ADD CONSTRAINT partner_range_PK
PRIMARY KEY (id);

CREATE INDEX partner_range_p ON partner_range (partner_id);





-----------------------------------------------------------------------------
-- payment
-----------------------------------------------------------------------------
DROP TABLE payment CASCADE CONSTRAINTS;

CREATE TABLE payment
(
    id NUMBER(10,0) NOT NULL,
    user_id NUMBER(10,0),
    attempt NUMBER(10,0),
    result_id NUMBER(10,0),
    amount NUMBER(22,10) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    update_datetime TIMESTAMP,
    payment_date DATE,
    method_id NUMBER(10,0) NOT NULL,
    credit_card_id NUMBER(10,0),
    deleted NUMBER(5,0) default 0 NOT NULL,
    is_refund NUMBER(5,0) default 0 NOT NULL,
    is_preauth NUMBER(5,0) default 0 NOT NULL,
    payment_id NUMBER(10,0),
    currency_id NUMBER(10,0) NOT NULL,
    payout_id NUMBER(10,0),
    ach_id NUMBER(10,0),
    balance NUMBER(22,10),
    payment_period NUMBER(10,0),
    payment_notes VARCHAR2(500),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE payment
    ADD CONSTRAINT payment_PK
PRIMARY KEY (id);

CREATE INDEX payment_i_2 ON payment (user_id, create_datetime);
CREATE INDEX payment_i_3 ON payment (user_id, balance);





-----------------------------------------------------------------------------
-- payment_authorization
-----------------------------------------------------------------------------
DROP TABLE payment_authorization CASCADE CONSTRAINTS;

CREATE TABLE payment_authorization
(
    id NUMBER(10,0) NOT NULL,
    payment_id NUMBER(10,0),
    processor VARCHAR2(40) NOT NULL,
    code1 VARCHAR2(40) NOT NULL,
    code2 VARCHAR2(40),
    code3 VARCHAR2(40),
    approval_code VARCHAR2(20),
    avs VARCHAR2(20),
    transaction_id VARCHAR2(20),
    md5 VARCHAR2(100),
    card_code VARCHAR2(100),
    create_datetime DATE NOT NULL,
    response_message VARCHAR2(200),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE payment_authorization
    ADD CONSTRAINT payment_authorization_PK
PRIMARY KEY (id);

CREATE INDEX create_datetime ON payment_authorization (create_datetime);
CREATE INDEX transaction_id ON payment_authorization (transaction_id);
CREATE INDEX ix_pa_payment ON payment_authorization (payment_id);





-----------------------------------------------------------------------------
-- payment_info_cheque
-----------------------------------------------------------------------------
DROP TABLE payment_info_cheque CASCADE CONSTRAINTS;

CREATE TABLE payment_info_cheque
(
    id NUMBER(10,0) NOT NULL,
    payment_id NUMBER(10,0),
    bank VARCHAR2(50),
    cheque_number VARCHAR2(50),
    cheque_date DATE,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE payment_info_cheque
    ADD CONSTRAINT payment_info_cheque_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- payment_invoice
-----------------------------------------------------------------------------
DROP TABLE payment_invoice CASCADE CONSTRAINTS;

CREATE TABLE payment_invoice
(
    id NUMBER(10,0) NOT NULL,
    payment_id NUMBER(10,0),
    invoice_id NUMBER(10,0),
    amount NUMBER(22,10),
    create_datetime TIMESTAMP NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE payment_invoice
    ADD CONSTRAINT payment_invoice_PK
PRIMARY KEY (id);

CREATE INDEX ix_uq_payment_inv_map_pa_in ON payment_invoice (payment_id, invoice_id);





-----------------------------------------------------------------------------
-- payment_method
-----------------------------------------------------------------------------
DROP TABLE payment_method CASCADE CONSTRAINTS;

CREATE TABLE payment_method
(
    id NUMBER(10,0) NOT NULL
);

ALTER TABLE payment_method
    ADD CONSTRAINT payment_method_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- payment_result
-----------------------------------------------------------------------------
DROP TABLE payment_result CASCADE CONSTRAINTS;

CREATE TABLE payment_result
(
    id NUMBER(10,0) NOT NULL
);

ALTER TABLE payment_result
    ADD CONSTRAINT payment_result_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- period_unit
-----------------------------------------------------------------------------
DROP TABLE period_unit CASCADE CONSTRAINTS;

CREATE TABLE period_unit
(
    id NUMBER(10,0) NOT NULL
);

ALTER TABLE period_unit
    ADD CONSTRAINT period_unit_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- permission
-----------------------------------------------------------------------------
DROP TABLE permission CASCADE CONSTRAINTS;

CREATE TABLE permission
(
    id NUMBER(10,0) NOT NULL,
    type_id NUMBER(10,0) NOT NULL,
    foreign_id NUMBER(10,0)
);

ALTER TABLE permission
    ADD CONSTRAINT permission_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- permission_role_map
-----------------------------------------------------------------------------
DROP TABLE permission_role_map CASCADE CONSTRAINTS;

CREATE TABLE permission_role_map
(
    permission_id NUMBER(10,0),
    role_id NUMBER(10,0)
);


CREATE INDEX permission_role_map_i_2 ON permission_role_map (permission_id, role_id);





-----------------------------------------------------------------------------
-- permission_type
-----------------------------------------------------------------------------
DROP TABLE permission_type CASCADE CONSTRAINTS;

CREATE TABLE permission_type
(
    id NUMBER(10,0) NOT NULL,
    description VARCHAR2(30) NOT NULL
);

ALTER TABLE permission_type
    ADD CONSTRAINT permission_type_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- permission_user
-----------------------------------------------------------------------------
DROP TABLE permission_user CASCADE CONSTRAINTS;

CREATE TABLE permission_user
(
    permission_id NUMBER(10,0),
    user_id NUMBER(10,0),
    is_grant NUMBER(5,0) NOT NULL,
    id NUMBER(10,0) NOT NULL
);

ALTER TABLE permission_user
    ADD CONSTRAINT permission_user_PK
PRIMARY KEY (id);

CREATE INDEX permission_user_map_i_2 ON permission_user (permission_id, user_id);





-----------------------------------------------------------------------------
-- pluggable_task
-----------------------------------------------------------------------------
DROP TABLE pluggable_task CASCADE CONSTRAINTS;

CREATE TABLE pluggable_task
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0) NOT NULL,
    type_id NUMBER(10,0),
    processing_order NUMBER(10,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE pluggable_task
    ADD CONSTRAINT pluggable_task_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- pluggable_task_parameter
-----------------------------------------------------------------------------
DROP TABLE pluggable_task_parameter CASCADE CONSTRAINTS;

CREATE TABLE pluggable_task_parameter
(
    id NUMBER(10,0) NOT NULL,
    task_id NUMBER(10,0),
    name VARCHAR2(50) NOT NULL,
    int_value NUMBER(10,0),
    str_value VARCHAR2(500),
    float_value NUMBER(22,10),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE pluggable_task_parameter
    ADD CONSTRAINT pluggable_task_parameter_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- pluggable_task_type
-----------------------------------------------------------------------------
DROP TABLE pluggable_task_type CASCADE CONSTRAINTS;

CREATE TABLE pluggable_task_type
(
    id NUMBER(10,0) NOT NULL,
    category_id NUMBER(10,0) NOT NULL,
    class_name VARCHAR2(200) NOT NULL,
    min_parameters NUMBER(10,0) NOT NULL
);

ALTER TABLE pluggable_task_type
    ADD CONSTRAINT pluggable_task_type_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- pluggable_task_type_category
-----------------------------------------------------------------------------
DROP TABLE pluggable_task_type_category CASCADE CONSTRAINTS;

CREATE TABLE pluggable_task_type_category
(
    id NUMBER(10,0) NOT NULL,
    description VARCHAR2(50) NOT NULL,
    interface_name VARCHAR2(200) NOT NULL
);

ALTER TABLE pluggable_task_type_category
    ADD CONSTRAINT pluggable_task_type_categor_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- preference
-----------------------------------------------------------------------------
DROP TABLE preference CASCADE CONSTRAINTS;

CREATE TABLE preference
(
    id NUMBER(10,0) NOT NULL,
    type_id NUMBER(10,0),
    table_id NUMBER(10,0) NOT NULL,
    foreign_id NUMBER(10,0) NOT NULL,
    int_value NUMBER(10,0),
    str_value VARCHAR2(200),
    float_value NUMBER(22,10)
);

ALTER TABLE preference
    ADD CONSTRAINT preference_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- preference_type
-----------------------------------------------------------------------------
DROP TABLE preference_type CASCADE CONSTRAINTS;

CREATE TABLE preference_type
(
    id NUMBER(10,0) NOT NULL,
    int_def_value NUMBER(10,0),
    str_def_value VARCHAR2(200),
    float_def_value NUMBER(22,10)
);

ALTER TABLE preference_type
    ADD CONSTRAINT preference_type_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- promotion
-----------------------------------------------------------------------------
DROP TABLE promotion CASCADE CONSTRAINTS;

CREATE TABLE promotion
(
    id NUMBER(10,0) NOT NULL,
    item_id NUMBER(10,0),
    code VARCHAR2(50) NOT NULL,
    notes VARCHAR2(200),
    once NUMBER(5,0) NOT NULL,
    since DATE,
    until DATE
);

ALTER TABLE promotion
    ADD CONSTRAINT promotion_PK
PRIMARY KEY (id);

CREATE INDEX ix_promotion_code ON promotion (code);





-----------------------------------------------------------------------------
-- purchase_order
-----------------------------------------------------------------------------
DROP TABLE purchase_order CASCADE CONSTRAINTS;

CREATE TABLE purchase_order
(
    id NUMBER(10,0) NOT NULL,
    user_id NUMBER(10,0),
    period_id NUMBER(10,0),
    billing_type_id NUMBER(10,0) NOT NULL,
    active_since DATE,
    active_until DATE,
    cycle_start DATE,
    create_datetime TIMESTAMP NOT NULL,
    next_billable_day DATE,
    created_by NUMBER(10,0),
    status_id NUMBER(10,0) NOT NULL,
    currency_id NUMBER(10,0) NOT NULL,
    deleted NUMBER(5,0) default 0 NOT NULL,
    notify NUMBER(5,0),
    last_notified TIMESTAMP,
    notification_step NUMBER(10,0),
    due_date_unit_id NUMBER(10,0),
    due_date_value NUMBER(10,0),
    df_fm NUMBER(5,0),
    anticipate_periods NUMBER(10,0),
    own_invoice NUMBER(5,0),
    notes VARCHAR2(200),
    notes_in_invoice NUMBER(5,0),
    is_current NUMBER(5,0),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_PK
PRIMARY KEY (id);

CREATE INDEX purchase_order_i_user ON purchase_order (user_id, deleted);
CREATE INDEX purchase_order_i_notif ON purchase_order (active_until, notification_step);
CREATE INDEX ix_purchase_order_date ON purchase_order (user_id, create_datetime);





-----------------------------------------------------------------------------
-- report
-----------------------------------------------------------------------------
DROP TABLE report CASCADE CONSTRAINTS;

CREATE TABLE report
(
    id NUMBER(10,0) NOT NULL,
    titlekey VARCHAR2(50),
    instructionskey VARCHAR2(50),
    tables_list VARCHAR2(1000) NOT NULL,
    where_str VARCHAR2(1000) NOT NULL,
    id_column NUMBER(5,0) NOT NULL,
    link VARCHAR2(200),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE report
    ADD CONSTRAINT report_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- report_entity_map
-----------------------------------------------------------------------------
DROP TABLE report_entity_map CASCADE CONSTRAINTS;

CREATE TABLE report_entity_map
(
    entity_id NUMBER(10,0),
    report_id NUMBER(10,0)
);


CREATE INDEX report_entity_map_i_2 ON report_entity_map (entity_id, report_id);





-----------------------------------------------------------------------------
-- report_field
-----------------------------------------------------------------------------
DROP TABLE report_field CASCADE CONSTRAINTS;

CREATE TABLE report_field
(
    id NUMBER(10,0) NOT NULL,
    report_id NUMBER(10,0),
    report_user_id NUMBER(10,0),
    position_number NUMBER(10,0) NOT NULL,
    table_name VARCHAR2(50) NOT NULL,
    column_name VARCHAR2(50) NOT NULL,
    order_position NUMBER(10,0),
    where_value VARCHAR2(50),
    title_key VARCHAR2(50),
    function_name VARCHAR2(10),
    is_grouped NUMBER(10,0) NOT NULL,
    is_shown NUMBER(5,0) NOT NULL,
    data_type VARCHAR2(10) NOT NULL,
    operator_value VARCHAR2(2),
    functionable NUMBER(5,0) NOT NULL,
    selectable NUMBER(5,0) NOT NULL,
    ordenable NUMBER(5,0) NOT NULL,
    operatorable NUMBER(5,0) NOT NULL,
    whereable NUMBER(5,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE report_field
    ADD CONSTRAINT report_field_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- report_type
-----------------------------------------------------------------------------
DROP TABLE report_type CASCADE CONSTRAINTS;

CREATE TABLE report_type
(
    id NUMBER(10,0) NOT NULL,
    showable NUMBER(5,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE report_type
    ADD CONSTRAINT report_type_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- report_type_map
-----------------------------------------------------------------------------
DROP TABLE report_type_map CASCADE CONSTRAINTS;

CREATE TABLE report_type_map
(
    report_id NUMBER(10,0),
    type_id NUMBER(10,0)
);







-----------------------------------------------------------------------------
-- report_user
-----------------------------------------------------------------------------
DROP TABLE report_user CASCADE CONSTRAINTS;

CREATE TABLE report_user
(
    id NUMBER(10,0) NOT NULL,
    user_id NUMBER(10,0),
    report_id NUMBER(10,0),
    create_datetime TIMESTAMP NOT NULL,
    title VARCHAR2(50),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE report_user
    ADD CONSTRAINT report_user_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- role
-----------------------------------------------------------------------------
DROP TABLE role CASCADE CONSTRAINTS;

CREATE TABLE role
(
    id NUMBER(10,0) NOT NULL
);

ALTER TABLE role
    ADD CONSTRAINT role_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- user_credit_card_map
-----------------------------------------------------------------------------
DROP TABLE user_credit_card_map CASCADE CONSTRAINTS;

CREATE TABLE user_credit_card_map
(
    user_id NUMBER(10,0),
    credit_card_id NUMBER(10,0)
);


CREATE INDEX user_credit_card_map_i_2 ON user_credit_card_map (user_id, credit_card_id);





-----------------------------------------------------------------------------
-- user_role_map
-----------------------------------------------------------------------------
DROP TABLE user_role_map CASCADE CONSTRAINTS;

CREATE TABLE user_role_map
(
    user_id NUMBER(10,0),
    role_id NUMBER(10,0)
);


CREATE INDEX user_role_map_i_2 ON user_role_map (user_id, role_id);
CREATE INDEX user_role_map_i_role ON user_role_map (role_id);





-----------------------------------------------------------------------------
-- mediation_cfg
-----------------------------------------------------------------------------
DROP TABLE mediation_cfg CASCADE CONSTRAINTS;

CREATE TABLE mediation_cfg
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    name VARCHAR2(50) NOT NULL,
    order_value NUMBER(10,0) NOT NULL,
    pluggable_task_id NUMBER(10,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE mediation_cfg
    ADD CONSTRAINT mediation_cfg_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- mediation_process
-----------------------------------------------------------------------------
DROP TABLE mediation_process CASCADE CONSTRAINTS;

CREATE TABLE mediation_process
(
    id NUMBER(10,0) NOT NULL,
    configuration_id NUMBER(10,0) NOT NULL,
    start_datetime TIMESTAMP NOT NULL,
    end_datetime TIMESTAMP default 'NULL',
    orders_affected NUMBER(10,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE mediation_process
    ADD CONSTRAINT mediation_process_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- mediation_order_map
-----------------------------------------------------------------------------
DROP TABLE mediation_order_map CASCADE CONSTRAINTS;

CREATE TABLE mediation_order_map
(
    mediation_process_id NUMBER(10,0) NOT NULL,
    order_id NUMBER(10,0) NOT NULL
);







-----------------------------------------------------------------------------
-- mediation_record
-----------------------------------------------------------------------------
DROP TABLE mediation_record CASCADE CONSTRAINTS;

CREATE TABLE mediation_record
(
    id_key VARCHAR2(100) NOT NULL,
    start_datetime TIMESTAMP NOT NULL,
    mediation_process_id NUMBER(10,0),
    status_id NUMBER(10,0) NOT NULL,
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE mediation_record
    ADD CONSTRAINT mediation_record_PK
PRIMARY KEY (id_key);

CREATE INDEX mediation_record_i ON mediation_record (id_key, status_id);





-----------------------------------------------------------------------------
-- mediation_record_line
-----------------------------------------------------------------------------
DROP TABLE mediation_record_line CASCADE CONSTRAINTS;

CREATE TABLE mediation_record_line
(
    id NUMBER(10,0) NOT NULL,
    mediation_record_id VARCHAR2(100) NOT NULL,
    order_line_id NUMBER(10,0) NOT NULL,
    event_date TIMESTAMP NOT NULL,
    amount NUMBER(22,10) NOT NULL,
    quantity NUMBER(22,10) NOT NULL,
    description VARCHAR2(200),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE mediation_record_line
    ADD CONSTRAINT mediation_record_line_PK
PRIMARY KEY (id);

CREATE INDEX ix_mrl_order_line ON mediation_record_line (order_line_id);





-----------------------------------------------------------------------------
-- blacklist
-----------------------------------------------------------------------------
DROP TABLE blacklist CASCADE CONSTRAINTS;

CREATE TABLE blacklist
(
    id NUMBER(10,0) NOT NULL,
    entity_id NUMBER(10,0) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    type NUMBER(10,0) NOT NULL,
    source NUMBER(10,0) NOT NULL,
    credit_card NUMBER(10,0),
    credit_card_id NUMBER(10,0),
    contact_id NUMBER(10,0),
    user_id NUMBER(10,0),
    OPTLOCK NUMBER(10,0) NOT NULL
);

ALTER TABLE blacklist
    ADD CONSTRAINT blacklist_PK
PRIMARY KEY (id);

CREATE INDEX ix_blacklist_user_type ON blacklist (user_id, type);
CREATE INDEX ix_blacklist_entity_type ON blacklist (entity_id, type);





-----------------------------------------------------------------------------
-- generic_status_type
-----------------------------------------------------------------------------
DROP TABLE generic_status_type CASCADE CONSTRAINTS;

CREATE TABLE generic_status_type
(
    id VARCHAR2(40) NOT NULL
);

ALTER TABLE generic_status_type
    ADD CONSTRAINT generic_status_type_PK
PRIMARY KEY (id);






-----------------------------------------------------------------------------
-- generic_status
-----------------------------------------------------------------------------
DROP TABLE generic_status CASCADE CONSTRAINTS;

CREATE TABLE generic_status
(
    id NUMBER(10,0) NOT NULL,
    dtype VARCHAR2(40) NOT NULL,
    status_value NUMBER(10,0) NOT NULL,
    can_login NUMBER(5,0)
);

ALTER TABLE generic_status
    ADD CONSTRAINT generic_status_PK
PRIMARY KEY (id);





ALTER TABLE ach
    ADD CONSTRAINT ach_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;



ALTER TABLE ageing_entity_step
    ADD CONSTRAINT ageing_entity_step_FK_1 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
;

ALTER TABLE ageing_entity_step
    ADD CONSTRAINT ageing_entity_step_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;



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



ALTER TABLE billing_process
    ADD CONSTRAINT billing_process_FK_1 FOREIGN KEY (period_unit_id)
    REFERENCES period_unit (id)
;

ALTER TABLE billing_process
    ADD CONSTRAINT billing_process_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;

ALTER TABLE billing_process
    ADD CONSTRAINT billing_process_FK_3 FOREIGN KEY (paper_invoice_batch_id)
    REFERENCES paper_invoice_batch (id)
;



ALTER TABLE billing_process_configuration
    ADD CONSTRAINT billing_process_configura_FK_1 FOREIGN KEY (period_unit_id)
    REFERENCES period_unit (id)
;

ALTER TABLE billing_process_configuration
    ADD CONSTRAINT billing_process_configura_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;



ALTER TABLE process_run
    ADD CONSTRAINT process_run_FK_1 FOREIGN KEY (process_id)
    REFERENCES billing_process (id)
;

ALTER TABLE process_run
    ADD CONSTRAINT process_run_FK_2 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
;



ALTER TABLE process_run_total
    ADD CONSTRAINT process_run_total_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;

ALTER TABLE process_run_total
    ADD CONSTRAINT process_run_total_FK_2 FOREIGN KEY (process_run_id)
    REFERENCES process_run (id)
;



ALTER TABLE process_run_total_pm
    ADD CONSTRAINT process_run_total_pm_FK_1 FOREIGN KEY (payment_method_id)
    REFERENCES payment_method (id)
;



ALTER TABLE process_run_user
    ADD CONSTRAINT process_run_user_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;

ALTER TABLE process_run_user
    ADD CONSTRAINT process_run_user_FK_2 FOREIGN KEY (process_run_id)
    REFERENCES process_run (id)
;





ALTER TABLE contact_field
    ADD CONSTRAINT contact_field_FK_1 FOREIGN KEY (contact_id)
    REFERENCES contact (id)
;

ALTER TABLE contact_field
    ADD CONSTRAINT contact_field_FK_2 FOREIGN KEY (type_id)
    REFERENCES contact_field_type (id)
;



ALTER TABLE contact_field_type
    ADD CONSTRAINT contact_field_type_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;



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



ALTER TABLE contact_type
    ADD CONSTRAINT contact_type_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;









ALTER TABLE currency_entity_map
    ADD CONSTRAINT currency_entity_map_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;

ALTER TABLE currency_entity_map
    ADD CONSTRAINT currency_entity_map_FK_2 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;



ALTER TABLE currency_exchange
    ADD CONSTRAINT currency_exchange_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;



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



ALTER TABLE entity
    ADD CONSTRAINT entity_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;

ALTER TABLE entity
    ADD CONSTRAINT entity_FK_2 FOREIGN KEY (language_id)
    REFERENCES language (id)
;



ALTER TABLE entity_delivery_method_map
    ADD CONSTRAINT entity_delivery_method_ma_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;

ALTER TABLE entity_delivery_method_map
    ADD CONSTRAINT entity_delivery_method_ma_FK_2 FOREIGN KEY (method_id)
    REFERENCES invoice_delivery_method (id)
;



ALTER TABLE entity_payment_method_map
    ADD CONSTRAINT entity_payment_method_map_FK_1 FOREIGN KEY (payment_method_id)
    REFERENCES payment_method (id)
;

ALTER TABLE entity_payment_method_map
    ADD CONSTRAINT entity_payment_method_map_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;



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







ALTER TABLE international_description
    ADD CONSTRAINT international_description_FK_1 FOREIGN KEY (language_id)
    REFERENCES language (id)
;

ALTER TABLE international_description
    ADD CONSTRAINT international_description_FK_2 FOREIGN KEY (table_id)
    REFERENCES jbilling_table (id)
;



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





ALTER TABLE item
    ADD CONSTRAINT item_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;



ALTER TABLE item_price
    ADD CONSTRAINT item_price_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;

ALTER TABLE item_price
    ADD CONSTRAINT item_price_FK_2 FOREIGN KEY (item_id)
    REFERENCES item (id)
;



ALTER TABLE item_type
    ADD CONSTRAINT item_type_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;



ALTER TABLE item_type_map
    ADD CONSTRAINT item_type_map_FK_1 FOREIGN KEY (item_id)
    REFERENCES item (id)
;

ALTER TABLE item_type_map
    ADD CONSTRAINT item_type_map_FK_2 FOREIGN KEY (type_id)
    REFERENCES item_type (id)
;











ALTER TABLE list_entity
    ADD CONSTRAINT list_entity_FK_1 FOREIGN KEY (list_id)
    REFERENCES list (id)
;

ALTER TABLE list_entity
    ADD CONSTRAINT list_entity_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;



ALTER TABLE list_field
    ADD CONSTRAINT list_field_FK_1 FOREIGN KEY (list_id)
    REFERENCES list (id)
;



ALTER TABLE list_field_entity
    ADD CONSTRAINT list_field_entity_FK_1 FOREIGN KEY (list_entity_id)
    REFERENCES list_entity (id)
;

ALTER TABLE list_field_entity
    ADD CONSTRAINT list_field_entity_FK_2 FOREIGN KEY (list_field_id)
    REFERENCES list_field (id)
;



ALTER TABLE menu_option
    ADD CONSTRAINT menu_option_FK_1 FOREIGN KEY (parent_id)
    REFERENCES menu_option (id)
;



ALTER TABLE notification_message
    ADD CONSTRAINT notification_message_FK_1 FOREIGN KEY (language_id)
    REFERENCES language (id)
;

ALTER TABLE notification_message
    ADD CONSTRAINT notification_message_FK_2 FOREIGN KEY (type_id)
    REFERENCES notification_message_type (id)
;

ALTER TABLE notification_message
    ADD CONSTRAINT notification_message_FK_3 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;





ALTER TABLE notification_message_arch_line
    ADD CONSTRAINT notif_mess_arch_line_FK_1 FOREIGN KEY (message_archive_id)
    REFERENCES notification_message_arch (id)
;



ALTER TABLE notification_message_line
    ADD CONSTRAINT notification_message_line_FK_1 FOREIGN KEY (message_section_id)
    REFERENCES notification_message_section (id)
;



ALTER TABLE notification_message_section
    ADD CONSTRAINT notification_message_sect_FK_1 FOREIGN KEY (message_id)
    REFERENCES notification_message (id)
;







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





ALTER TABLE order_period
    ADD CONSTRAINT order_period_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;

ALTER TABLE order_period
    ADD CONSTRAINT order_period_FK_2 FOREIGN KEY (unit_id)
    REFERENCES period_unit (id)
;



ALTER TABLE order_process
    ADD CONSTRAINT order_process_FK_1 FOREIGN KEY (order_id)
    REFERENCES purchase_order (id)
;





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



ALTER TABLE partner_payout
    ADD CONSTRAINT partner_payout_FK_1 FOREIGN KEY (partner_id)
    REFERENCES partner (id)
;





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



ALTER TABLE payment_authorization
    ADD CONSTRAINT payment_authorization_FK_1 FOREIGN KEY (payment_id)
    REFERENCES payment (id)
;



ALTER TABLE payment_info_cheque
    ADD CONSTRAINT payment_info_cheque_FK_1 FOREIGN KEY (payment_id)
    REFERENCES payment (id)
;



ALTER TABLE payment_invoice
    ADD CONSTRAINT payment_invoice_FK_1 FOREIGN KEY (invoice_id)
    REFERENCES invoice (id)
;

ALTER TABLE payment_invoice
    ADD CONSTRAINT payment_invoice_FK_2 FOREIGN KEY (payment_id)
    REFERENCES payment (id)
;









ALTER TABLE permission
    ADD CONSTRAINT permission_FK_1 FOREIGN KEY (type_id)
    REFERENCES permission_type (id)
;



ALTER TABLE permission_role_map
    ADD CONSTRAINT permission_role_map_FK_1 FOREIGN KEY (role_id)
    REFERENCES role (id)
;

ALTER TABLE permission_role_map
    ADD CONSTRAINT permission_role_map_FK_2 FOREIGN KEY (permission_id)
    REFERENCES permission (id)
;





ALTER TABLE permission_user
    ADD CONSTRAINT permission_user_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;

ALTER TABLE permission_user
    ADD CONSTRAINT permission_user_FK_2 FOREIGN KEY (permission_id)
    REFERENCES permission (id)
;



ALTER TABLE pluggable_task
    ADD CONSTRAINT pluggable_task_FK_1 FOREIGN KEY (type_id)
    REFERENCES pluggable_task_type (id)
;

ALTER TABLE pluggable_task
    ADD CONSTRAINT pluggable_task_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;



ALTER TABLE pluggable_task_parameter
    ADD CONSTRAINT pluggable_task_parameter_FK_1 FOREIGN KEY (task_id)
    REFERENCES pluggable_task (id)
;



ALTER TABLE pluggable_task_type
    ADD CONSTRAINT pluggable_task_type_FK_1 FOREIGN KEY (category_id)
    REFERENCES pluggable_task_type_category (id)
;





ALTER TABLE preference
    ADD CONSTRAINT preference_FK_1 FOREIGN KEY (type_id)
    REFERENCES preference_type (id)
;

ALTER TABLE preference
    ADD CONSTRAINT preference_FK_2 FOREIGN KEY (table_id)
    REFERENCES jbilling_table (id)
;





ALTER TABLE promotion
    ADD CONSTRAINT promotion_FK_1 FOREIGN KEY (item_id)
    REFERENCES item (id)
;



ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
;

ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_2 FOREIGN KEY (billing_type_id)
    REFERENCES order_billing_type (id)
;

ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_3 FOREIGN KEY (period_id)
    REFERENCES order_period (id)
;

ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_4 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;

ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_5 FOREIGN KEY (created_by)
    REFERENCES base_user (id)
;

ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_6 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
;





ALTER TABLE report_entity_map
    ADD CONSTRAINT report_entity_map_FK_1 FOREIGN KEY (report_id)
    REFERENCES report (id)
;

ALTER TABLE report_entity_map
    ADD CONSTRAINT report_entity_map_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;



ALTER TABLE report_field
    ADD CONSTRAINT report_field_FK_1 FOREIGN KEY (report_id)
    REFERENCES report (id)
;





ALTER TABLE report_type_map
    ADD CONSTRAINT report_type_map_FK_1 FOREIGN KEY (type_id)
    REFERENCES report_type (id)
;

ALTER TABLE report_type_map
    ADD CONSTRAINT report_type_map_FK_2 FOREIGN KEY (report_id)
    REFERENCES report (id)
;



ALTER TABLE report_user
    ADD CONSTRAINT report_user_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;

ALTER TABLE report_user
    ADD CONSTRAINT report_user_FK_2 FOREIGN KEY (report_id)
    REFERENCES report (id)
;







ALTER TABLE user_role_map
    ADD CONSTRAINT user_role_map_FK_1 FOREIGN KEY (role_id)
    REFERENCES role (id)
;

ALTER TABLE user_role_map
    ADD CONSTRAINT user_role_map_FK_2 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;



ALTER TABLE mediation_cfg
    ADD CONSTRAINT mediation_cfg_FK_1 FOREIGN KEY (pluggable_task_id)
    REFERENCES pluggable_task (id)
;



ALTER TABLE mediation_process
    ADD CONSTRAINT mediation_process_FK_1 FOREIGN KEY (configuration_id)
    REFERENCES mediation_cfg (id)
;



ALTER TABLE mediation_order_map
    ADD CONSTRAINT mediation_order_map_FK_1 FOREIGN KEY (mediation_process_id)
    REFERENCES mediation_process (id)
;

ALTER TABLE mediation_order_map
    ADD CONSTRAINT mediation_order_map_FK_2 FOREIGN KEY (order_id)
    REFERENCES purchase_order (id)
;



ALTER TABLE mediation_record
    ADD CONSTRAINT mediation_record_FK_1 FOREIGN KEY (mediation_process_id)
    REFERENCES mediation_process (id)
;

ALTER TABLE mediation_record
    ADD CONSTRAINT mediation_record_FK_2 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
;



ALTER TABLE mediation_record_line
    ADD CONSTRAINT mediation_record_line_FK_1 FOREIGN KEY (mediation_record_id)
    REFERENCES mediation_record (id_key)
;

ALTER TABLE mediation_record_line
    ADD CONSTRAINT mediation_record_line_FK_2 FOREIGN KEY (order_line_id)
    REFERENCES order_line (id)
;



ALTER TABLE blacklist
    ADD CONSTRAINT blacklist_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
;

ALTER TABLE blacklist
    ADD CONSTRAINT blacklist_FK_2 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
;





ALTER TABLE generic_status
    ADD CONSTRAINT generic_status_FK_1 FOREIGN KEY (dtype)
    REFERENCES generic_status_type (id)
;



