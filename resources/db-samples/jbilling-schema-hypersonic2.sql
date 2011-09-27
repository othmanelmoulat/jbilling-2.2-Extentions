
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
        ADD CONSTRAINT billing_process_configuration_FK_1 FOREIGN KEY (period_unit_id)
            REFERENCES period_unit (id)
;
    ALTER TABLE billing_process_configuration
        ADD CONSTRAINT billing_process_configuration_FK_2 FOREIGN KEY (entity_id)
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
        ADD CONSTRAINT entity_delivery_method_map_FK_1 FOREIGN KEY (entity_id)
            REFERENCES entity (id)
;
    ALTER TABLE entity_delivery_method_map
        ADD CONSTRAINT entity_delivery_method_map_FK_2 FOREIGN KEY (method_id)
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
        ADD CONSTRAINT notification_message_section_FK_1 FOREIGN KEY (message_id)
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


