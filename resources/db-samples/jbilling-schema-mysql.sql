
# -----------------------------------------------------------------------
# ach
# -----------------------------------------------------------------------
drop table if exists ach;

CREATE TABLE ach
(
    id MEDIUMINT NOT NULL,
    user_id MEDIUMINT,
    aba_routing VARCHAR(40) NOT NULL,
    bank_account VARCHAR(60) NOT NULL,
    account_type MEDIUMINT NOT NULL,
    bank_name VARCHAR(50) NOT NULL,
    account_name VARCHAR(100) NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (user_id) REFERENCES base_user (id)
    ,
    INDEX ach_i_2 (user_id));

# -----------------------------------------------------------------------
# ageing_entity_step
# -----------------------------------------------------------------------
drop table if exists ageing_entity_step;

CREATE TABLE ageing_entity_step
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT,
    status_id MEDIUMINT,
    days MEDIUMINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (status_id) REFERENCES generic_status (id)
    ,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    );

# -----------------------------------------------------------------------
# base_user
# -----------------------------------------------------------------------
drop table if exists base_user;

CREATE TABLE base_user
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT,
    password VARCHAR(40),
    deleted SMALLINT default 0 NOT NULL,
    language_id MEDIUMINT,
    status_id MEDIUMINT,
    subscriber_status MEDIUMINT default 1,
    currency_id MEDIUMINT,
    create_datetime TIMESTAMP NOT NULL,
    last_status_change TIMESTAMP,
    last_login TIMESTAMP,
    user_name VARCHAR(50),
    failed_attempts MEDIUMINT default 0 NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (status_id) REFERENCES generic_status (id)
    ,
    FOREIGN KEY (subscriber_status) REFERENCES generic_status (id)
    ,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    ,
    FOREIGN KEY (language_id) REFERENCES language (id)
    ,
    FOREIGN KEY (currency_id) REFERENCES currency (id)
    ,
    INDEX ix_base_user_un (entity_id, user_name));

# -----------------------------------------------------------------------
# billing_process
# -----------------------------------------------------------------------
drop table if exists billing_process;

CREATE TABLE billing_process
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT NOT NULL,
    billing_date DATETIME NOT NULL,
    period_unit_id MEDIUMINT NOT NULL,
    period_value MEDIUMINT NOT NULL,
    is_review MEDIUMINT NOT NULL,
    paper_invoice_batch_id MEDIUMINT,
    retries_to_do MEDIUMINT default 0 NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (period_unit_id) REFERENCES period_unit (id)
    ,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    ,
    FOREIGN KEY (paper_invoice_batch_id) REFERENCES paper_invoice_batch (id)
    );

# -----------------------------------------------------------------------
# billing_process_configuration
# -----------------------------------------------------------------------
drop table if exists billing_process_configuration;

CREATE TABLE billing_process_configuration
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT,
    next_run_date DATETIME NOT NULL,
    generate_report SMALLINT NOT NULL,
    retries MEDIUMINT,
    days_for_retry MEDIUMINT,
    days_for_report MEDIUMINT,
    review_status MEDIUMINT NOT NULL,
    period_unit_id MEDIUMINT NOT NULL,
    period_value MEDIUMINT NOT NULL,
    due_date_unit_id MEDIUMINT NOT NULL,
    due_date_value MEDIUMINT NOT NULL,
    df_fm SMALLINT,
    only_recurring SMALLINT default 1 NOT NULL,
    invoice_date_process SMALLINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    auto_payment SMALLINT default 0 NOT NULL,
    maximum_periods MEDIUMINT default 1 NOT NULL,
    auto_payment_application MEDIUMINT default 0 NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (period_unit_id) REFERENCES period_unit (id)
    ,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    );

# -----------------------------------------------------------------------
# process_run
# -----------------------------------------------------------------------
drop table if exists process_run;

CREATE TABLE process_run
(
    id MEDIUMINT NOT NULL,
    process_id MEDIUMINT,
    run_date DATETIME NOT NULL,
    started TIMESTAMP NOT NULL,
    finished TIMESTAMP,
    payment_finished TIMESTAMP,
    invoices_generated MEDIUMINT,
    OPTLOCK MEDIUMINT NOT NULL,
    status_id MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (process_id) REFERENCES billing_process (id)
    ,
    FOREIGN KEY (status_id) REFERENCES generic_status (id)
    ,
    INDEX bp_run_process_ix (process_id));

# -----------------------------------------------------------------------
# process_run_total
# -----------------------------------------------------------------------
drop table if exists process_run_total;

CREATE TABLE process_run_total
(
    id MEDIUMINT NOT NULL,
    process_run_id MEDIUMINT,
    currency_id MEDIUMINT NOT NULL,
    total_invoiced DECIMAL(22,10),
    total_paid DECIMAL(22,10),
    total_not_paid DECIMAL(22,10),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (currency_id) REFERENCES currency (id)
    ,
    FOREIGN KEY (process_run_id) REFERENCES process_run (id)
    ,
    INDEX bp_run_total_run_ix (process_run_id));

# -----------------------------------------------------------------------
# process_run_total_pm
# -----------------------------------------------------------------------
drop table if exists process_run_total_pm;

CREATE TABLE process_run_total_pm
(
    id MEDIUMINT NOT NULL,
    process_run_total_id MEDIUMINT,
    payment_method_id MEDIUMINT,
    total DECIMAL(22,10) NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method (id)
    ,
    INDEX bp_pm_index_total (process_run_total_id));

# -----------------------------------------------------------------------
# process_run_user
# -----------------------------------------------------------------------
drop table if exists process_run_user;

CREATE TABLE process_run_user
(
    id MEDIUMINT NOT NULL,
    process_run_id MEDIUMINT NOT NULL,
    user_id MEDIUMINT NOT NULL,
    status MEDIUMINT NOT NULL,
    created DATETIME NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (user_id) REFERENCES base_user (id)
    ,
    FOREIGN KEY (process_run_id) REFERENCES process_run (id)
    ,
    INDEX bp_run_user_run_ix (process_run_id),
    INDEX bp_run_user_user_ix (user_id));

# -----------------------------------------------------------------------
# contact
# -----------------------------------------------------------------------
drop table if exists contact;

CREATE TABLE contact
(
    id MEDIUMINT NOT NULL,
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
    phone_country_code MEDIUMINT,
    phone_area_code MEDIUMINT,
    phone_phone_number VARCHAR(20),
    fax_country_code MEDIUMINT,
    fax_area_code MEDIUMINT,
    fax_phone_number VARCHAR(20),
    email VARCHAR(200),
    create_datetime TIMESTAMP NOT NULL,
    deleted SMALLINT default 0 NOT NULL,
    notification_include SMALLINT default 1,
    user_id MEDIUMINT,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    INDEX ix_contact_fname (first_name),
    INDEX ix_contact_lname (last_name),
    INDEX ix_contact_orgname (organization_name),
    INDEX contact_i_del (deleted),
    INDEX ix_contact_fname_lname (first_name, last_name),
    INDEX ix_contact_address (street_addres1, city, postal_code, street_addres2, state_province, country_code),
    INDEX ix_contact_phone (phone_phone_number, phone_area_code, phone_country_code));

# -----------------------------------------------------------------------
# contact_field
# -----------------------------------------------------------------------
drop table if exists contact_field;

CREATE TABLE contact_field
(
    id MEDIUMINT NOT NULL,
    type_id MEDIUMINT,
    contact_id MEDIUMINT,
    content VARCHAR(100) NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (contact_id) REFERENCES contact (id)
    ,
    FOREIGN KEY (type_id) REFERENCES contact_field_type (id)
    ,
    INDEX ix_contact_field_cid (contact_id),
    INDEX ix_contact_field_content (content));

# -----------------------------------------------------------------------
# contact_field_type
# -----------------------------------------------------------------------
drop table if exists contact_field_type;

CREATE TABLE contact_field_type
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT,
    prompt_key VARCHAR(50) NOT NULL,
    data_type VARCHAR(10) NOT NULL,
    customer_readonly SMALLINT,
    PRIMARY KEY(id),
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    ,
    INDEX ix_cf_type_entity (entity_id));

# -----------------------------------------------------------------------
# contact_map
# -----------------------------------------------------------------------
drop table if exists contact_map;

CREATE TABLE contact_map
(
    id MEDIUMINT NOT NULL,
    contact_id MEDIUMINT,
    type_id MEDIUMINT NOT NULL,
    table_id MEDIUMINT NOT NULL,
    foreign_id MEDIUMINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (table_id) REFERENCES jbilling_table (id)
    ,
    FOREIGN KEY (type_id) REFERENCES contact_type (id)
    ,
    FOREIGN KEY (contact_id) REFERENCES contact (id)
    ,
    INDEX contact_map_i_3 (contact_id),
    INDEX contact_map_i_1 (table_id, foreign_id, type_id));

# -----------------------------------------------------------------------
# contact_type
# -----------------------------------------------------------------------
drop table if exists contact_type;

CREATE TABLE contact_type
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT,
    is_primary SMALLINT,
    PRIMARY KEY(id),
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    );

# -----------------------------------------------------------------------
# country
# -----------------------------------------------------------------------
drop table if exists country;

CREATE TABLE country
(
    id MEDIUMINT NOT NULL,
    code VARCHAR(2) NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# credit_card
# -----------------------------------------------------------------------
drop table if exists credit_card;

CREATE TABLE credit_card
(
    id MEDIUMINT NOT NULL,
    cc_number VARCHAR(100) NOT NULL,
    cc_number_plain VARCHAR(20),
    cc_expiry DATETIME NOT NULL,
    name VARCHAR(150),
    cc_type MEDIUMINT NOT NULL,
    deleted SMALLINT default 0 NOT NULL,
    gateway_key VARCHAR(100),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    INDEX ix_cc_number (cc_number_plain),
    INDEX ix_cc_number_encrypted (cc_number));

# -----------------------------------------------------------------------
# currency
# -----------------------------------------------------------------------
drop table if exists currency;

CREATE TABLE currency
(
    id MEDIUMINT NOT NULL,
    symbol VARCHAR(10) NOT NULL,
    code VARCHAR(3) NOT NULL,
    country_code VARCHAR(2) NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# currency_entity_map
# -----------------------------------------------------------------------
drop table if exists currency_entity_map;

CREATE TABLE currency_entity_map
(
    currency_id MEDIUMINT,
    entity_id MEDIUMINT,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    ,
    FOREIGN KEY (currency_id) REFERENCES currency (id)
    ,
    INDEX currency_entity_map_i_2 (currency_id, entity_id));

# -----------------------------------------------------------------------
# currency_exchange
# -----------------------------------------------------------------------
drop table if exists currency_exchange;

CREATE TABLE currency_exchange
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT,
    currency_id MEDIUMINT,
    rate DECIMAL(22,10) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (currency_id) REFERENCES currency (id)
    );

# -----------------------------------------------------------------------
# customer
# -----------------------------------------------------------------------
drop table if exists customer;

CREATE TABLE customer
(
    id MEDIUMINT NOT NULL,
    user_id MEDIUMINT,
    partner_id MEDIUMINT,
    referral_fee_paid SMALLINT,
    invoice_delivery_method_id MEDIUMINT NOT NULL,
    notes VARCHAR(1000),
    auto_payment_type MEDIUMINT,
    due_date_unit_id MEDIUMINT,
    due_date_value MEDIUMINT,
    df_fm SMALLINT,
    parent_id MEDIUMINT,
    is_parent SMALLINT,
    exclude_aging SMALLINT default 0 NOT NULL,
    invoice_child SMALLINT,
    current_order_id MEDIUMINT,
    balance_type MEDIUMINT default 1 NOT NULL,
    dynamic_balance DECIMAL(22,10),
    credit_limit DECIMAL(22,10),
    auto_recharge DECIMAL(22,10),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (invoice_delivery_method_id) REFERENCES invoice_delivery_method (id)
    ,
    FOREIGN KEY (partner_id) REFERENCES partner (id)
    ,
    FOREIGN KEY (user_id) REFERENCES base_user (id)
    ,
    INDEX customer_i_2 (user_id));

# -----------------------------------------------------------------------
# entity
# -----------------------------------------------------------------------
drop table if exists entity;

CREATE TABLE entity
(
    id MEDIUMINT NOT NULL,
    external_id VARCHAR(20),
    description VARCHAR(100) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    language_id MEDIUMINT NOT NULL,
    currency_id MEDIUMINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (currency_id) REFERENCES currency (id)
    ,
    FOREIGN KEY (language_id) REFERENCES language (id)
    );

# -----------------------------------------------------------------------
# entity_delivery_method_map
# -----------------------------------------------------------------------
drop table if exists entity_delivery_method_map;

CREATE TABLE entity_delivery_method_map
(
    method_id MEDIUMINT,
    entity_id MEDIUMINT,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    ,
    FOREIGN KEY (method_id) REFERENCES invoice_delivery_method (id)
    );

# -----------------------------------------------------------------------
# entity_payment_method_map
# -----------------------------------------------------------------------
drop table if exists entity_payment_method_map;

CREATE TABLE entity_payment_method_map
(
    entity_id MEDIUMINT,
    payment_method_id MEDIUMINT,
    FOREIGN KEY (payment_method_id) REFERENCES payment_method (id)
    ,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    );

# -----------------------------------------------------------------------
# event_log
# -----------------------------------------------------------------------
drop table if exists event_log;

CREATE TABLE event_log
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT,
    user_id MEDIUMINT,
    affected_user_id MEDIUMINT,
    table_id MEDIUMINT,
    foreign_id MEDIUMINT NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    level_field MEDIUMINT NOT NULL,
    module_id MEDIUMINT NOT NULL,
    message_id MEDIUMINT NOT NULL,
    old_num MEDIUMINT,
    old_str VARCHAR(1000),
    old_date TIMESTAMP,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (module_id) REFERENCES event_log_module (id)
    ,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    ,
    FOREIGN KEY (user_id) REFERENCES base_user (id)
    ,
    FOREIGN KEY (affected_user_id) REFERENCES base_user (id)
    ,
    FOREIGN KEY (table_id) REFERENCES jbilling_table (id)
    ,
    FOREIGN KEY (message_id) REFERENCES event_log_message (id)
    ,
    INDEX ix_el_main (module_id, message_id, create_datetime));

# -----------------------------------------------------------------------
# event_log_message
# -----------------------------------------------------------------------
drop table if exists event_log_message;

CREATE TABLE event_log_message
(
    id MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# event_log_module
# -----------------------------------------------------------------------
drop table if exists event_log_module;

CREATE TABLE event_log_module
(
    id MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# international_description
# -----------------------------------------------------------------------
drop table if exists international_description;

CREATE TABLE international_description
(
    table_id MEDIUMINT NOT NULL,
    foreign_id MEDIUMINT NOT NULL,
    psudo_column VARCHAR(20) NOT NULL,
    language_id MEDIUMINT NOT NULL,
    content VARCHAR(4000) NOT NULL,
    PRIMARY KEY(table_id,foreign_id,psudo_column,language_id),
    FOREIGN KEY (language_id) REFERENCES language (id)
    ,
    FOREIGN KEY (table_id) REFERENCES jbilling_table (id)
    ,
    INDEX international_description_i_2 (table_id, foreign_id, language_id),
    INDEX int_description_i_lan (language_id));

# -----------------------------------------------------------------------
# invoice
# -----------------------------------------------------------------------
drop table if exists invoice;

CREATE TABLE invoice
(
    id MEDIUMINT NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    billing_process_id MEDIUMINT,
    user_id MEDIUMINT,
    status_id MEDIUMINT NOT NULL,
    delegated_invoice_id MEDIUMINT,
    due_date DATETIME NOT NULL,
    total DECIMAL(22,10) NOT NULL,
    payment_attempts MEDIUMINT default 0 NOT NULL,
    balance DECIMAL(22,10),
    carried_balance DECIMAL(22,10) NOT NULL,
    in_process_payment SMALLINT default 1 NOT NULL,
    is_review MEDIUMINT NOT NULL,
    currency_id MEDIUMINT NOT NULL,
    deleted SMALLINT default 0 NOT NULL,
    paper_invoice_batch_id MEDIUMINT,
    customer_notes VARCHAR(1000),
    public_number VARCHAR(40),
    last_reminder DATETIME,
    overdue_step MEDIUMINT,
    create_timestamp TIMESTAMP NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (billing_process_id) REFERENCES billing_process (id)
    ,
    FOREIGN KEY (paper_invoice_batch_id) REFERENCES paper_invoice_batch (id)
    ,
    FOREIGN KEY (currency_id) REFERENCES currency (id)
    ,
    FOREIGN KEY (delegated_invoice_id) REFERENCES invoice (id)
    ,
    FOREIGN KEY (status_id) REFERENCES generic_status (id)
    ,
    INDEX ix_invoice_user_id (user_id, deleted),
    INDEX ix_invoice_date (create_datetime),
    INDEX ix_invoice_number (user_id, public_number),
    INDEX ix_invoice_due_date (user_id, due_date),
    INDEX ix_invoice_ts (create_timestamp, user_id),
    INDEX ix_invoice_process (billing_process_id));

# -----------------------------------------------------------------------
# invoice_delivery_method
# -----------------------------------------------------------------------
drop table if exists invoice_delivery_method;

CREATE TABLE invoice_delivery_method
(
    id MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# invoice_line
# -----------------------------------------------------------------------
drop table if exists invoice_line;

CREATE TABLE invoice_line
(
    id MEDIUMINT NOT NULL,
    invoice_id MEDIUMINT,
    type_id MEDIUMINT,
    amount DECIMAL(22,10) NOT NULL,
    quantity DECIMAL(22,10),
    price DECIMAL(22,10),
    deleted SMALLINT default 0 NOT NULL,
    item_id MEDIUMINT,
    description VARCHAR(1000),
    source_user_id MEDIUMINT,
    is_percentage SMALLINT default 0 NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (invoice_id) REFERENCES invoice (id)
    ,
    FOREIGN KEY (item_id) REFERENCES item (id)
    ,
    FOREIGN KEY (type_id) REFERENCES invoice_line_type (id)
    ,
    INDEX ix_invoice_line_invoice_id (invoice_id));

# -----------------------------------------------------------------------
# invoice_line_type
# -----------------------------------------------------------------------
drop table if exists invoice_line_type;

CREATE TABLE invoice_line_type
(
    id MEDIUMINT NOT NULL,
    description VARCHAR(50) NOT NULL,
    order_position MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# item
# -----------------------------------------------------------------------
drop table if exists item;

CREATE TABLE item
(
    id MEDIUMINT NOT NULL,
    internal_number VARCHAR(50),
    entity_id MEDIUMINT,
    percentage DECIMAL(22,10),
    price_manual SMALLINT NOT NULL,
    deleted SMALLINT default 0 NOT NULL,
    has_decimals SMALLINT default 0 NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    ,
    INDEX ix_item_ent (entity_id, internal_number));

# -----------------------------------------------------------------------
# item_price
# -----------------------------------------------------------------------
drop table if exists item_price;

CREATE TABLE item_price
(
    id MEDIUMINT NOT NULL,
    item_id MEDIUMINT,
    currency_id MEDIUMINT,
    price DECIMAL(22,10) NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (currency_id) REFERENCES currency (id)
    ,
    FOREIGN KEY (item_id) REFERENCES item (id)
    );

# -----------------------------------------------------------------------
# item_type
# -----------------------------------------------------------------------
drop table if exists item_type;

CREATE TABLE item_type
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT NOT NULL,
    description VARCHAR(100),
    order_line_type_id MEDIUMINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    );

# -----------------------------------------------------------------------
# item_type_map
# -----------------------------------------------------------------------
drop table if exists item_type_map;

CREATE TABLE item_type_map
(
    item_id MEDIUMINT,
    type_id MEDIUMINT,
    FOREIGN KEY (item_id) REFERENCES item (id)
    ,
    FOREIGN KEY (type_id) REFERENCES item_type (id)
    );

# -----------------------------------------------------------------------
# jbilling_table
# -----------------------------------------------------------------------
drop table if exists jbilling_table;

CREATE TABLE jbilling_table
(
    id MEDIUMINT NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# jbilling_seqs
# -----------------------------------------------------------------------
drop table if exists jbilling_seqs;

CREATE TABLE jbilling_seqs
(
    name VARCHAR(50) NOT NULL,
    next_id MEDIUMINT default 0 NOT NULL);

# -----------------------------------------------------------------------
# language
# -----------------------------------------------------------------------
drop table if exists language;

CREATE TABLE language
(
    id MEDIUMINT NOT NULL,
    code VARCHAR(2) NOT NULL,
    description VARCHAR(50) NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# list
# -----------------------------------------------------------------------
drop table if exists list;

CREATE TABLE list
(
    id MEDIUMINT NOT NULL,
    legacy_name VARCHAR(30),
    title_key VARCHAR(100) NOT NULL,
    instr_key VARCHAR(100),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# list_entity
# -----------------------------------------------------------------------
drop table if exists list_entity;

CREATE TABLE list_entity
(
    id MEDIUMINT NOT NULL,
    list_id MEDIUMINT,
    entity_id MEDIUMINT NOT NULL,
    total_records MEDIUMINT NOT NULL,
    last_update DATETIME NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (list_id) REFERENCES list (id)
    ,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    );

# -----------------------------------------------------------------------
# list_field
# -----------------------------------------------------------------------
drop table if exists list_field;

CREATE TABLE list_field
(
    id MEDIUMINT NOT NULL,
    list_id MEDIUMINT,
    title_key VARCHAR(100) NOT NULL,
    column_name VARCHAR(50) NOT NULL,
    ordenable SMALLINT NOT NULL,
    searchable SMALLINT NOT NULL,
    data_type VARCHAR(10) NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (list_id) REFERENCES list (id)
    );

# -----------------------------------------------------------------------
# list_field_entity
# -----------------------------------------------------------------------
drop table if exists list_field_entity;

CREATE TABLE list_field_entity
(
    id MEDIUMINT NOT NULL,
    list_field_id MEDIUMINT,
    list_entity_id MEDIUMINT,
    min_value MEDIUMINT,
    max_value MEDIUMINT,
    min_str_value VARCHAR(100),
    max_str_value VARCHAR(100),
    min_date_value TIMESTAMP,
    max_date_value TIMESTAMP,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (list_entity_id) REFERENCES list_entity (id)
    ,
    FOREIGN KEY (list_field_id) REFERENCES list_field (id)
    );

# -----------------------------------------------------------------------
# menu_option
# -----------------------------------------------------------------------
drop table if exists menu_option;

CREATE TABLE menu_option
(
    id MEDIUMINT NOT NULL,
    link VARCHAR(100) NOT NULL,
    level_field MEDIUMINT NOT NULL,
    parent_id MEDIUMINT,
    PRIMARY KEY(id),
    FOREIGN KEY (parent_id) REFERENCES menu_option (id)
    );

# -----------------------------------------------------------------------
# notification_message
# -----------------------------------------------------------------------
drop table if exists notification_message;

CREATE TABLE notification_message
(
    id MEDIUMINT NOT NULL,
    type_id MEDIUMINT,
    entity_id MEDIUMINT NOT NULL,
    language_id MEDIUMINT NOT NULL,
    use_flag SMALLINT default 1 NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (language_id) REFERENCES language (id)
    ,
    FOREIGN KEY (type_id) REFERENCES notification_message_type (id)
    ,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    );

# -----------------------------------------------------------------------
# notification_message_arch
# -----------------------------------------------------------------------
drop table if exists notification_message_arch;

CREATE TABLE notification_message_arch
(
    id MEDIUMINT NOT NULL,
    type_id MEDIUMINT,
    create_datetime TIMESTAMP NOT NULL,
    user_id MEDIUMINT,
    result_message VARCHAR(200),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# notification_message_arch_line
# -----------------------------------------------------------------------
drop table if exists notification_message_arch_line;

CREATE TABLE notification_message_arch_line
(
    id MEDIUMINT NOT NULL,
    message_archive_id MEDIUMINT,
    section MEDIUMINT NOT NULL,
    content VARCHAR(1000) NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (message_archive_id) REFERENCES notification_message_arch (id)
    );

# -----------------------------------------------------------------------
# notification_message_line
# -----------------------------------------------------------------------
drop table if exists notification_message_line;

CREATE TABLE notification_message_line
(
    id MEDIUMINT NOT NULL,
    message_section_id MEDIUMINT,
    content VARCHAR(1000) NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (message_section_id) REFERENCES notification_message_section (id)
    );

# -----------------------------------------------------------------------
# notification_message_section
# -----------------------------------------------------------------------
drop table if exists notification_message_section;

CREATE TABLE notification_message_section
(
    id MEDIUMINT NOT NULL,
    message_id MEDIUMINT,
    section MEDIUMINT,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (message_id) REFERENCES notification_message (id)
    );

# -----------------------------------------------------------------------
# notification_message_type
# -----------------------------------------------------------------------
drop table if exists notification_message_type;

CREATE TABLE notification_message_type
(
    id MEDIUMINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# order_billing_type
# -----------------------------------------------------------------------
drop table if exists order_billing_type;

CREATE TABLE order_billing_type
(
    id MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# order_line
# -----------------------------------------------------------------------
drop table if exists order_line;

CREATE TABLE order_line
(
    id MEDIUMINT NOT NULL,
    order_id MEDIUMINT,
    item_id MEDIUMINT,
    type_id MEDIUMINT,
    amount DECIMAL(22,10) NOT NULL,
    quantity DECIMAL(22,10),
    price DECIMAL(22,10),
    item_price SMALLINT,
    create_datetime TIMESTAMP NOT NULL,
    deleted SMALLINT default 0 NOT NULL,
    description VARCHAR(1000),
    provisioning_status MEDIUMINT,
    provisioning_request_id VARCHAR(50),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (item_id) REFERENCES item (id)
    ,
    FOREIGN KEY (order_id) REFERENCES purchase_order (id)
    ,
    FOREIGN KEY (type_id) REFERENCES order_line_type (id)
    ,
    INDEX ix_order_line_order_id (order_id),
    INDEX ix_order_line_item_id (item_id));

# -----------------------------------------------------------------------
# order_line_type
# -----------------------------------------------------------------------
drop table if exists order_line_type;

CREATE TABLE order_line_type
(
    id MEDIUMINT NOT NULL,
    editable SMALLINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# order_period
# -----------------------------------------------------------------------
drop table if exists order_period;

CREATE TABLE order_period
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT,
    value MEDIUMINT,
    unit_id MEDIUMINT,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    ,
    FOREIGN KEY (unit_id) REFERENCES period_unit (id)
    );

# -----------------------------------------------------------------------
# order_process
# -----------------------------------------------------------------------
drop table if exists order_process;

CREATE TABLE order_process
(
    id MEDIUMINT NOT NULL,
    order_id MEDIUMINT,
    invoice_id MEDIUMINT,
    billing_process_id MEDIUMINT,
    periods_included MEDIUMINT,
    period_start DATETIME,
    period_end DATETIME,
    is_review MEDIUMINT NOT NULL,
    origin MEDIUMINT,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (order_id) REFERENCES purchase_order (id)
    ,
    INDEX ix_uq_order_process_or_in (order_id, invoice_id),
    INDEX ix_uq_order_process_or_bp (order_id, billing_process_id),
    INDEX ix_order_process_in (invoice_id));

# -----------------------------------------------------------------------
# paper_invoice_batch
# -----------------------------------------------------------------------
drop table if exists paper_invoice_batch;

CREATE TABLE paper_invoice_batch
(
    id MEDIUMINT NOT NULL,
    total_invoices MEDIUMINT NOT NULL,
    delivery_date DATETIME,
    is_self_managed SMALLINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# partner
# -----------------------------------------------------------------------
drop table if exists partner;

CREATE TABLE partner
(
    id MEDIUMINT NOT NULL,
    user_id MEDIUMINT,
    balance DECIMAL(22,10) NOT NULL,
    total_payments DECIMAL(22,10) NOT NULL,
    total_refunds DECIMAL(22,10) NOT NULL,
    total_payouts DECIMAL(22,10) NOT NULL,
    percentage_rate DECIMAL(22,10),
    referral_fee DECIMAL(22,10),
    fee_currency_id MEDIUMINT,
    one_time SMALLINT NOT NULL,
    period_unit_id MEDIUMINT NOT NULL,
    period_value MEDIUMINT NOT NULL,
    next_payout_date DATETIME NOT NULL,
    due_payout DECIMAL(22,10),
    automatic_process SMALLINT NOT NULL,
    related_clerk MEDIUMINT,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (period_unit_id) REFERENCES period_unit (id)
    ,
    FOREIGN KEY (fee_currency_id) REFERENCES currency (id)
    ,
    FOREIGN KEY (related_clerk) REFERENCES base_user (id)
    ,
    FOREIGN KEY (user_id) REFERENCES base_user (id)
    ,
    INDEX partner_i_3 (user_id));

# -----------------------------------------------------------------------
# partner_payout
# -----------------------------------------------------------------------
drop table if exists partner_payout;

CREATE TABLE partner_payout
(
    id MEDIUMINT NOT NULL,
    starting_date DATETIME NOT NULL,
    ending_date DATETIME NOT NULL,
    payments_amount DECIMAL(22,10) NOT NULL,
    refunds_amount DECIMAL(22,10) NOT NULL,
    balance_left DECIMAL(22,10) NOT NULL,
    payment_id MEDIUMINT,
    partner_id MEDIUMINT,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (partner_id) REFERENCES partner (id)
    ,
    INDEX partner_payout_i_2 (partner_id));

# -----------------------------------------------------------------------
# partner_range
# -----------------------------------------------------------------------
drop table if exists partner_range;

CREATE TABLE partner_range
(
    id MEDIUMINT NOT NULL,
    partner_id MEDIUMINT,
    percentage_rate DECIMAL(22,10),
    referral_fee DECIMAL(22,10),
    range_from MEDIUMINT NOT NULL,
    range_to MEDIUMINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    INDEX partner_range_p (partner_id));

# -----------------------------------------------------------------------
# payment
# -----------------------------------------------------------------------
drop table if exists payment;

CREATE TABLE payment
(
    id MEDIUMINT NOT NULL,
    user_id MEDIUMINT,
    attempt MEDIUMINT,
    result_id MEDIUMINT,
    amount DECIMAL(22,10) NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    update_datetime TIMESTAMP,
    payment_date DATETIME,
    method_id MEDIUMINT NOT NULL,
    credit_card_id MEDIUMINT,
    deleted SMALLINT default 0 NOT NULL,
    is_refund SMALLINT default 0 NOT NULL,
    is_preauth SMALLINT default 0 NOT NULL,
    payment_id MEDIUMINT,
    currency_id MEDIUMINT NOT NULL,
    payout_id MEDIUMINT,
    ach_id MEDIUMINT,
    balance DECIMAL(22,10),
    payment_period MEDIUMINT,
    payment_notes VARCHAR(500),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (ach_id) REFERENCES ach (id)
    ,
    FOREIGN KEY (currency_id) REFERENCES currency (id)
    ,
    FOREIGN KEY (payment_id) REFERENCES payment (id)
    ,
    FOREIGN KEY (credit_card_id) REFERENCES credit_card (id)
    ,
    FOREIGN KEY (result_id) REFERENCES payment_result (id)
    ,
    FOREIGN KEY (method_id) REFERENCES payment_method (id)
    ,
    INDEX payment_i_2 (user_id, create_datetime),
    INDEX payment_i_3 (user_id, balance));

# -----------------------------------------------------------------------
# payment_authorization
# -----------------------------------------------------------------------
drop table if exists payment_authorization;

CREATE TABLE payment_authorization
(
    id MEDIUMINT NOT NULL,
    payment_id MEDIUMINT,
    processor VARCHAR(40) NOT NULL,
    code1 VARCHAR(40) NOT NULL,
    code2 VARCHAR(40),
    code3 VARCHAR(40),
    approval_code VARCHAR(20),
    avs VARCHAR(20),
    transaction_id VARCHAR(20),
    md5 VARCHAR(100),
    card_code VARCHAR(100),
    create_datetime DATETIME NOT NULL,
    response_message VARCHAR(200),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (payment_id) REFERENCES payment (id)
    ,
    INDEX create_datetime (create_datetime),
    INDEX transaction_id (transaction_id),
    INDEX ix_pa_payment (payment_id));

# -----------------------------------------------------------------------
# payment_info_cheque
# -----------------------------------------------------------------------
drop table if exists payment_info_cheque;

CREATE TABLE payment_info_cheque
(
    id MEDIUMINT NOT NULL,
    payment_id MEDIUMINT,
    bank VARCHAR(50),
    cheque_number VARCHAR(50),
    cheque_date DATETIME,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (payment_id) REFERENCES payment (id)
    );

# -----------------------------------------------------------------------
# payment_invoice
# -----------------------------------------------------------------------
drop table if exists payment_invoice;

CREATE TABLE payment_invoice
(
    id MEDIUMINT NOT NULL,
    payment_id MEDIUMINT,
    invoice_id MEDIUMINT,
    amount DECIMAL(22,10),
    create_datetime TIMESTAMP NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (invoice_id) REFERENCES invoice (id)
    ,
    FOREIGN KEY (payment_id) REFERENCES payment (id)
    ,
    INDEX ix_uq_payment_inv_map_pa_in (payment_id, invoice_id));

# -----------------------------------------------------------------------
# payment_method
# -----------------------------------------------------------------------
drop table if exists payment_method;

CREATE TABLE payment_method
(
    id MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# payment_result
# -----------------------------------------------------------------------
drop table if exists payment_result;

CREATE TABLE payment_result
(
    id MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# period_unit
# -----------------------------------------------------------------------
drop table if exists period_unit;

CREATE TABLE period_unit
(
    id MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# permission
# -----------------------------------------------------------------------
drop table if exists permission;

CREATE TABLE permission
(
    id MEDIUMINT NOT NULL,
    type_id MEDIUMINT NOT NULL,
    foreign_id MEDIUMINT,
    PRIMARY KEY(id),
    FOREIGN KEY (type_id) REFERENCES permission_type (id)
    );

# -----------------------------------------------------------------------
# permission_role_map
# -----------------------------------------------------------------------
drop table if exists permission_role_map;

CREATE TABLE permission_role_map
(
    permission_id MEDIUMINT,
    role_id MEDIUMINT,
    FOREIGN KEY (role_id) REFERENCES role (id)
    ,
    FOREIGN KEY (permission_id) REFERENCES permission (id)
    ,
    INDEX permission_role_map_i_2 (permission_id, role_id));

# -----------------------------------------------------------------------
# permission_type
# -----------------------------------------------------------------------
drop table if exists permission_type;

CREATE TABLE permission_type
(
    id MEDIUMINT NOT NULL,
    description VARCHAR(30) NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# permission_user
# -----------------------------------------------------------------------
drop table if exists permission_user;

CREATE TABLE permission_user
(
    permission_id MEDIUMINT,
    user_id MEDIUMINT,
    is_grant SMALLINT NOT NULL,
    id MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (user_id) REFERENCES base_user (id)
    ,
    FOREIGN KEY (permission_id) REFERENCES permission (id)
    ,
    INDEX permission_user_map_i_2 (permission_id, user_id));

# -----------------------------------------------------------------------
# pluggable_task
# -----------------------------------------------------------------------
drop table if exists pluggable_task;

CREATE TABLE pluggable_task
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT NOT NULL,
    type_id MEDIUMINT,
    processing_order MEDIUMINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (type_id) REFERENCES pluggable_task_type (id)
    ,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    );

# -----------------------------------------------------------------------
# pluggable_task_parameter
# -----------------------------------------------------------------------
drop table if exists pluggable_task_parameter;

CREATE TABLE pluggable_task_parameter
(
    id MEDIUMINT NOT NULL,
    task_id MEDIUMINT,
    name VARCHAR(50) NOT NULL,
    int_value MEDIUMINT,
    str_value VARCHAR(500),
    float_value DECIMAL(22,10),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (task_id) REFERENCES pluggable_task (id)
    );

# -----------------------------------------------------------------------
# pluggable_task_type
# -----------------------------------------------------------------------
drop table if exists pluggable_task_type;

CREATE TABLE pluggable_task_type
(
    id MEDIUMINT NOT NULL,
    category_id MEDIUMINT NOT NULL,
    class_name VARCHAR(200) NOT NULL,
    min_parameters MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (category_id) REFERENCES pluggable_task_type_category (id)
    );

# -----------------------------------------------------------------------
# pluggable_task_type_category
# -----------------------------------------------------------------------
drop table if exists pluggable_task_type_category;

CREATE TABLE pluggable_task_type_category
(
    id MEDIUMINT NOT NULL,
    description VARCHAR(50) NOT NULL,
    interface_name VARCHAR(200) NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# preference
# -----------------------------------------------------------------------
drop table if exists preference;

CREATE TABLE preference
(
    id MEDIUMINT NOT NULL,
    type_id MEDIUMINT,
    table_id MEDIUMINT NOT NULL,
    foreign_id MEDIUMINT NOT NULL,
    int_value MEDIUMINT,
    str_value VARCHAR(200),
    float_value DECIMAL(22,10),
    PRIMARY KEY(id),
    FOREIGN KEY (type_id) REFERENCES preference_type (id)
    ,
    FOREIGN KEY (table_id) REFERENCES jbilling_table (id)
    );

# -----------------------------------------------------------------------
# preference_type
# -----------------------------------------------------------------------
drop table if exists preference_type;

CREATE TABLE preference_type
(
    id MEDIUMINT NOT NULL,
    int_def_value MEDIUMINT,
    str_def_value VARCHAR(200),
    float_def_value DECIMAL(22,10),
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# promotion
# -----------------------------------------------------------------------
drop table if exists promotion;

CREATE TABLE promotion
(
    id MEDIUMINT NOT NULL,
    item_id MEDIUMINT,
    code VARCHAR(50) NOT NULL,
    notes VARCHAR(200),
    once SMALLINT NOT NULL,
    since DATETIME,
    until DATETIME,
    PRIMARY KEY(id),
    FOREIGN KEY (item_id) REFERENCES item (id)
    ,
    INDEX ix_promotion_code (code));

# -----------------------------------------------------------------------
# purchase_order
# -----------------------------------------------------------------------
drop table if exists purchase_order;

CREATE TABLE purchase_order
(
    id MEDIUMINT NOT NULL,
    user_id MEDIUMINT,
    period_id MEDIUMINT,
    billing_type_id MEDIUMINT NOT NULL,
    active_since DATETIME,
    active_until DATETIME,
    cycle_start DATETIME,
    create_datetime TIMESTAMP NOT NULL,
    next_billable_day DATETIME,
    created_by MEDIUMINT,
    status_id MEDIUMINT NOT NULL,
    currency_id MEDIUMINT NOT NULL,
    deleted SMALLINT default 0 NOT NULL,
    notify SMALLINT,
    last_notified TIMESTAMP,
    notification_step MEDIUMINT,
    due_date_unit_id MEDIUMINT,
    due_date_value MEDIUMINT,
    df_fm SMALLINT,
    anticipate_periods MEDIUMINT,
    own_invoice SMALLINT,
    notes VARCHAR(200),
    notes_in_invoice SMALLINT,
    is_current SMALLINT,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (currency_id) REFERENCES currency (id)
    ,
    FOREIGN KEY (billing_type_id) REFERENCES order_billing_type (id)
    ,
    FOREIGN KEY (period_id) REFERENCES order_period (id)
    ,
    FOREIGN KEY (user_id) REFERENCES base_user (id)
    ,
    FOREIGN KEY (created_by) REFERENCES base_user (id)
    ,
    FOREIGN KEY (status_id) REFERENCES generic_status (id)
    ,
    INDEX purchase_order_i_user (user_id, deleted),
    INDEX purchase_order_i_notif (active_until, notification_step),
    INDEX ix_purchase_order_date (user_id, create_datetime));

# -----------------------------------------------------------------------
# report
# -----------------------------------------------------------------------
drop table if exists report;

CREATE TABLE report
(
    id MEDIUMINT NOT NULL,
    titlekey VARCHAR(50),
    instructionskey VARCHAR(50),
    tables_list VARCHAR(1000) NOT NULL,
    where_str VARCHAR(1000) NOT NULL,
    id_column SMALLINT NOT NULL,
    link VARCHAR(200),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# report_entity_map
# -----------------------------------------------------------------------
drop table if exists report_entity_map;

CREATE TABLE report_entity_map
(
    entity_id MEDIUMINT,
    report_id MEDIUMINT,
    FOREIGN KEY (report_id) REFERENCES report (id)
    ,
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    ,
    INDEX report_entity_map_i_2 (entity_id, report_id));

# -----------------------------------------------------------------------
# report_field
# -----------------------------------------------------------------------
drop table if exists report_field;

CREATE TABLE report_field
(
    id MEDIUMINT NOT NULL,
    report_id MEDIUMINT,
    report_user_id MEDIUMINT,
    position_number MEDIUMINT NOT NULL,
    table_name VARCHAR(50) NOT NULL,
    column_name VARCHAR(50) NOT NULL,
    order_position MEDIUMINT,
    where_value VARCHAR(50),
    title_key VARCHAR(50),
    function_name VARCHAR(10),
    is_grouped MEDIUMINT NOT NULL,
    is_shown SMALLINT NOT NULL,
    data_type VARCHAR(10) NOT NULL,
    operator_value VARCHAR(2),
    functionable SMALLINT NOT NULL,
    selectable SMALLINT NOT NULL,
    ordenable SMALLINT NOT NULL,
    operatorable SMALLINT NOT NULL,
    whereable SMALLINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (report_id) REFERENCES report (id)
    );

# -----------------------------------------------------------------------
# report_type
# -----------------------------------------------------------------------
drop table if exists report_type;

CREATE TABLE report_type
(
    id MEDIUMINT NOT NULL,
    showable SMALLINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# report_type_map
# -----------------------------------------------------------------------
drop table if exists report_type_map;

CREATE TABLE report_type_map
(
    report_id MEDIUMINT,
    type_id MEDIUMINT,
    FOREIGN KEY (type_id) REFERENCES report_type (id)
    ,
    FOREIGN KEY (report_id) REFERENCES report (id)
    );

# -----------------------------------------------------------------------
# report_user
# -----------------------------------------------------------------------
drop table if exists report_user;

CREATE TABLE report_user
(
    id MEDIUMINT NOT NULL,
    user_id MEDIUMINT,
    report_id MEDIUMINT,
    create_datetime TIMESTAMP NOT NULL,
    title VARCHAR(50),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (user_id) REFERENCES base_user (id)
    ,
    FOREIGN KEY (report_id) REFERENCES report (id)
    );

# -----------------------------------------------------------------------
# role
# -----------------------------------------------------------------------
drop table if exists role;

CREATE TABLE role
(
    id MEDIUMINT NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# user_credit_card_map
# -----------------------------------------------------------------------
drop table if exists user_credit_card_map;

CREATE TABLE user_credit_card_map
(
    user_id MEDIUMINT,
    credit_card_id MEDIUMINT,
    INDEX user_credit_card_map_i_2 (user_id, credit_card_id));

# -----------------------------------------------------------------------
# user_role_map
# -----------------------------------------------------------------------
drop table if exists user_role_map;

CREATE TABLE user_role_map
(
    user_id MEDIUMINT,
    role_id MEDIUMINT,
    FOREIGN KEY (role_id) REFERENCES role (id)
    ,
    FOREIGN KEY (user_id) REFERENCES base_user (id)
    ,
    INDEX user_role_map_i_2 (user_id, role_id),
    INDEX user_role_map_i_role (role_id));

# -----------------------------------------------------------------------
# mediation_cfg
# -----------------------------------------------------------------------
drop table if exists mediation_cfg;

CREATE TABLE mediation_cfg
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    name VARCHAR(50) NOT NULL,
    order_value MEDIUMINT NOT NULL,
    pluggable_task_id MEDIUMINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (pluggable_task_id) REFERENCES pluggable_task (id)
    );

# -----------------------------------------------------------------------
# mediation_process
# -----------------------------------------------------------------------
drop table if exists mediation_process;

CREATE TABLE mediation_process
(
    id MEDIUMINT NOT NULL,
    configuration_id MEDIUMINT NOT NULL,
    start_datetime TIMESTAMP NOT NULL,
    end_datetime TIMESTAMP default 'NULL',
    orders_affected MEDIUMINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (configuration_id) REFERENCES mediation_cfg (id)
    );

# -----------------------------------------------------------------------
# mediation_order_map
# -----------------------------------------------------------------------
drop table if exists mediation_order_map;

CREATE TABLE mediation_order_map
(
    mediation_process_id MEDIUMINT NOT NULL,
    order_id MEDIUMINT NOT NULL,
    FOREIGN KEY (mediation_process_id) REFERENCES mediation_process (id)
    ,
    FOREIGN KEY (order_id) REFERENCES purchase_order (id)
    );

# -----------------------------------------------------------------------
# mediation_record
# -----------------------------------------------------------------------
drop table if exists mediation_record;

CREATE TABLE mediation_record
(
    id_key VARCHAR(100) NOT NULL,
    start_datetime TIMESTAMP NOT NULL,
    mediation_process_id MEDIUMINT,
    status_id MEDIUMINT NOT NULL,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id_key),
    FOREIGN KEY (mediation_process_id) REFERENCES mediation_process (id)
    ,
    FOREIGN KEY (status_id) REFERENCES generic_status (id)
    ,
    INDEX mediation_record_i (id_key, status_id));

# -----------------------------------------------------------------------
# mediation_record_line
# -----------------------------------------------------------------------
drop table if exists mediation_record_line;

CREATE TABLE mediation_record_line
(
    id MEDIUMINT NOT NULL,
    mediation_record_id VARCHAR(100) NOT NULL,
    order_line_id MEDIUMINT NOT NULL,
    event_date TIMESTAMP NOT NULL,
    amount DECIMAL(22,10) NOT NULL,
    quantity DECIMAL(22,10) NOT NULL,
    description VARCHAR(200),
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (mediation_record_id) REFERENCES mediation_record (id_key)
    ,
    FOREIGN KEY (order_line_id) REFERENCES order_line (id)
    ,
    INDEX ix_mrl_order_line (order_line_id));

# -----------------------------------------------------------------------
# blacklist
# -----------------------------------------------------------------------
drop table if exists blacklist;

CREATE TABLE blacklist
(
    id MEDIUMINT NOT NULL,
    entity_id MEDIUMINT NOT NULL,
    create_datetime TIMESTAMP NOT NULL,
    type MEDIUMINT NOT NULL,
    source MEDIUMINT NOT NULL,
    credit_card MEDIUMINT,
    credit_card_id MEDIUMINT,
    contact_id MEDIUMINT,
    user_id MEDIUMINT,
    OPTLOCK MEDIUMINT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (entity_id) REFERENCES entity (id)
    ,
    FOREIGN KEY (user_id) REFERENCES base_user (id)
    ,
    INDEX ix_blacklist_user_type (user_id, type),
    INDEX ix_blacklist_entity_type (entity_id, type));

# -----------------------------------------------------------------------
# generic_status_type
# -----------------------------------------------------------------------
drop table if exists generic_status_type;

CREATE TABLE generic_status_type
(
    id VARCHAR(40) NOT NULL,
    PRIMARY KEY(id));

# -----------------------------------------------------------------------
# generic_status
# -----------------------------------------------------------------------
drop table if exists generic_status;

CREATE TABLE generic_status
(
    id MEDIUMINT NOT NULL,
    dtype VARCHAR(40) NOT NULL,
    status_value MEDIUMINT NOT NULL,
    can_login SMALLINT,
    PRIMARY KEY(id),
    FOREIGN KEY (dtype) REFERENCES generic_status_type (id)
    );






























































































