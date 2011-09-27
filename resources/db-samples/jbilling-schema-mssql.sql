
/* ---------------------------------------------------------------------- */
/* ach                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='ach_FK_1')
    ALTER TABLE ach DROP CONSTRAINT ach_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'ach')
BEGIN
     DECLARE @reftable_1 nvarchar(60), @constraintname_1 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'ach'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_1, @constraintname_1
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_1+' drop constraint '+@constraintname_1)
       FETCH NEXT from refcursor into @reftable_1, @constraintname_1
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE ach
END
;

CREATE TABLE ach
(
            id INT NOT NULL,
            user_id INT NULL,
            aba_routing VARCHAR (40) NOT NULL,
            bank_account VARCHAR (60) NOT NULL,
            account_type INT NOT NULL,
            bank_name VARCHAR (50) NOT NULL,
            account_name VARCHAR (100) NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT ach_PK PRIMARY KEY(id));

CREATE  INDEX ach_i_2 ON ach (user_id);




/* ---------------------------------------------------------------------- */
/* ageing_entity_step                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='ageing_entity_step_FK_1')
    ALTER TABLE ageing_entity_step DROP CONSTRAINT ageing_entity_step_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='ageing_entity_step_FK_2')
    ALTER TABLE ageing_entity_step DROP CONSTRAINT ageing_entity_step_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'ageing_entity_step')
BEGIN
     DECLARE @reftable_2 nvarchar(60), @constraintname_2 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'ageing_entity_step'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_2, @constraintname_2
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_2+' drop constraint '+@constraintname_2)
       FETCH NEXT from refcursor into @reftable_2, @constraintname_2
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE ageing_entity_step
END
;

CREATE TABLE ageing_entity_step
(
            id INT NOT NULL,
            entity_id INT NULL,
            status_id INT NULL,
            days INT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT ageing_entity_step_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* base_user                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='base_user_FK_1')
    ALTER TABLE base_user DROP CONSTRAINT base_user_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='base_user_FK_2')
    ALTER TABLE base_user DROP CONSTRAINT base_user_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='base_user_FK_3')
    ALTER TABLE base_user DROP CONSTRAINT base_user_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='base_user_FK_4')
    ALTER TABLE base_user DROP CONSTRAINT base_user_FK_4;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='base_user_FK_5')
    ALTER TABLE base_user DROP CONSTRAINT base_user_FK_5;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'base_user')
BEGIN
     DECLARE @reftable_3 nvarchar(60), @constraintname_3 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'base_user'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_3, @constraintname_3
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_3+' drop constraint '+@constraintname_3)
       FETCH NEXT from refcursor into @reftable_3, @constraintname_3
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE base_user
END
;

CREATE TABLE base_user
(
            id INT NOT NULL,
            entity_id INT NULL,
            password VARCHAR (40) NULL,
            deleted SMALLINT default 0 NOT NULL,
            language_id INT NULL,
            status_id INT NULL,
            subscriber_status INT default 1 NULL,
            currency_id INT NULL,
            create_datetime DATETIME NOT NULL,
            last_status_change DATETIME NULL,
            last_login DATETIME NULL,
            user_name VARCHAR (50) NULL,
            failed_attempts INT default 0 NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT base_user_PK PRIMARY KEY(id));

CREATE  INDEX ix_base_user_un ON base_user (entity_id, user_name);




/* ---------------------------------------------------------------------- */
/* billing_process                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='billing_process_FK_1')
    ALTER TABLE billing_process DROP CONSTRAINT billing_process_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='billing_process_FK_2')
    ALTER TABLE billing_process DROP CONSTRAINT billing_process_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='billing_process_FK_3')
    ALTER TABLE billing_process DROP CONSTRAINT billing_process_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'billing_process')
BEGIN
     DECLARE @reftable_4 nvarchar(60), @constraintname_4 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'billing_process'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_4, @constraintname_4
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_4+' drop constraint '+@constraintname_4)
       FETCH NEXT from refcursor into @reftable_4, @constraintname_4
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE billing_process
END
;

CREATE TABLE billing_process
(
            id INT NOT NULL,
            entity_id INT NOT NULL,
            billing_date DATETIME NOT NULL,
            period_unit_id INT NOT NULL,
            period_value INT NOT NULL,
            is_review INT NOT NULL,
            paper_invoice_batch_id INT NULL,
            retries_to_do INT default 0 NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT billing_process_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* billing_process_configuration                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='billing_process_configura_FK_1')
    ALTER TABLE billing_process_configuration DROP CONSTRAINT billing_process_configura_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='billing_process_configura_FK_2')
    ALTER TABLE billing_process_configuration DROP CONSTRAINT billing_process_configura_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'billing_process_configuration')
BEGIN
     DECLARE @reftable_5 nvarchar(60), @constraintname_5 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'billing_process_configuration'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_5, @constraintname_5
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_5+' drop constraint '+@constraintname_5)
       FETCH NEXT from refcursor into @reftable_5, @constraintname_5
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE billing_process_configuration
END
;

CREATE TABLE billing_process_configuration
(
            id INT NOT NULL,
            entity_id INT NULL,
            next_run_date DATETIME NOT NULL,
            generate_report SMALLINT NOT NULL,
            retries INT NULL,
            days_for_retry INT NULL,
            days_for_report INT NULL,
            review_status INT NOT NULL,
            period_unit_id INT NOT NULL,
            period_value INT NOT NULL,
            due_date_unit_id INT NOT NULL,
            due_date_value INT NOT NULL,
            df_fm SMALLINT NULL,
            only_recurring SMALLINT default 1 NOT NULL,
            invoice_date_process SMALLINT NOT NULL,
            OPTLOCK INT NOT NULL,
            auto_payment SMALLINT default 0 NOT NULL,
            maximum_periods INT default 1 NOT NULL,
            auto_payment_application INT default 0 NOT NULL,

    CONSTRAINT billing_process_configuration_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* process_run                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='process_run_FK_1')
    ALTER TABLE process_run DROP CONSTRAINT process_run_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='process_run_FK_2')
    ALTER TABLE process_run DROP CONSTRAINT process_run_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'process_run')
BEGIN
     DECLARE @reftable_6 nvarchar(60), @constraintname_6 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'process_run'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_6, @constraintname_6
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_6+' drop constraint '+@constraintname_6)
       FETCH NEXT from refcursor into @reftable_6, @constraintname_6
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE process_run
END
;

CREATE TABLE process_run
(
            id INT NOT NULL,
            process_id INT NULL,
            run_date DATETIME NOT NULL,
            started DATETIME NOT NULL,
            finished DATETIME NULL,
            payment_finished DATETIME NULL,
            invoices_generated INT NULL,
            OPTLOCK INT NOT NULL,
            status_id INT NOT NULL,

    CONSTRAINT process_run_PK PRIMARY KEY(id));

CREATE  INDEX bp_run_process_ix ON process_run (process_id);




/* ---------------------------------------------------------------------- */
/* process_run_total                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='process_run_total_FK_1')
    ALTER TABLE process_run_total DROP CONSTRAINT process_run_total_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='process_run_total_FK_2')
    ALTER TABLE process_run_total DROP CONSTRAINT process_run_total_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'process_run_total')
BEGIN
     DECLARE @reftable_7 nvarchar(60), @constraintname_7 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'process_run_total'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_7, @constraintname_7
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_7+' drop constraint '+@constraintname_7)
       FETCH NEXT from refcursor into @reftable_7, @constraintname_7
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE process_run_total
END
;

CREATE TABLE process_run_total
(
            id INT NOT NULL,
            process_run_id INT NULL,
            currency_id INT NOT NULL,
            total_invoiced NUMERIC (22,10) NULL,
            total_paid NUMERIC (22,10) NULL,
            total_not_paid NUMERIC (22,10) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT process_run_total_PK PRIMARY KEY(id));

CREATE  INDEX bp_run_total_run_ix ON process_run_total (process_run_id);




/* ---------------------------------------------------------------------- */
/* process_run_total_pm                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='process_run_total_pm_FK_1')
    ALTER TABLE process_run_total_pm DROP CONSTRAINT process_run_total_pm_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'process_run_total_pm')
BEGIN
     DECLARE @reftable_8 nvarchar(60), @constraintname_8 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'process_run_total_pm'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_8, @constraintname_8
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_8+' drop constraint '+@constraintname_8)
       FETCH NEXT from refcursor into @reftable_8, @constraintname_8
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE process_run_total_pm
END
;

CREATE TABLE process_run_total_pm
(
            id INT NOT NULL,
            process_run_total_id INT NULL,
            payment_method_id INT NULL,
            total NUMERIC (22,10) NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT process_run_total_pm_PK PRIMARY KEY(id));

CREATE  INDEX bp_pm_index_total ON process_run_total_pm (process_run_total_id);




/* ---------------------------------------------------------------------- */
/* process_run_user                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='process_run_user_FK_1')
    ALTER TABLE process_run_user DROP CONSTRAINT process_run_user_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='process_run_user_FK_2')
    ALTER TABLE process_run_user DROP CONSTRAINT process_run_user_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'process_run_user')
BEGIN
     DECLARE @reftable_9 nvarchar(60), @constraintname_9 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'process_run_user'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_9, @constraintname_9
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_9+' drop constraint '+@constraintname_9)
       FETCH NEXT from refcursor into @reftable_9, @constraintname_9
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE process_run_user
END
;

CREATE TABLE process_run_user
(
            id INT NOT NULL,
            process_run_id INT NOT NULL,
            user_id INT NOT NULL,
            status INT NOT NULL,
            created DATETIME NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT process_run_user_PK PRIMARY KEY(id));

CREATE  INDEX bp_run_user_run_ix ON process_run_user (process_run_id);
CREATE  INDEX bp_run_user_user_ix ON process_run_user (user_id);




/* ---------------------------------------------------------------------- */
/* contact                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'contact')
BEGIN
     DECLARE @reftable_10 nvarchar(60), @constraintname_10 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'contact'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_10, @constraintname_10
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_10+' drop constraint '+@constraintname_10)
       FETCH NEXT from refcursor into @reftable_10, @constraintname_10
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE contact
END
;

CREATE TABLE contact
(
            id INT NOT NULL,
            organization_name VARCHAR (200) NULL,
            street_addres1 VARCHAR (100) NULL,
            street_addres2 VARCHAR (100) NULL,
            city VARCHAR (50) NULL,
            state_province VARCHAR (30) NULL,
            postal_code VARCHAR (15) NULL,
            country_code VARCHAR (2) NULL,
            last_name VARCHAR (30) NULL,
            first_name VARCHAR (30) NULL,
            person_initial VARCHAR (5) NULL,
            person_title VARCHAR (40) NULL,
            phone_country_code INT NULL,
            phone_area_code INT NULL,
            phone_phone_number VARCHAR (20) NULL,
            fax_country_code INT NULL,
            fax_area_code INT NULL,
            fax_phone_number VARCHAR (20) NULL,
            email VARCHAR (200) NULL,
            create_datetime DATETIME NOT NULL,
            deleted SMALLINT default 0 NOT NULL,
            notification_include SMALLINT default 1 NULL,
            user_id INT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT contact_PK PRIMARY KEY(id));

CREATE  INDEX ix_contact_fname ON contact (first_name);
CREATE  INDEX ix_contact_lname ON contact (last_name);
CREATE  INDEX ix_contact_orgname ON contact (organization_name);
CREATE  INDEX contact_i_del ON contact (deleted);
CREATE  INDEX ix_contact_fname_lname ON contact (first_name, last_name);
CREATE  INDEX ix_contact_address ON contact (street_addres1, city, postal_code, street_addres2, state_province, country_code);
CREATE  INDEX ix_contact_phone ON contact (phone_phone_number, phone_area_code, phone_country_code);




/* ---------------------------------------------------------------------- */
/* contact_field                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='contact_field_FK_1')
    ALTER TABLE contact_field DROP CONSTRAINT contact_field_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='contact_field_FK_2')
    ALTER TABLE contact_field DROP CONSTRAINT contact_field_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'contact_field')
BEGIN
     DECLARE @reftable_11 nvarchar(60), @constraintname_11 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'contact_field'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_11, @constraintname_11
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_11+' drop constraint '+@constraintname_11)
       FETCH NEXT from refcursor into @reftable_11, @constraintname_11
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE contact_field
END
;

CREATE TABLE contact_field
(
            id INT NOT NULL,
            type_id INT NULL,
            contact_id INT NULL,
            content VARCHAR (100) NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT contact_field_PK PRIMARY KEY(id));

CREATE  INDEX ix_contact_field_cid ON contact_field (contact_id);
CREATE  INDEX ix_contact_field_content ON contact_field (content);




/* ---------------------------------------------------------------------- */
/* contact_field_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='contact_field_type_FK_1')
    ALTER TABLE contact_field_type DROP CONSTRAINT contact_field_type_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'contact_field_type')
BEGIN
     DECLARE @reftable_12 nvarchar(60), @constraintname_12 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'contact_field_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_12, @constraintname_12
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_12+' drop constraint '+@constraintname_12)
       FETCH NEXT from refcursor into @reftable_12, @constraintname_12
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE contact_field_type
END
;

CREATE TABLE contact_field_type
(
            id INT NOT NULL,
            entity_id INT NULL,
            prompt_key VARCHAR (50) NOT NULL,
            data_type VARCHAR (10) NOT NULL,
            customer_readonly SMALLINT NULL,

    CONSTRAINT contact_field_type_PK PRIMARY KEY(id));

CREATE  INDEX ix_cf_type_entity ON contact_field_type (entity_id);




/* ---------------------------------------------------------------------- */
/* contact_map                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='contact_map_FK_1')
    ALTER TABLE contact_map DROP CONSTRAINT contact_map_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='contact_map_FK_2')
    ALTER TABLE contact_map DROP CONSTRAINT contact_map_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='contact_map_FK_3')
    ALTER TABLE contact_map DROP CONSTRAINT contact_map_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'contact_map')
BEGIN
     DECLARE @reftable_13 nvarchar(60), @constraintname_13 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'contact_map'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_13, @constraintname_13
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_13+' drop constraint '+@constraintname_13)
       FETCH NEXT from refcursor into @reftable_13, @constraintname_13
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE contact_map
END
;

CREATE TABLE contact_map
(
            id INT NOT NULL,
            contact_id INT NULL,
            type_id INT NOT NULL,
            table_id INT NOT NULL,
            foreign_id INT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT contact_map_PK PRIMARY KEY(id));

CREATE  INDEX contact_map_i_3 ON contact_map (contact_id);
CREATE  INDEX contact_map_i_1 ON contact_map (table_id, foreign_id, type_id);




/* ---------------------------------------------------------------------- */
/* contact_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='contact_type_FK_1')
    ALTER TABLE contact_type DROP CONSTRAINT contact_type_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'contact_type')
BEGIN
     DECLARE @reftable_14 nvarchar(60), @constraintname_14 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'contact_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_14, @constraintname_14
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_14+' drop constraint '+@constraintname_14)
       FETCH NEXT from refcursor into @reftable_14, @constraintname_14
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE contact_type
END
;

CREATE TABLE contact_type
(
            id INT NOT NULL,
            entity_id INT NULL,
            is_primary SMALLINT NULL,

    CONSTRAINT contact_type_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* country                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'country')
BEGIN
     DECLARE @reftable_15 nvarchar(60), @constraintname_15 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'country'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_15, @constraintname_15
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_15+' drop constraint '+@constraintname_15)
       FETCH NEXT from refcursor into @reftable_15, @constraintname_15
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE country
END
;

CREATE TABLE country
(
            id INT NOT NULL,
            code VARCHAR (2) NOT NULL,

    CONSTRAINT country_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* credit_card                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'credit_card')
BEGIN
     DECLARE @reftable_16 nvarchar(60), @constraintname_16 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'credit_card'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_16, @constraintname_16
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_16+' drop constraint '+@constraintname_16)
       FETCH NEXT from refcursor into @reftable_16, @constraintname_16
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE credit_card
END
;

CREATE TABLE credit_card
(
            id INT NOT NULL,
            cc_number VARCHAR (100) NOT NULL,
            cc_number_plain VARCHAR (20) NULL,
            cc_expiry DATETIME NOT NULL,
            name VARCHAR (150) NULL,
            cc_type INT NOT NULL,
            deleted SMALLINT default 0 NOT NULL,
            gateway_key VARCHAR (100) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT credit_card_PK PRIMARY KEY(id));

CREATE  INDEX ix_cc_number ON credit_card (cc_number_plain);
CREATE  INDEX ix_cc_number_encrypted ON credit_card (cc_number);




/* ---------------------------------------------------------------------- */
/* currency                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'currency')
BEGIN
     DECLARE @reftable_17 nvarchar(60), @constraintname_17 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'currency'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_17, @constraintname_17
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_17+' drop constraint '+@constraintname_17)
       FETCH NEXT from refcursor into @reftable_17, @constraintname_17
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE currency
END
;

CREATE TABLE currency
(
            id INT NOT NULL,
            symbol VARCHAR (10) NOT NULL,
            code VARCHAR (3) NOT NULL,
            country_code VARCHAR (2) NOT NULL,

    CONSTRAINT currency_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* currency_entity_map                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='currency_entity_map_FK_1')
    ALTER TABLE currency_entity_map DROP CONSTRAINT currency_entity_map_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='currency_entity_map_FK_2')
    ALTER TABLE currency_entity_map DROP CONSTRAINT currency_entity_map_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'currency_entity_map')
BEGIN
     DECLARE @reftable_18 nvarchar(60), @constraintname_18 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'currency_entity_map'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_18, @constraintname_18
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_18+' drop constraint '+@constraintname_18)
       FETCH NEXT from refcursor into @reftable_18, @constraintname_18
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE currency_entity_map
END
;

CREATE TABLE currency_entity_map
(
            currency_id INT NULL,
            entity_id INT NULL,
);

CREATE  INDEX currency_entity_map_i_2 ON currency_entity_map (currency_id, entity_id);




/* ---------------------------------------------------------------------- */
/* currency_exchange                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='currency_exchange_FK_1')
    ALTER TABLE currency_exchange DROP CONSTRAINT currency_exchange_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'currency_exchange')
BEGIN
     DECLARE @reftable_19 nvarchar(60), @constraintname_19 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'currency_exchange'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_19, @constraintname_19
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_19+' drop constraint '+@constraintname_19)
       FETCH NEXT from refcursor into @reftable_19, @constraintname_19
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE currency_exchange
END
;

CREATE TABLE currency_exchange
(
            id INT NOT NULL,
            entity_id INT NULL,
            currency_id INT NULL,
            rate NUMERIC (22,10) NOT NULL,
            create_datetime DATETIME NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT currency_exchange_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* customer                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='customer_FK_1')
    ALTER TABLE customer DROP CONSTRAINT customer_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='customer_FK_2')
    ALTER TABLE customer DROP CONSTRAINT customer_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='customer_FK_3')
    ALTER TABLE customer DROP CONSTRAINT customer_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'customer')
BEGIN
     DECLARE @reftable_20 nvarchar(60), @constraintname_20 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'customer'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_20, @constraintname_20
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_20+' drop constraint '+@constraintname_20)
       FETCH NEXT from refcursor into @reftable_20, @constraintname_20
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE customer
END
;

CREATE TABLE customer
(
            id INT NOT NULL,
            user_id INT NULL,
            partner_id INT NULL,
            referral_fee_paid SMALLINT NULL,
            invoice_delivery_method_id INT NOT NULL,
            notes VARCHAR (1000) NULL,
            auto_payment_type INT NULL,
            due_date_unit_id INT NULL,
            due_date_value INT NULL,
            df_fm SMALLINT NULL,
            parent_id INT NULL,
            is_parent SMALLINT NULL,
            exclude_aging SMALLINT default 0 NOT NULL,
            invoice_child SMALLINT NULL,
            current_order_id INT NULL,
            balance_type INT default 1 NOT NULL,
            dynamic_balance NUMERIC (22,10) NULL,
            credit_limit NUMERIC (22,10) NULL,
            auto_recharge NUMERIC (22,10) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT customer_PK PRIMARY KEY(id));

CREATE  INDEX customer_i_2 ON customer (user_id);




/* ---------------------------------------------------------------------- */
/* entity                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='entity_FK_1')
    ALTER TABLE entity DROP CONSTRAINT entity_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='entity_FK_2')
    ALTER TABLE entity DROP CONSTRAINT entity_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'entity')
BEGIN
     DECLARE @reftable_21 nvarchar(60), @constraintname_21 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'entity'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_21, @constraintname_21
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_21+' drop constraint '+@constraintname_21)
       FETCH NEXT from refcursor into @reftable_21, @constraintname_21
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE entity
END
;

CREATE TABLE entity
(
            id INT NOT NULL,
            external_id VARCHAR (20) NULL,
            description VARCHAR (100) NOT NULL,
            create_datetime DATETIME NOT NULL,
            language_id INT NOT NULL,
            currency_id INT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT entity_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* entity_delivery_method_map                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='entity_delivery_method_ma_FK_1')
    ALTER TABLE entity_delivery_method_map DROP CONSTRAINT entity_delivery_method_ma_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='entity_delivery_method_ma_FK_2')
    ALTER TABLE entity_delivery_method_map DROP CONSTRAINT entity_delivery_method_ma_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'entity_delivery_method_map')
BEGIN
     DECLARE @reftable_22 nvarchar(60), @constraintname_22 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'entity_delivery_method_map'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_22, @constraintname_22
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_22+' drop constraint '+@constraintname_22)
       FETCH NEXT from refcursor into @reftable_22, @constraintname_22
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE entity_delivery_method_map
END
;

CREATE TABLE entity_delivery_method_map
(
            method_id INT NULL,
            entity_id INT NULL,
);





/* ---------------------------------------------------------------------- */
/* entity_payment_method_map                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='entity_payment_method_map_FK_1')
    ALTER TABLE entity_payment_method_map DROP CONSTRAINT entity_payment_method_map_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='entity_payment_method_map_FK_2')
    ALTER TABLE entity_payment_method_map DROP CONSTRAINT entity_payment_method_map_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'entity_payment_method_map')
BEGIN
     DECLARE @reftable_23 nvarchar(60), @constraintname_23 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'entity_payment_method_map'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_23, @constraintname_23
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_23+' drop constraint '+@constraintname_23)
       FETCH NEXT from refcursor into @reftable_23, @constraintname_23
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE entity_payment_method_map
END
;

CREATE TABLE entity_payment_method_map
(
            entity_id INT NULL,
            payment_method_id INT NULL,
);





/* ---------------------------------------------------------------------- */
/* event_log                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='event_log_FK_1')
    ALTER TABLE event_log DROP CONSTRAINT event_log_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='event_log_FK_2')
    ALTER TABLE event_log DROP CONSTRAINT event_log_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='event_log_FK_3')
    ALTER TABLE event_log DROP CONSTRAINT event_log_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='event_log_FK_4')
    ALTER TABLE event_log DROP CONSTRAINT event_log_FK_4;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='event_log_FK_5')
    ALTER TABLE event_log DROP CONSTRAINT event_log_FK_5;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='event_log_FK_6')
    ALTER TABLE event_log DROP CONSTRAINT event_log_FK_6;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'event_log')
BEGIN
     DECLARE @reftable_24 nvarchar(60), @constraintname_24 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'event_log'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_24, @constraintname_24
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_24+' drop constraint '+@constraintname_24)
       FETCH NEXT from refcursor into @reftable_24, @constraintname_24
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE event_log
END
;

CREATE TABLE event_log
(
            id INT NOT NULL,
            entity_id INT NULL,
            user_id INT NULL,
            affected_user_id INT NULL,
            table_id INT NULL,
            foreign_id INT NOT NULL,
            create_datetime DATETIME NOT NULL,
            level_field INT NOT NULL,
            module_id INT NOT NULL,
            message_id INT NOT NULL,
            old_num INT NULL,
            old_str VARCHAR (1000) NULL,
            old_date DATETIME NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT event_log_PK PRIMARY KEY(id));

CREATE  INDEX ix_el_main ON event_log (module_id, message_id, create_datetime);




/* ---------------------------------------------------------------------- */
/* event_log_message                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'event_log_message')
BEGIN
     DECLARE @reftable_25 nvarchar(60), @constraintname_25 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'event_log_message'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_25, @constraintname_25
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_25+' drop constraint '+@constraintname_25)
       FETCH NEXT from refcursor into @reftable_25, @constraintname_25
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE event_log_message
END
;

CREATE TABLE event_log_message
(
            id INT NOT NULL,

    CONSTRAINT event_log_message_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* event_log_module                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'event_log_module')
BEGIN
     DECLARE @reftable_26 nvarchar(60), @constraintname_26 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'event_log_module'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_26, @constraintname_26
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_26+' drop constraint '+@constraintname_26)
       FETCH NEXT from refcursor into @reftable_26, @constraintname_26
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE event_log_module
END
;

CREATE TABLE event_log_module
(
            id INT NOT NULL,

    CONSTRAINT event_log_module_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* international_description                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='international_description_FK_1')
    ALTER TABLE international_description DROP CONSTRAINT international_description_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='international_description_FK_2')
    ALTER TABLE international_description DROP CONSTRAINT international_description_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'international_description')
BEGIN
     DECLARE @reftable_27 nvarchar(60), @constraintname_27 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'international_description'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_27, @constraintname_27
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_27+' drop constraint '+@constraintname_27)
       FETCH NEXT from refcursor into @reftable_27, @constraintname_27
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE international_description
END
;

CREATE TABLE international_description
(
            table_id INT NOT NULL,
            foreign_id INT NOT NULL,
            psudo_column VARCHAR (20) NOT NULL,
            language_id INT NOT NULL,
            content VARCHAR (4000) NOT NULL,

    CONSTRAINT international_description_PK PRIMARY KEY(table_id,foreign_id,psudo_column,language_id));

CREATE  INDEX international_description_i_2 ON international_description (table_id, foreign_id, language_id);
CREATE  INDEX int_description_i_lan ON international_description (language_id);




/* ---------------------------------------------------------------------- */
/* invoice                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='invoice_FK_1')
    ALTER TABLE invoice DROP CONSTRAINT invoice_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='invoice_FK_2')
    ALTER TABLE invoice DROP CONSTRAINT invoice_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='invoice_FK_3')
    ALTER TABLE invoice DROP CONSTRAINT invoice_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='invoice_FK_4')
    ALTER TABLE invoice DROP CONSTRAINT invoice_FK_4;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='invoice_FK_5')
    ALTER TABLE invoice DROP CONSTRAINT invoice_FK_5;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'invoice')
BEGIN
     DECLARE @reftable_28 nvarchar(60), @constraintname_28 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'invoice'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_28, @constraintname_28
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_28+' drop constraint '+@constraintname_28)
       FETCH NEXT from refcursor into @reftable_28, @constraintname_28
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE invoice
END
;

CREATE TABLE invoice
(
            id INT NOT NULL,
            create_datetime DATETIME NOT NULL,
            billing_process_id INT NULL,
            user_id INT NULL,
            status_id INT NOT NULL,
            delegated_invoice_id INT NULL,
            due_date DATETIME NOT NULL,
            total NUMERIC (22,10) NOT NULL,
            payment_attempts INT default 0 NOT NULL,
            balance NUMERIC (22,10) NULL,
            carried_balance NUMERIC (22,10) NOT NULL,
            in_process_payment SMALLINT default 1 NOT NULL,
            is_review INT NOT NULL,
            currency_id INT NOT NULL,
            deleted SMALLINT default 0 NOT NULL,
            paper_invoice_batch_id INT NULL,
            customer_notes VARCHAR (1000) NULL,
            public_number VARCHAR (40) NULL,
            last_reminder DATETIME NULL,
            overdue_step INT NULL,
            create_timestamp DATETIME NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT invoice_PK PRIMARY KEY(id));

CREATE  INDEX ix_invoice_user_id ON invoice (user_id, deleted);
CREATE  INDEX ix_invoice_date ON invoice (create_datetime);
CREATE  INDEX ix_invoice_number ON invoice (user_id, public_number);
CREATE  INDEX ix_invoice_due_date ON invoice (user_id, due_date);
CREATE  INDEX ix_invoice_ts ON invoice (create_timestamp, user_id);
CREATE  INDEX ix_invoice_process ON invoice (billing_process_id);




/* ---------------------------------------------------------------------- */
/* invoice_delivery_method                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'invoice_delivery_method')
BEGIN
     DECLARE @reftable_29 nvarchar(60), @constraintname_29 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'invoice_delivery_method'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_29, @constraintname_29
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_29+' drop constraint '+@constraintname_29)
       FETCH NEXT from refcursor into @reftable_29, @constraintname_29
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE invoice_delivery_method
END
;

CREATE TABLE invoice_delivery_method
(
            id INT NOT NULL,

    CONSTRAINT invoice_delivery_method_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* invoice_line                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='invoice_line_FK_1')
    ALTER TABLE invoice_line DROP CONSTRAINT invoice_line_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='invoice_line_FK_2')
    ALTER TABLE invoice_line DROP CONSTRAINT invoice_line_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='invoice_line_FK_3')
    ALTER TABLE invoice_line DROP CONSTRAINT invoice_line_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'invoice_line')
BEGIN
     DECLARE @reftable_30 nvarchar(60), @constraintname_30 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'invoice_line'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_30, @constraintname_30
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_30+' drop constraint '+@constraintname_30)
       FETCH NEXT from refcursor into @reftable_30, @constraintname_30
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE invoice_line
END
;

CREATE TABLE invoice_line
(
            id INT NOT NULL,
            invoice_id INT NULL,
            type_id INT NULL,
            amount NUMERIC (22,10) NOT NULL,
            quantity NUMERIC (22,10) NULL,
            price NUMERIC (22,10) NULL,
            deleted SMALLINT default 0 NOT NULL,
            item_id INT NULL,
            description VARCHAR (1000) NULL,
            source_user_id INT NULL,
            is_percentage SMALLINT default 0 NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT invoice_line_PK PRIMARY KEY(id));

CREATE  INDEX ix_invoice_line_invoice_id ON invoice_line (invoice_id);




/* ---------------------------------------------------------------------- */
/* invoice_line_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'invoice_line_type')
BEGIN
     DECLARE @reftable_31 nvarchar(60), @constraintname_31 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'invoice_line_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_31, @constraintname_31
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_31+' drop constraint '+@constraintname_31)
       FETCH NEXT from refcursor into @reftable_31, @constraintname_31
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE invoice_line_type
END
;

CREATE TABLE invoice_line_type
(
            id INT NOT NULL,
            description VARCHAR (50) NOT NULL,
            order_position INT NOT NULL,

    CONSTRAINT invoice_line_type_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* item                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='item_FK_1')
    ALTER TABLE item DROP CONSTRAINT item_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'item')
BEGIN
     DECLARE @reftable_32 nvarchar(60), @constraintname_32 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'item'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_32, @constraintname_32
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_32+' drop constraint '+@constraintname_32)
       FETCH NEXT from refcursor into @reftable_32, @constraintname_32
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE item
END
;

CREATE TABLE item
(
            id INT NOT NULL,
            internal_number VARCHAR (50) NULL,
            entity_id INT NULL,
            percentage NUMERIC (22,10) NULL,
            price_manual SMALLINT NOT NULL,
            deleted SMALLINT default 0 NOT NULL,
            has_decimals SMALLINT default 0 NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT item_PK PRIMARY KEY(id));

CREATE  INDEX ix_item_ent ON item (entity_id, internal_number);




/* ---------------------------------------------------------------------- */
/* item_price                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='item_price_FK_1')
    ALTER TABLE item_price DROP CONSTRAINT item_price_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='item_price_FK_2')
    ALTER TABLE item_price DROP CONSTRAINT item_price_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'item_price')
BEGIN
     DECLARE @reftable_33 nvarchar(60), @constraintname_33 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'item_price'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_33, @constraintname_33
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_33+' drop constraint '+@constraintname_33)
       FETCH NEXT from refcursor into @reftable_33, @constraintname_33
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE item_price
END
;

CREATE TABLE item_price
(
            id INT NOT NULL,
            item_id INT NULL,
            currency_id INT NULL,
            price NUMERIC (22,10) NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT item_price_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* item_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='item_type_FK_1')
    ALTER TABLE item_type DROP CONSTRAINT item_type_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'item_type')
BEGIN
     DECLARE @reftable_34 nvarchar(60), @constraintname_34 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'item_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_34, @constraintname_34
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_34+' drop constraint '+@constraintname_34)
       FETCH NEXT from refcursor into @reftable_34, @constraintname_34
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE item_type
END
;

CREATE TABLE item_type
(
            id INT NOT NULL,
            entity_id INT NOT NULL,
            description VARCHAR (100) NULL,
            order_line_type_id INT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT item_type_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* item_type_map                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='item_type_map_FK_1')
    ALTER TABLE item_type_map DROP CONSTRAINT item_type_map_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='item_type_map_FK_2')
    ALTER TABLE item_type_map DROP CONSTRAINT item_type_map_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'item_type_map')
BEGIN
     DECLARE @reftable_35 nvarchar(60), @constraintname_35 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'item_type_map'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_35, @constraintname_35
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_35+' drop constraint '+@constraintname_35)
       FETCH NEXT from refcursor into @reftable_35, @constraintname_35
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE item_type_map
END
;

CREATE TABLE item_type_map
(
            item_id INT NULL,
            type_id INT NULL,
);





/* ---------------------------------------------------------------------- */
/* jbilling_table                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'jbilling_table')
BEGIN
     DECLARE @reftable_36 nvarchar(60), @constraintname_36 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'jbilling_table'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_36, @constraintname_36
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_36+' drop constraint '+@constraintname_36)
       FETCH NEXT from refcursor into @reftable_36, @constraintname_36
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE jbilling_table
END
;

CREATE TABLE jbilling_table
(
            id INT NOT NULL,
            name VARCHAR (50) NOT NULL,

    CONSTRAINT jbilling_table_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* jbilling_seqs                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'jbilling_seqs')
BEGIN
     DECLARE @reftable_37 nvarchar(60), @constraintname_37 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'jbilling_seqs'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_37, @constraintname_37
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_37+' drop constraint '+@constraintname_37)
       FETCH NEXT from refcursor into @reftable_37, @constraintname_37
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE jbilling_seqs
END
;

CREATE TABLE jbilling_seqs
(
            name VARCHAR (50) NOT NULL,
            next_id INT default 0 NOT NULL,
);





/* ---------------------------------------------------------------------- */
/* language                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'language')
BEGIN
     DECLARE @reftable_38 nvarchar(60), @constraintname_38 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'language'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_38, @constraintname_38
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_38+' drop constraint '+@constraintname_38)
       FETCH NEXT from refcursor into @reftable_38, @constraintname_38
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE language
END
;

CREATE TABLE language
(
            id INT NOT NULL,
            code VARCHAR (2) NOT NULL,
            description VARCHAR (50) NOT NULL,

    CONSTRAINT language_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* list                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'list')
BEGIN
     DECLARE @reftable_39 nvarchar(60), @constraintname_39 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'list'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_39, @constraintname_39
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_39+' drop constraint '+@constraintname_39)
       FETCH NEXT from refcursor into @reftable_39, @constraintname_39
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE list
END
;

CREATE TABLE list
(
            id INT NOT NULL,
            legacy_name VARCHAR (30) NULL,
            title_key VARCHAR (100) NOT NULL,
            instr_key VARCHAR (100) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT list_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* list_entity                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='list_entity_FK_1')
    ALTER TABLE list_entity DROP CONSTRAINT list_entity_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='list_entity_FK_2')
    ALTER TABLE list_entity DROP CONSTRAINT list_entity_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'list_entity')
BEGIN
     DECLARE @reftable_40 nvarchar(60), @constraintname_40 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'list_entity'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_40, @constraintname_40
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_40+' drop constraint '+@constraintname_40)
       FETCH NEXT from refcursor into @reftable_40, @constraintname_40
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE list_entity
END
;

CREATE TABLE list_entity
(
            id INT NOT NULL,
            list_id INT NULL,
            entity_id INT NOT NULL,
            total_records INT NOT NULL,
            last_update DATETIME NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT list_entity_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* list_field                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='list_field_FK_1')
    ALTER TABLE list_field DROP CONSTRAINT list_field_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'list_field')
BEGIN
     DECLARE @reftable_41 nvarchar(60), @constraintname_41 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'list_field'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_41, @constraintname_41
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_41+' drop constraint '+@constraintname_41)
       FETCH NEXT from refcursor into @reftable_41, @constraintname_41
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE list_field
END
;

CREATE TABLE list_field
(
            id INT NOT NULL,
            list_id INT NULL,
            title_key VARCHAR (100) NOT NULL,
            column_name VARCHAR (50) NOT NULL,
            ordenable SMALLINT NOT NULL,
            searchable SMALLINT NOT NULL,
            data_type VARCHAR (10) NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT list_field_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* list_field_entity                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='list_field_entity_FK_1')
    ALTER TABLE list_field_entity DROP CONSTRAINT list_field_entity_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='list_field_entity_FK_2')
    ALTER TABLE list_field_entity DROP CONSTRAINT list_field_entity_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'list_field_entity')
BEGIN
     DECLARE @reftable_42 nvarchar(60), @constraintname_42 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'list_field_entity'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_42, @constraintname_42
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_42+' drop constraint '+@constraintname_42)
       FETCH NEXT from refcursor into @reftable_42, @constraintname_42
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE list_field_entity
END
;

CREATE TABLE list_field_entity
(
            id INT NOT NULL,
            list_field_id INT NULL,
            list_entity_id INT NULL,
            min_value INT NULL,
            max_value INT NULL,
            min_str_value VARCHAR (100) NULL,
            max_str_value VARCHAR (100) NULL,
            min_date_value DATETIME NULL,
            max_date_value DATETIME NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT list_field_entity_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* menu_option                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='menu_option_FK_1')
    ALTER TABLE menu_option DROP CONSTRAINT menu_option_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'menu_option')
BEGIN
     DECLARE @reftable_43 nvarchar(60), @constraintname_43 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'menu_option'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_43, @constraintname_43
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_43+' drop constraint '+@constraintname_43)
       FETCH NEXT from refcursor into @reftable_43, @constraintname_43
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE menu_option
END
;

CREATE TABLE menu_option
(
            id INT NOT NULL,
            link VARCHAR (100) NOT NULL,
            level_field INT NOT NULL,
            parent_id INT NULL,

    CONSTRAINT menu_option_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* notification_message                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='notification_message_FK_1')
    ALTER TABLE notification_message DROP CONSTRAINT notification_message_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='notification_message_FK_2')
    ALTER TABLE notification_message DROP CONSTRAINT notification_message_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='notification_message_FK_3')
    ALTER TABLE notification_message DROP CONSTRAINT notification_message_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'notification_message')
BEGIN
     DECLARE @reftable_44 nvarchar(60), @constraintname_44 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'notification_message'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_44, @constraintname_44
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_44+' drop constraint '+@constraintname_44)
       FETCH NEXT from refcursor into @reftable_44, @constraintname_44
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE notification_message
END
;

CREATE TABLE notification_message
(
            id INT NOT NULL,
            type_id INT NULL,
            entity_id INT NOT NULL,
            language_id INT NOT NULL,
            use_flag SMALLINT default 1 NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT notification_message_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* notification_message_arch                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'notification_message_arch')
BEGIN
     DECLARE @reftable_45 nvarchar(60), @constraintname_45 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'notification_message_arch'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_45, @constraintname_45
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_45+' drop constraint '+@constraintname_45)
       FETCH NEXT from refcursor into @reftable_45, @constraintname_45
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE notification_message_arch
END
;

CREATE TABLE notification_message_arch
(
            id INT NOT NULL,
            type_id INT NULL,
            create_datetime DATETIME NOT NULL,
            user_id INT NULL,
            result_message VARCHAR (200) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT notification_message_arch_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* notification_message_arch_line                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='notif_mess_arch_line_FK_1')
    ALTER TABLE notification_message_arch_line DROP CONSTRAINT notif_mess_arch_line_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'notification_message_arch_line')
BEGIN
     DECLARE @reftable_46 nvarchar(60), @constraintname_46 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'notification_message_arch_line'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_46, @constraintname_46
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_46+' drop constraint '+@constraintname_46)
       FETCH NEXT from refcursor into @reftable_46, @constraintname_46
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE notification_message_arch_line
END
;

CREATE TABLE notification_message_arch_line
(
            id INT NOT NULL,
            message_archive_id INT NULL,
            section INT NOT NULL,
            content VARCHAR (1000) NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT notification_message_arch_line_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* notification_message_line                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='notification_message_line_FK_1')
    ALTER TABLE notification_message_line DROP CONSTRAINT notification_message_line_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'notification_message_line')
BEGIN
     DECLARE @reftable_47 nvarchar(60), @constraintname_47 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'notification_message_line'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_47, @constraintname_47
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_47+' drop constraint '+@constraintname_47)
       FETCH NEXT from refcursor into @reftable_47, @constraintname_47
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE notification_message_line
END
;

CREATE TABLE notification_message_line
(
            id INT NOT NULL,
            message_section_id INT NULL,
            content VARCHAR (1000) NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT notification_message_line_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* notification_message_section                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='notification_message_sect_FK_1')
    ALTER TABLE notification_message_section DROP CONSTRAINT notification_message_sect_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'notification_message_section')
BEGIN
     DECLARE @reftable_48 nvarchar(60), @constraintname_48 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'notification_message_section'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_48, @constraintname_48
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_48+' drop constraint '+@constraintname_48)
       FETCH NEXT from refcursor into @reftable_48, @constraintname_48
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE notification_message_section
END
;

CREATE TABLE notification_message_section
(
            id INT NOT NULL,
            message_id INT NULL,
            section INT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT notification_message_section_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* notification_message_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'notification_message_type')
BEGIN
     DECLARE @reftable_49 nvarchar(60), @constraintname_49 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'notification_message_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_49, @constraintname_49
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_49+' drop constraint '+@constraintname_49)
       FETCH NEXT from refcursor into @reftable_49, @constraintname_49
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE notification_message_type
END
;

CREATE TABLE notification_message_type
(
            id INT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT notification_message_type_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* order_billing_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'order_billing_type')
BEGIN
     DECLARE @reftable_50 nvarchar(60), @constraintname_50 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'order_billing_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_50, @constraintname_50
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_50+' drop constraint '+@constraintname_50)
       FETCH NEXT from refcursor into @reftable_50, @constraintname_50
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE order_billing_type
END
;

CREATE TABLE order_billing_type
(
            id INT NOT NULL,

    CONSTRAINT order_billing_type_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* order_line                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='order_line_FK_1')
    ALTER TABLE order_line DROP CONSTRAINT order_line_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='order_line_FK_2')
    ALTER TABLE order_line DROP CONSTRAINT order_line_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='order_line_FK_3')
    ALTER TABLE order_line DROP CONSTRAINT order_line_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'order_line')
BEGIN
     DECLARE @reftable_51 nvarchar(60), @constraintname_51 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'order_line'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_51, @constraintname_51
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_51+' drop constraint '+@constraintname_51)
       FETCH NEXT from refcursor into @reftable_51, @constraintname_51
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE order_line
END
;

CREATE TABLE order_line
(
            id INT NOT NULL,
            order_id INT NULL,
            item_id INT NULL,
            type_id INT NULL,
            amount NUMERIC (22,10) NOT NULL,
            quantity NUMERIC (22,10) NULL,
            price NUMERIC (22,10) NULL,
            item_price SMALLINT NULL,
            create_datetime DATETIME NOT NULL,
            deleted SMALLINT default 0 NOT NULL,
            description VARCHAR (1000) NULL,
            provisioning_status INT NULL,
            provisioning_request_id VARCHAR (50) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT order_line_PK PRIMARY KEY(id));

CREATE  INDEX ix_order_line_order_id ON order_line (order_id);
CREATE  INDEX ix_order_line_item_id ON order_line (item_id);




/* ---------------------------------------------------------------------- */
/* order_line_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'order_line_type')
BEGIN
     DECLARE @reftable_52 nvarchar(60), @constraintname_52 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'order_line_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_52, @constraintname_52
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_52+' drop constraint '+@constraintname_52)
       FETCH NEXT from refcursor into @reftable_52, @constraintname_52
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE order_line_type
END
;

CREATE TABLE order_line_type
(
            id INT NOT NULL,
            editable SMALLINT NOT NULL,

    CONSTRAINT order_line_type_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* order_period                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='order_period_FK_1')
    ALTER TABLE order_period DROP CONSTRAINT order_period_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='order_period_FK_2')
    ALTER TABLE order_period DROP CONSTRAINT order_period_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'order_period')
BEGIN
     DECLARE @reftable_53 nvarchar(60), @constraintname_53 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'order_period'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_53, @constraintname_53
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_53+' drop constraint '+@constraintname_53)
       FETCH NEXT from refcursor into @reftable_53, @constraintname_53
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE order_period
END
;

CREATE TABLE order_period
(
            id INT NOT NULL,
            entity_id INT NULL,
            value INT NULL,
            unit_id INT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT order_period_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* order_process                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='order_process_FK_1')
    ALTER TABLE order_process DROP CONSTRAINT order_process_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'order_process')
BEGIN
     DECLARE @reftable_54 nvarchar(60), @constraintname_54 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'order_process'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_54, @constraintname_54
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_54+' drop constraint '+@constraintname_54)
       FETCH NEXT from refcursor into @reftable_54, @constraintname_54
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE order_process
END
;

CREATE TABLE order_process
(
            id INT NOT NULL,
            order_id INT NULL,
            invoice_id INT NULL,
            billing_process_id INT NULL,
            periods_included INT NULL,
            period_start DATETIME NULL,
            period_end DATETIME NULL,
            is_review INT NOT NULL,
            origin INT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT order_process_PK PRIMARY KEY(id));

CREATE  INDEX ix_uq_order_process_or_in ON order_process (order_id, invoice_id);
CREATE  INDEX ix_uq_order_process_or_bp ON order_process (order_id, billing_process_id);
CREATE  INDEX ix_order_process_in ON order_process (invoice_id);




/* ---------------------------------------------------------------------- */
/* paper_invoice_batch                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'paper_invoice_batch')
BEGIN
     DECLARE @reftable_55 nvarchar(60), @constraintname_55 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'paper_invoice_batch'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_55, @constraintname_55
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_55+' drop constraint '+@constraintname_55)
       FETCH NEXT from refcursor into @reftable_55, @constraintname_55
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE paper_invoice_batch
END
;

CREATE TABLE paper_invoice_batch
(
            id INT NOT NULL,
            total_invoices INT NOT NULL,
            delivery_date DATETIME NULL,
            is_self_managed SMALLINT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT paper_invoice_batch_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* partner                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='partner_FK_1')
    ALTER TABLE partner DROP CONSTRAINT partner_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='partner_FK_2')
    ALTER TABLE partner DROP CONSTRAINT partner_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='partner_FK_3')
    ALTER TABLE partner DROP CONSTRAINT partner_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='partner_FK_4')
    ALTER TABLE partner DROP CONSTRAINT partner_FK_4;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'partner')
BEGIN
     DECLARE @reftable_56 nvarchar(60), @constraintname_56 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'partner'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_56, @constraintname_56
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_56+' drop constraint '+@constraintname_56)
       FETCH NEXT from refcursor into @reftable_56, @constraintname_56
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE partner
END
;

CREATE TABLE partner
(
            id INT NOT NULL,
            user_id INT NULL,
            balance NUMERIC (22,10) NOT NULL,
            total_payments NUMERIC (22,10) NOT NULL,
            total_refunds NUMERIC (22,10) NOT NULL,
            total_payouts NUMERIC (22,10) NOT NULL,
            percentage_rate NUMERIC (22,10) NULL,
            referral_fee NUMERIC (22,10) NULL,
            fee_currency_id INT NULL,
            one_time SMALLINT NOT NULL,
            period_unit_id INT NOT NULL,
            period_value INT NOT NULL,
            next_payout_date DATETIME NOT NULL,
            due_payout NUMERIC (22,10) NULL,
            automatic_process SMALLINT NOT NULL,
            related_clerk INT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT partner_PK PRIMARY KEY(id));

CREATE  INDEX partner_i_3 ON partner (user_id);




/* ---------------------------------------------------------------------- */
/* partner_payout                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='partner_payout_FK_1')
    ALTER TABLE partner_payout DROP CONSTRAINT partner_payout_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'partner_payout')
BEGIN
     DECLARE @reftable_57 nvarchar(60), @constraintname_57 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'partner_payout'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_57, @constraintname_57
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_57+' drop constraint '+@constraintname_57)
       FETCH NEXT from refcursor into @reftable_57, @constraintname_57
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE partner_payout
END
;

CREATE TABLE partner_payout
(
            id INT NOT NULL,
            starting_date DATETIME NOT NULL,
            ending_date DATETIME NOT NULL,
            payments_amount NUMERIC (22,10) NOT NULL,
            refunds_amount NUMERIC (22,10) NOT NULL,
            balance_left NUMERIC (22,10) NOT NULL,
            payment_id INT NULL,
            partner_id INT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT partner_payout_PK PRIMARY KEY(id));

CREATE  INDEX partner_payout_i_2 ON partner_payout (partner_id);




/* ---------------------------------------------------------------------- */
/* partner_range                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'partner_range')
BEGIN
     DECLARE @reftable_58 nvarchar(60), @constraintname_58 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'partner_range'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_58, @constraintname_58
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_58+' drop constraint '+@constraintname_58)
       FETCH NEXT from refcursor into @reftable_58, @constraintname_58
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE partner_range
END
;

CREATE TABLE partner_range
(
            id INT NOT NULL,
            partner_id INT NULL,
            percentage_rate NUMERIC (22,10) NULL,
            referral_fee NUMERIC (22,10) NULL,
            range_from INT NOT NULL,
            range_to INT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT partner_range_PK PRIMARY KEY(id));

CREATE  INDEX partner_range_p ON partner_range (partner_id);




/* ---------------------------------------------------------------------- */
/* payment                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='payment_FK_1')
    ALTER TABLE payment DROP CONSTRAINT payment_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='payment_FK_2')
    ALTER TABLE payment DROP CONSTRAINT payment_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='payment_FK_3')
    ALTER TABLE payment DROP CONSTRAINT payment_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='payment_FK_4')
    ALTER TABLE payment DROP CONSTRAINT payment_FK_4;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='payment_FK_5')
    ALTER TABLE payment DROP CONSTRAINT payment_FK_5;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='payment_FK_6')
    ALTER TABLE payment DROP CONSTRAINT payment_FK_6;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'payment')
BEGIN
     DECLARE @reftable_59 nvarchar(60), @constraintname_59 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'payment'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_59, @constraintname_59
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_59+' drop constraint '+@constraintname_59)
       FETCH NEXT from refcursor into @reftable_59, @constraintname_59
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE payment
END
;

CREATE TABLE payment
(
            id INT NOT NULL,
            user_id INT NULL,
            attempt INT NULL,
            result_id INT NULL,
            amount NUMERIC (22,10) NOT NULL,
            create_datetime DATETIME NOT NULL,
            update_datetime DATETIME NULL,
            payment_date DATETIME NULL,
            method_id INT NOT NULL,
            credit_card_id INT NULL,
            deleted SMALLINT default 0 NOT NULL,
            is_refund SMALLINT default 0 NOT NULL,
            is_preauth SMALLINT default 0 NOT NULL,
            payment_id INT NULL,
            currency_id INT NOT NULL,
            payout_id INT NULL,
            ach_id INT NULL,
            balance NUMERIC (22,10) NULL,
            payment_period INT NULL,
            payment_notes VARCHAR (500) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT payment_PK PRIMARY KEY(id));

CREATE  INDEX payment_i_2 ON payment (user_id, create_datetime);
CREATE  INDEX payment_i_3 ON payment (user_id, balance);




/* ---------------------------------------------------------------------- */
/* payment_authorization                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='payment_authorization_FK_1')
    ALTER TABLE payment_authorization DROP CONSTRAINT payment_authorization_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'payment_authorization')
BEGIN
     DECLARE @reftable_60 nvarchar(60), @constraintname_60 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'payment_authorization'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_60, @constraintname_60
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_60+' drop constraint '+@constraintname_60)
       FETCH NEXT from refcursor into @reftable_60, @constraintname_60
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE payment_authorization
END
;

CREATE TABLE payment_authorization
(
            id INT NOT NULL,
            payment_id INT NULL,
            processor VARCHAR (40) NOT NULL,
            code1 VARCHAR (40) NOT NULL,
            code2 VARCHAR (40) NULL,
            code3 VARCHAR (40) NULL,
            approval_code VARCHAR (20) NULL,
            avs VARCHAR (20) NULL,
            transaction_id VARCHAR (20) NULL,
            md5 VARCHAR (100) NULL,
            card_code VARCHAR (100) NULL,
            create_datetime DATETIME NOT NULL,
            response_message VARCHAR (200) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT payment_authorization_PK PRIMARY KEY(id));

CREATE  INDEX create_datetime ON payment_authorization (create_datetime);
CREATE  INDEX transaction_id ON payment_authorization (transaction_id);
CREATE  INDEX ix_pa_payment ON payment_authorization (payment_id);




/* ---------------------------------------------------------------------- */
/* payment_info_cheque                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='payment_info_cheque_FK_1')
    ALTER TABLE payment_info_cheque DROP CONSTRAINT payment_info_cheque_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'payment_info_cheque')
BEGIN
     DECLARE @reftable_61 nvarchar(60), @constraintname_61 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'payment_info_cheque'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_61, @constraintname_61
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_61+' drop constraint '+@constraintname_61)
       FETCH NEXT from refcursor into @reftable_61, @constraintname_61
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE payment_info_cheque
END
;

CREATE TABLE payment_info_cheque
(
            id INT NOT NULL,
            payment_id INT NULL,
            bank VARCHAR (50) NULL,
            cheque_number VARCHAR (50) NULL,
            cheque_date DATETIME NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT payment_info_cheque_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* payment_invoice                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='payment_invoice_FK_1')
    ALTER TABLE payment_invoice DROP CONSTRAINT payment_invoice_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='payment_invoice_FK_2')
    ALTER TABLE payment_invoice DROP CONSTRAINT payment_invoice_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'payment_invoice')
BEGIN
     DECLARE @reftable_62 nvarchar(60), @constraintname_62 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'payment_invoice'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_62, @constraintname_62
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_62+' drop constraint '+@constraintname_62)
       FETCH NEXT from refcursor into @reftable_62, @constraintname_62
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE payment_invoice
END
;

CREATE TABLE payment_invoice
(
            id INT NOT NULL,
            payment_id INT NULL,
            invoice_id INT NULL,
            amount NUMERIC (22,10) NULL,
            create_datetime DATETIME NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT payment_invoice_PK PRIMARY KEY(id));

CREATE  INDEX ix_uq_payment_inv_map_pa_in ON payment_invoice (payment_id, invoice_id);




/* ---------------------------------------------------------------------- */
/* payment_method                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'payment_method')
BEGIN
     DECLARE @reftable_63 nvarchar(60), @constraintname_63 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'payment_method'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_63, @constraintname_63
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_63+' drop constraint '+@constraintname_63)
       FETCH NEXT from refcursor into @reftable_63, @constraintname_63
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE payment_method
END
;

CREATE TABLE payment_method
(
            id INT NOT NULL,

    CONSTRAINT payment_method_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* payment_result                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'payment_result')
BEGIN
     DECLARE @reftable_64 nvarchar(60), @constraintname_64 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'payment_result'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_64, @constraintname_64
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_64+' drop constraint '+@constraintname_64)
       FETCH NEXT from refcursor into @reftable_64, @constraintname_64
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE payment_result
END
;

CREATE TABLE payment_result
(
            id INT NOT NULL,

    CONSTRAINT payment_result_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* period_unit                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'period_unit')
BEGIN
     DECLARE @reftable_65 nvarchar(60), @constraintname_65 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'period_unit'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_65, @constraintname_65
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_65+' drop constraint '+@constraintname_65)
       FETCH NEXT from refcursor into @reftable_65, @constraintname_65
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE period_unit
END
;

CREATE TABLE period_unit
(
            id INT NOT NULL,

    CONSTRAINT period_unit_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* permission                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='permission_FK_1')
    ALTER TABLE permission DROP CONSTRAINT permission_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'permission')
BEGIN
     DECLARE @reftable_66 nvarchar(60), @constraintname_66 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'permission'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_66, @constraintname_66
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_66+' drop constraint '+@constraintname_66)
       FETCH NEXT from refcursor into @reftable_66, @constraintname_66
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE permission
END
;

CREATE TABLE permission
(
            id INT NOT NULL,
            type_id INT NOT NULL,
            foreign_id INT NULL,

    CONSTRAINT permission_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* permission_role_map                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='permission_role_map_FK_1')
    ALTER TABLE permission_role_map DROP CONSTRAINT permission_role_map_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='permission_role_map_FK_2')
    ALTER TABLE permission_role_map DROP CONSTRAINT permission_role_map_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'permission_role_map')
BEGIN
     DECLARE @reftable_67 nvarchar(60), @constraintname_67 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'permission_role_map'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_67, @constraintname_67
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_67+' drop constraint '+@constraintname_67)
       FETCH NEXT from refcursor into @reftable_67, @constraintname_67
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE permission_role_map
END
;

CREATE TABLE permission_role_map
(
            permission_id INT NULL,
            role_id INT NULL,
);

CREATE  INDEX permission_role_map_i_2 ON permission_role_map (permission_id, role_id);




/* ---------------------------------------------------------------------- */
/* permission_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'permission_type')
BEGIN
     DECLARE @reftable_68 nvarchar(60), @constraintname_68 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'permission_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_68, @constraintname_68
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_68+' drop constraint '+@constraintname_68)
       FETCH NEXT from refcursor into @reftable_68, @constraintname_68
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE permission_type
END
;

CREATE TABLE permission_type
(
            id INT NOT NULL,
            description VARCHAR (30) NOT NULL,

    CONSTRAINT permission_type_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* permission_user                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='permission_user_FK_1')
    ALTER TABLE permission_user DROP CONSTRAINT permission_user_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='permission_user_FK_2')
    ALTER TABLE permission_user DROP CONSTRAINT permission_user_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'permission_user')
BEGIN
     DECLARE @reftable_69 nvarchar(60), @constraintname_69 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'permission_user'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_69, @constraintname_69
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_69+' drop constraint '+@constraintname_69)
       FETCH NEXT from refcursor into @reftable_69, @constraintname_69
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE permission_user
END
;

CREATE TABLE permission_user
(
            permission_id INT NULL,
            user_id INT NULL,
            is_grant SMALLINT NOT NULL,
            id INT NOT NULL,

    CONSTRAINT permission_user_PK PRIMARY KEY(id));

CREATE  INDEX permission_user_map_i_2 ON permission_user (permission_id, user_id);




/* ---------------------------------------------------------------------- */
/* pluggable_task                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='pluggable_task_FK_1')
    ALTER TABLE pluggable_task DROP CONSTRAINT pluggable_task_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='pluggable_task_FK_2')
    ALTER TABLE pluggable_task DROP CONSTRAINT pluggable_task_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'pluggable_task')
BEGIN
     DECLARE @reftable_70 nvarchar(60), @constraintname_70 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'pluggable_task'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_70, @constraintname_70
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_70+' drop constraint '+@constraintname_70)
       FETCH NEXT from refcursor into @reftable_70, @constraintname_70
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE pluggable_task
END
;

CREATE TABLE pluggable_task
(
            id INT NOT NULL,
            entity_id INT NOT NULL,
            type_id INT NULL,
            processing_order INT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT pluggable_task_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* pluggable_task_parameter                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='pluggable_task_parameter_FK_1')
    ALTER TABLE pluggable_task_parameter DROP CONSTRAINT pluggable_task_parameter_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'pluggable_task_parameter')
BEGIN
     DECLARE @reftable_71 nvarchar(60), @constraintname_71 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'pluggable_task_parameter'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_71, @constraintname_71
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_71+' drop constraint '+@constraintname_71)
       FETCH NEXT from refcursor into @reftable_71, @constraintname_71
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE pluggable_task_parameter
END
;

CREATE TABLE pluggable_task_parameter
(
            id INT NOT NULL,
            task_id INT NULL,
            name VARCHAR (50) NOT NULL,
            int_value INT NULL,
            str_value VARCHAR (500) NULL,
            float_value NUMERIC (22,10) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT pluggable_task_parameter_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* pluggable_task_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='pluggable_task_type_FK_1')
    ALTER TABLE pluggable_task_type DROP CONSTRAINT pluggable_task_type_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'pluggable_task_type')
BEGIN
     DECLARE @reftable_72 nvarchar(60), @constraintname_72 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'pluggable_task_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_72, @constraintname_72
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_72+' drop constraint '+@constraintname_72)
       FETCH NEXT from refcursor into @reftable_72, @constraintname_72
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE pluggable_task_type
END
;

CREATE TABLE pluggable_task_type
(
            id INT NOT NULL,
            category_id INT NOT NULL,
            class_name VARCHAR (200) NOT NULL,
            min_parameters INT NOT NULL,

    CONSTRAINT pluggable_task_type_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* pluggable_task_type_category                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'pluggable_task_type_category')
BEGIN
     DECLARE @reftable_73 nvarchar(60), @constraintname_73 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'pluggable_task_type_category'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_73, @constraintname_73
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_73+' drop constraint '+@constraintname_73)
       FETCH NEXT from refcursor into @reftable_73, @constraintname_73
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE pluggable_task_type_category
END
;

CREATE TABLE pluggable_task_type_category
(
            id INT NOT NULL,
            description VARCHAR (50) NOT NULL,
            interface_name VARCHAR (200) NOT NULL,

    CONSTRAINT pluggable_task_type_category_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* preference                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='preference_FK_1')
    ALTER TABLE preference DROP CONSTRAINT preference_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='preference_FK_2')
    ALTER TABLE preference DROP CONSTRAINT preference_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'preference')
BEGIN
     DECLARE @reftable_74 nvarchar(60), @constraintname_74 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'preference'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_74, @constraintname_74
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_74+' drop constraint '+@constraintname_74)
       FETCH NEXT from refcursor into @reftable_74, @constraintname_74
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE preference
END
;

CREATE TABLE preference
(
            id INT NOT NULL,
            type_id INT NULL,
            table_id INT NOT NULL,
            foreign_id INT NOT NULL,
            int_value INT NULL,
            str_value VARCHAR (200) NULL,
            float_value NUMERIC (22,10) NULL,

    CONSTRAINT preference_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* preference_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'preference_type')
BEGIN
     DECLARE @reftable_75 nvarchar(60), @constraintname_75 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'preference_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_75, @constraintname_75
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_75+' drop constraint '+@constraintname_75)
       FETCH NEXT from refcursor into @reftable_75, @constraintname_75
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE preference_type
END
;

CREATE TABLE preference_type
(
            id INT NOT NULL,
            int_def_value INT NULL,
            str_def_value VARCHAR (200) NULL,
            float_def_value NUMERIC (22,10) NULL,

    CONSTRAINT preference_type_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* promotion                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='promotion_FK_1')
    ALTER TABLE promotion DROP CONSTRAINT promotion_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'promotion')
BEGIN
     DECLARE @reftable_76 nvarchar(60), @constraintname_76 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'promotion'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_76, @constraintname_76
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_76+' drop constraint '+@constraintname_76)
       FETCH NEXT from refcursor into @reftable_76, @constraintname_76
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE promotion
END
;

CREATE TABLE promotion
(
            id INT NOT NULL,
            item_id INT NULL,
            code VARCHAR (50) NOT NULL,
            notes VARCHAR (200) NULL,
            once SMALLINT NOT NULL,
            since DATETIME NULL,
            until DATETIME NULL,

    CONSTRAINT promotion_PK PRIMARY KEY(id));

CREATE  INDEX ix_promotion_code ON promotion (code);




/* ---------------------------------------------------------------------- */
/* purchase_order                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='purchase_order_FK_1')
    ALTER TABLE purchase_order DROP CONSTRAINT purchase_order_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='purchase_order_FK_2')
    ALTER TABLE purchase_order DROP CONSTRAINT purchase_order_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='purchase_order_FK_3')
    ALTER TABLE purchase_order DROP CONSTRAINT purchase_order_FK_3;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='purchase_order_FK_4')
    ALTER TABLE purchase_order DROP CONSTRAINT purchase_order_FK_4;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='purchase_order_FK_5')
    ALTER TABLE purchase_order DROP CONSTRAINT purchase_order_FK_5;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='purchase_order_FK_6')
    ALTER TABLE purchase_order DROP CONSTRAINT purchase_order_FK_6;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'purchase_order')
BEGIN
     DECLARE @reftable_77 nvarchar(60), @constraintname_77 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'purchase_order'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_77, @constraintname_77
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_77+' drop constraint '+@constraintname_77)
       FETCH NEXT from refcursor into @reftable_77, @constraintname_77
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE purchase_order
END
;

CREATE TABLE purchase_order
(
            id INT NOT NULL,
            user_id INT NULL,
            period_id INT NULL,
            billing_type_id INT NOT NULL,
            active_since DATETIME NULL,
            active_until DATETIME NULL,
            cycle_start DATETIME NULL,
            create_datetime DATETIME NOT NULL,
            next_billable_day DATETIME NULL,
            created_by INT NULL,
            status_id INT NOT NULL,
            currency_id INT NOT NULL,
            deleted SMALLINT default 0 NOT NULL,
            notify SMALLINT NULL,
            last_notified DATETIME NULL,
            notification_step INT NULL,
            due_date_unit_id INT NULL,
            due_date_value INT NULL,
            df_fm SMALLINT NULL,
            anticipate_periods INT NULL,
            own_invoice SMALLINT NULL,
            notes VARCHAR (200) NULL,
            notes_in_invoice SMALLINT NULL,
            is_current SMALLINT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT purchase_order_PK PRIMARY KEY(id));

CREATE  INDEX purchase_order_i_user ON purchase_order (user_id, deleted);
CREATE  INDEX purchase_order_i_notif ON purchase_order (active_until, notification_step);
CREATE  INDEX ix_purchase_order_date ON purchase_order (user_id, create_datetime);




/* ---------------------------------------------------------------------- */
/* report                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'report')
BEGIN
     DECLARE @reftable_78 nvarchar(60), @constraintname_78 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'report'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_78, @constraintname_78
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_78+' drop constraint '+@constraintname_78)
       FETCH NEXT from refcursor into @reftable_78, @constraintname_78
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE report
END
;

CREATE TABLE report
(
            id INT NOT NULL,
            titlekey VARCHAR (50) NULL,
            instructionskey VARCHAR (50) NULL,
            tables_list VARCHAR (1000) NOT NULL,
            where_str VARCHAR (1000) NOT NULL,
            id_column SMALLINT NOT NULL,
            link VARCHAR (200) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT report_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* report_entity_map                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='report_entity_map_FK_1')
    ALTER TABLE report_entity_map DROP CONSTRAINT report_entity_map_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='report_entity_map_FK_2')
    ALTER TABLE report_entity_map DROP CONSTRAINT report_entity_map_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'report_entity_map')
BEGIN
     DECLARE @reftable_79 nvarchar(60), @constraintname_79 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'report_entity_map'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_79, @constraintname_79
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_79+' drop constraint '+@constraintname_79)
       FETCH NEXT from refcursor into @reftable_79, @constraintname_79
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE report_entity_map
END
;

CREATE TABLE report_entity_map
(
            entity_id INT NULL,
            report_id INT NULL,
);

CREATE  INDEX report_entity_map_i_2 ON report_entity_map (entity_id, report_id);




/* ---------------------------------------------------------------------- */
/* report_field                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='report_field_FK_1')
    ALTER TABLE report_field DROP CONSTRAINT report_field_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'report_field')
BEGIN
     DECLARE @reftable_80 nvarchar(60), @constraintname_80 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'report_field'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_80, @constraintname_80
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_80+' drop constraint '+@constraintname_80)
       FETCH NEXT from refcursor into @reftable_80, @constraintname_80
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE report_field
END
;

CREATE TABLE report_field
(
            id INT NOT NULL,
            report_id INT NULL,
            report_user_id INT NULL,
            position_number INT NOT NULL,
            table_name VARCHAR (50) NOT NULL,
            column_name VARCHAR (50) NOT NULL,
            order_position INT NULL,
            where_value VARCHAR (50) NULL,
            title_key VARCHAR (50) NULL,
            function_name VARCHAR (10) NULL,
            is_grouped INT NOT NULL,
            is_shown SMALLINT NOT NULL,
            data_type VARCHAR (10) NOT NULL,
            operator_value VARCHAR (2) NULL,
            functionable SMALLINT NOT NULL,
            selectable SMALLINT NOT NULL,
            ordenable SMALLINT NOT NULL,
            operatorable SMALLINT NOT NULL,
            whereable SMALLINT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT report_field_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* report_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'report_type')
BEGIN
     DECLARE @reftable_81 nvarchar(60), @constraintname_81 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'report_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_81, @constraintname_81
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_81+' drop constraint '+@constraintname_81)
       FETCH NEXT from refcursor into @reftable_81, @constraintname_81
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE report_type
END
;

CREATE TABLE report_type
(
            id INT NOT NULL,
            showable SMALLINT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT report_type_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* report_type_map                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='report_type_map_FK_1')
    ALTER TABLE report_type_map DROP CONSTRAINT report_type_map_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='report_type_map_FK_2')
    ALTER TABLE report_type_map DROP CONSTRAINT report_type_map_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'report_type_map')
BEGIN
     DECLARE @reftable_82 nvarchar(60), @constraintname_82 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'report_type_map'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_82, @constraintname_82
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_82+' drop constraint '+@constraintname_82)
       FETCH NEXT from refcursor into @reftable_82, @constraintname_82
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE report_type_map
END
;

CREATE TABLE report_type_map
(
            report_id INT NULL,
            type_id INT NULL,
);





/* ---------------------------------------------------------------------- */
/* report_user                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='report_user_FK_1')
    ALTER TABLE report_user DROP CONSTRAINT report_user_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='report_user_FK_2')
    ALTER TABLE report_user DROP CONSTRAINT report_user_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'report_user')
BEGIN
     DECLARE @reftable_83 nvarchar(60), @constraintname_83 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'report_user'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_83, @constraintname_83
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_83+' drop constraint '+@constraintname_83)
       FETCH NEXT from refcursor into @reftable_83, @constraintname_83
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE report_user
END
;

CREATE TABLE report_user
(
            id INT NOT NULL,
            user_id INT NULL,
            report_id INT NULL,
            create_datetime DATETIME NOT NULL,
            title VARCHAR (50) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT report_user_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* role                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'role')
BEGIN
     DECLARE @reftable_84 nvarchar(60), @constraintname_84 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'role'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_84, @constraintname_84
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_84+' drop constraint '+@constraintname_84)
       FETCH NEXT from refcursor into @reftable_84, @constraintname_84
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE role
END
;

CREATE TABLE role
(
            id INT NOT NULL,

    CONSTRAINT role_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* user_credit_card_map                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'user_credit_card_map')
BEGIN
     DECLARE @reftable_85 nvarchar(60), @constraintname_85 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'user_credit_card_map'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_85, @constraintname_85
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_85+' drop constraint '+@constraintname_85)
       FETCH NEXT from refcursor into @reftable_85, @constraintname_85
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE user_credit_card_map
END
;

CREATE TABLE user_credit_card_map
(
            user_id INT NULL,
            credit_card_id INT NULL,
);

CREATE  INDEX user_credit_card_map_i_2 ON user_credit_card_map (user_id, credit_card_id);




/* ---------------------------------------------------------------------- */
/* user_role_map                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='user_role_map_FK_1')
    ALTER TABLE user_role_map DROP CONSTRAINT user_role_map_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='user_role_map_FK_2')
    ALTER TABLE user_role_map DROP CONSTRAINT user_role_map_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'user_role_map')
BEGIN
     DECLARE @reftable_86 nvarchar(60), @constraintname_86 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'user_role_map'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_86, @constraintname_86
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_86+' drop constraint '+@constraintname_86)
       FETCH NEXT from refcursor into @reftable_86, @constraintname_86
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE user_role_map
END
;

CREATE TABLE user_role_map
(
            user_id INT NULL,
            role_id INT NULL,
);

CREATE  INDEX user_role_map_i_2 ON user_role_map (user_id, role_id);
CREATE  INDEX user_role_map_i_role ON user_role_map (role_id);




/* ---------------------------------------------------------------------- */
/* mediation_cfg                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='mediation_cfg_FK_1')
    ALTER TABLE mediation_cfg DROP CONSTRAINT mediation_cfg_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'mediation_cfg')
BEGIN
     DECLARE @reftable_87 nvarchar(60), @constraintname_87 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'mediation_cfg'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_87, @constraintname_87
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_87+' drop constraint '+@constraintname_87)
       FETCH NEXT from refcursor into @reftable_87, @constraintname_87
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE mediation_cfg
END
;

CREATE TABLE mediation_cfg
(
            id INT NOT NULL,
            entity_id INT NOT NULL,
            create_datetime DATETIME NOT NULL,
            name VARCHAR (50) NOT NULL,
            order_value INT NOT NULL,
            pluggable_task_id INT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT mediation_cfg_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* mediation_process                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='mediation_process_FK_1')
    ALTER TABLE mediation_process DROP CONSTRAINT mediation_process_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'mediation_process')
BEGIN
     DECLARE @reftable_88 nvarchar(60), @constraintname_88 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'mediation_process'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_88, @constraintname_88
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_88+' drop constraint '+@constraintname_88)
       FETCH NEXT from refcursor into @reftable_88, @constraintname_88
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE mediation_process
END
;

CREATE TABLE mediation_process
(
            id INT NOT NULL,
            configuration_id INT NOT NULL,
            start_datetime DATETIME NOT NULL,
            end_datetime DATETIME default 'NULL' NULL,
            orders_affected INT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT mediation_process_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* mediation_order_map                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='mediation_order_map_FK_1')
    ALTER TABLE mediation_order_map DROP CONSTRAINT mediation_order_map_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='mediation_order_map_FK_2')
    ALTER TABLE mediation_order_map DROP CONSTRAINT mediation_order_map_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'mediation_order_map')
BEGIN
     DECLARE @reftable_89 nvarchar(60), @constraintname_89 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'mediation_order_map'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_89, @constraintname_89
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_89+' drop constraint '+@constraintname_89)
       FETCH NEXT from refcursor into @reftable_89, @constraintname_89
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE mediation_order_map
END
;

CREATE TABLE mediation_order_map
(
            mediation_process_id INT NOT NULL,
            order_id INT NOT NULL,
);





/* ---------------------------------------------------------------------- */
/* mediation_record                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='mediation_record_FK_1')
    ALTER TABLE mediation_record DROP CONSTRAINT mediation_record_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='mediation_record_FK_2')
    ALTER TABLE mediation_record DROP CONSTRAINT mediation_record_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'mediation_record')
BEGIN
     DECLARE @reftable_90 nvarchar(60), @constraintname_90 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'mediation_record'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_90, @constraintname_90
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_90+' drop constraint '+@constraintname_90)
       FETCH NEXT from refcursor into @reftable_90, @constraintname_90
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE mediation_record
END
;

CREATE TABLE mediation_record
(
            id_key VARCHAR (100) NOT NULL,
            start_datetime DATETIME NOT NULL,
            mediation_process_id INT NULL,
            status_id INT NOT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT mediation_record_PK PRIMARY KEY(id_key));

CREATE  INDEX mediation_record_i ON mediation_record (id_key, status_id);




/* ---------------------------------------------------------------------- */
/* mediation_record_line                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='mediation_record_line_FK_1')
    ALTER TABLE mediation_record_line DROP CONSTRAINT mediation_record_line_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='mediation_record_line_FK_2')
    ALTER TABLE mediation_record_line DROP CONSTRAINT mediation_record_line_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'mediation_record_line')
BEGIN
     DECLARE @reftable_91 nvarchar(60), @constraintname_91 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'mediation_record_line'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_91, @constraintname_91
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_91+' drop constraint '+@constraintname_91)
       FETCH NEXT from refcursor into @reftable_91, @constraintname_91
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE mediation_record_line
END
;

CREATE TABLE mediation_record_line
(
            id INT NOT NULL,
            mediation_record_id VARCHAR (100) NOT NULL,
            order_line_id INT NOT NULL,
            event_date DATETIME NOT NULL,
            amount NUMERIC (22,10) NOT NULL,
            quantity NUMERIC (22,10) NOT NULL,
            description VARCHAR (200) NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT mediation_record_line_PK PRIMARY KEY(id));

CREATE  INDEX ix_mrl_order_line ON mediation_record_line (order_line_id);




/* ---------------------------------------------------------------------- */
/* blacklist                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='blacklist_FK_1')
    ALTER TABLE blacklist DROP CONSTRAINT blacklist_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='blacklist_FK_2')
    ALTER TABLE blacklist DROP CONSTRAINT blacklist_FK_2;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'blacklist')
BEGIN
     DECLARE @reftable_92 nvarchar(60), @constraintname_92 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'blacklist'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_92, @constraintname_92
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_92+' drop constraint '+@constraintname_92)
       FETCH NEXT from refcursor into @reftable_92, @constraintname_92
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE blacklist
END
;

CREATE TABLE blacklist
(
            id INT NOT NULL,
            entity_id INT NOT NULL,
            create_datetime DATETIME NOT NULL,
            type INT NOT NULL,
            source INT NOT NULL,
            credit_card INT NULL,
            credit_card_id INT NULL,
            contact_id INT NULL,
            user_id INT NULL,
            OPTLOCK INT NOT NULL,

    CONSTRAINT blacklist_PK PRIMARY KEY(id));

CREATE  INDEX ix_blacklist_user_type ON blacklist (user_id, type);
CREATE  INDEX ix_blacklist_entity_type ON blacklist (entity_id, type);




/* ---------------------------------------------------------------------- */
/* generic_status_type                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'generic_status_type')
BEGIN
     DECLARE @reftable_93 nvarchar(60), @constraintname_93 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'generic_status_type'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_93, @constraintname_93
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_93+' drop constraint '+@constraintname_93)
       FETCH NEXT from refcursor into @reftable_93, @constraintname_93
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE generic_status_type
END
;

CREATE TABLE generic_status_type
(
            id VARCHAR (40) NOT NULL,

    CONSTRAINT generic_status_type_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* generic_status                                                      */
/* ---------------------------------------------------------------------- */

IF EXISTS (SELECT 1 FROM sysobjects WHERE type ='RI' AND name='generic_status_FK_1')
    ALTER TABLE generic_status DROP CONSTRAINT generic_status_FK_1;
IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'U' AND name = 'generic_status')
BEGIN
     DECLARE @reftable_94 nvarchar(60), @constraintname_94 nvarchar(60)
     DECLARE refcursor CURSOR FOR
     select reftables.name tablename, cons.name constraintname
      from sysobjects tables,
           sysobjects reftables,
           sysobjects cons,
           sysreferences ref
       where tables.id = ref.rkeyid
         and cons.id = ref.constid
         and reftables.id = ref.fkeyid
         and tables.name = 'generic_status'
     OPEN refcursor
     FETCH NEXT from refcursor into @reftable_94, @constraintname_94
     while @@FETCH_STATUS = 0
     BEGIN
       exec ('alter table '+@reftable_94+' drop constraint '+@constraintname_94)
       FETCH NEXT from refcursor into @reftable_94, @constraintname_94
     END
     CLOSE refcursor
     DEALLOCATE refcursor
     DROP TABLE generic_status
END
;

CREATE TABLE generic_status
(
            id INT NOT NULL,
            dtype VARCHAR (40) NOT NULL,
            status_value INT NOT NULL,
            can_login SMALLINT NULL,

    CONSTRAINT generic_status_PK PRIMARY KEY(id));





/* ---------------------------------------------------------------------- */
/* generic_status                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE ach
    ADD CONSTRAINT ach_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
END
;




/* ---------------------------------------------------------------------- */
/* ach                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE ageing_entity_step
    ADD CONSTRAINT ageing_entity_step_FK_1 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
END
;

BEGIN
ALTER TABLE ageing_entity_step
    ADD CONSTRAINT ageing_entity_step_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;




/* ---------------------------------------------------------------------- */
/* ageing_entity_step                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE base_user
    ADD CONSTRAINT base_user_FK_1 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
END
;

BEGIN
ALTER TABLE base_user
    ADD CONSTRAINT base_user_FK_2 FOREIGN KEY (subscriber_status)
    REFERENCES generic_status (id)
END
;

BEGIN
ALTER TABLE base_user
    ADD CONSTRAINT base_user_FK_3 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;

BEGIN
ALTER TABLE base_user
    ADD CONSTRAINT base_user_FK_4 FOREIGN KEY (language_id)
    REFERENCES language (id)
END
;

BEGIN
ALTER TABLE base_user
    ADD CONSTRAINT base_user_FK_5 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
END
;




/* ---------------------------------------------------------------------- */
/* base_user                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE billing_process
    ADD CONSTRAINT billing_process_FK_1 FOREIGN KEY (period_unit_id)
    REFERENCES period_unit (id)
END
;

BEGIN
ALTER TABLE billing_process
    ADD CONSTRAINT billing_process_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;

BEGIN
ALTER TABLE billing_process
    ADD CONSTRAINT billing_process_FK_3 FOREIGN KEY (paper_invoice_batch_id)
    REFERENCES paper_invoice_batch (id)
END
;




/* ---------------------------------------------------------------------- */
/* billing_process                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE billing_process_configuration
    ADD CONSTRAINT billing_process_configura_FK_1 FOREIGN KEY (period_unit_id)
    REFERENCES period_unit (id)
END
;

BEGIN
ALTER TABLE billing_process_configuration
    ADD CONSTRAINT billing_process_configura_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;




/* ---------------------------------------------------------------------- */
/* billing_process_configuration                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE process_run
    ADD CONSTRAINT process_run_FK_1 FOREIGN KEY (process_id)
    REFERENCES billing_process (id)
END
;

BEGIN
ALTER TABLE process_run
    ADD CONSTRAINT process_run_FK_2 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
END
;




/* ---------------------------------------------------------------------- */
/* process_run                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE process_run_total
    ADD CONSTRAINT process_run_total_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
END
;

BEGIN
ALTER TABLE process_run_total
    ADD CONSTRAINT process_run_total_FK_2 FOREIGN KEY (process_run_id)
    REFERENCES process_run (id)
END
;




/* ---------------------------------------------------------------------- */
/* process_run_total                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE process_run_total_pm
    ADD CONSTRAINT process_run_total_pm_FK_1 FOREIGN KEY (payment_method_id)
    REFERENCES payment_method (id)
END
;




/* ---------------------------------------------------------------------- */
/* process_run_total_pm                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE process_run_user
    ADD CONSTRAINT process_run_user_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
END
;

BEGIN
ALTER TABLE process_run_user
    ADD CONSTRAINT process_run_user_FK_2 FOREIGN KEY (process_run_id)
    REFERENCES process_run (id)
END
;




/* ---------------------------------------------------------------------- */
/* process_run_user                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* contact                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE contact_field
    ADD CONSTRAINT contact_field_FK_1 FOREIGN KEY (contact_id)
    REFERENCES contact (id)
END
;

BEGIN
ALTER TABLE contact_field
    ADD CONSTRAINT contact_field_FK_2 FOREIGN KEY (type_id)
    REFERENCES contact_field_type (id)
END
;




/* ---------------------------------------------------------------------- */
/* contact_field                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE contact_field_type
    ADD CONSTRAINT contact_field_type_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;




/* ---------------------------------------------------------------------- */
/* contact_field_type                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE contact_map
    ADD CONSTRAINT contact_map_FK_1 FOREIGN KEY (table_id)
    REFERENCES jbilling_table (id)
END
;

BEGIN
ALTER TABLE contact_map
    ADD CONSTRAINT contact_map_FK_2 FOREIGN KEY (type_id)
    REFERENCES contact_type (id)
END
;

BEGIN
ALTER TABLE contact_map
    ADD CONSTRAINT contact_map_FK_3 FOREIGN KEY (contact_id)
    REFERENCES contact (id)
END
;




/* ---------------------------------------------------------------------- */
/* contact_map                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE contact_type
    ADD CONSTRAINT contact_type_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;




/* ---------------------------------------------------------------------- */
/* contact_type                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* country                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* credit_card                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* currency                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE currency_entity_map
    ADD CONSTRAINT currency_entity_map_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;

BEGIN
ALTER TABLE currency_entity_map
    ADD CONSTRAINT currency_entity_map_FK_2 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
END
;




/* ---------------------------------------------------------------------- */
/* currency_entity_map                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE currency_exchange
    ADD CONSTRAINT currency_exchange_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
END
;




/* ---------------------------------------------------------------------- */
/* currency_exchange                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE customer
    ADD CONSTRAINT customer_FK_1 FOREIGN KEY (invoice_delivery_method_id)
    REFERENCES invoice_delivery_method (id)
END
;

BEGIN
ALTER TABLE customer
    ADD CONSTRAINT customer_FK_2 FOREIGN KEY (partner_id)
    REFERENCES partner (id)
END
;

BEGIN
ALTER TABLE customer
    ADD CONSTRAINT customer_FK_3 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
END
;




/* ---------------------------------------------------------------------- */
/* customer                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE entity
    ADD CONSTRAINT entity_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
END
;

BEGIN
ALTER TABLE entity
    ADD CONSTRAINT entity_FK_2 FOREIGN KEY (language_id)
    REFERENCES language (id)
END
;




/* ---------------------------------------------------------------------- */
/* entity                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE entity_delivery_method_map
    ADD CONSTRAINT entity_delivery_method_ma_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;

BEGIN
ALTER TABLE entity_delivery_method_map
    ADD CONSTRAINT entity_delivery_method_ma_FK_2 FOREIGN KEY (method_id)
    REFERENCES invoice_delivery_method (id)
END
;




/* ---------------------------------------------------------------------- */
/* entity_delivery_method_map                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE entity_payment_method_map
    ADD CONSTRAINT entity_payment_method_map_FK_1 FOREIGN KEY (payment_method_id)
    REFERENCES payment_method (id)
END
;

BEGIN
ALTER TABLE entity_payment_method_map
    ADD CONSTRAINT entity_payment_method_map_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;




/* ---------------------------------------------------------------------- */
/* entity_payment_method_map                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_1 FOREIGN KEY (module_id)
    REFERENCES event_log_module (id)
END
;

BEGIN
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;

BEGIN
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_3 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
END
;

BEGIN
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_4 FOREIGN KEY (affected_user_id)
    REFERENCES base_user (id)
END
;

BEGIN
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_5 FOREIGN KEY (table_id)
    REFERENCES jbilling_table (id)
END
;

BEGIN
ALTER TABLE event_log
    ADD CONSTRAINT event_log_FK_6 FOREIGN KEY (message_id)
    REFERENCES event_log_message (id)
END
;




/* ---------------------------------------------------------------------- */
/* event_log                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* event_log_message                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* event_log_module                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE international_description
    ADD CONSTRAINT international_description_FK_1 FOREIGN KEY (language_id)
    REFERENCES language (id)
END
;

BEGIN
ALTER TABLE international_description
    ADD CONSTRAINT international_description_FK_2 FOREIGN KEY (table_id)
    REFERENCES jbilling_table (id)
END
;




/* ---------------------------------------------------------------------- */
/* international_description                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE invoice
    ADD CONSTRAINT invoice_FK_1 FOREIGN KEY (billing_process_id)
    REFERENCES billing_process (id)
END
;

BEGIN
ALTER TABLE invoice
    ADD CONSTRAINT invoice_FK_2 FOREIGN KEY (paper_invoice_batch_id)
    REFERENCES paper_invoice_batch (id)
END
;

BEGIN
ALTER TABLE invoice
    ADD CONSTRAINT invoice_FK_3 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
END
;

BEGIN
ALTER TABLE invoice
    ADD CONSTRAINT invoice_FK_4 FOREIGN KEY (delegated_invoice_id)
    REFERENCES invoice (id)
END
;

BEGIN
ALTER TABLE invoice
    ADD CONSTRAINT invoice_FK_5 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
END
;




/* ---------------------------------------------------------------------- */
/* invoice                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* invoice_delivery_method                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE invoice_line
    ADD CONSTRAINT invoice_line_FK_1 FOREIGN KEY (invoice_id)
    REFERENCES invoice (id)
END
;

BEGIN
ALTER TABLE invoice_line
    ADD CONSTRAINT invoice_line_FK_2 FOREIGN KEY (item_id)
    REFERENCES item (id)
END
;

BEGIN
ALTER TABLE invoice_line
    ADD CONSTRAINT invoice_line_FK_3 FOREIGN KEY (type_id)
    REFERENCES invoice_line_type (id)
END
;




/* ---------------------------------------------------------------------- */
/* invoice_line                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* invoice_line_type                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE item
    ADD CONSTRAINT item_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;




/* ---------------------------------------------------------------------- */
/* item                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE item_price
    ADD CONSTRAINT item_price_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
END
;

BEGIN
ALTER TABLE item_price
    ADD CONSTRAINT item_price_FK_2 FOREIGN KEY (item_id)
    REFERENCES item (id)
END
;




/* ---------------------------------------------------------------------- */
/* item_price                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE item_type
    ADD CONSTRAINT item_type_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;




/* ---------------------------------------------------------------------- */
/* item_type                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE item_type_map
    ADD CONSTRAINT item_type_map_FK_1 FOREIGN KEY (item_id)
    REFERENCES item (id)
END
;

BEGIN
ALTER TABLE item_type_map
    ADD CONSTRAINT item_type_map_FK_2 FOREIGN KEY (type_id)
    REFERENCES item_type (id)
END
;




/* ---------------------------------------------------------------------- */
/* item_type_map                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* jbilling_table                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* jbilling_seqs                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* language                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* list                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE list_entity
    ADD CONSTRAINT list_entity_FK_1 FOREIGN KEY (list_id)
    REFERENCES list (id)
END
;

BEGIN
ALTER TABLE list_entity
    ADD CONSTRAINT list_entity_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;




/* ---------------------------------------------------------------------- */
/* list_entity                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE list_field
    ADD CONSTRAINT list_field_FK_1 FOREIGN KEY (list_id)
    REFERENCES list (id)
END
;




/* ---------------------------------------------------------------------- */
/* list_field                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE list_field_entity
    ADD CONSTRAINT list_field_entity_FK_1 FOREIGN KEY (list_entity_id)
    REFERENCES list_entity (id)
END
;

BEGIN
ALTER TABLE list_field_entity
    ADD CONSTRAINT list_field_entity_FK_2 FOREIGN KEY (list_field_id)
    REFERENCES list_field (id)
END
;




/* ---------------------------------------------------------------------- */
/* list_field_entity                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE menu_option
    ADD CONSTRAINT menu_option_FK_1 FOREIGN KEY (parent_id)
    REFERENCES menu_option (id)
END
;




/* ---------------------------------------------------------------------- */
/* menu_option                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE notification_message
    ADD CONSTRAINT notification_message_FK_1 FOREIGN KEY (language_id)
    REFERENCES language (id)
END
;

BEGIN
ALTER TABLE notification_message
    ADD CONSTRAINT notification_message_FK_2 FOREIGN KEY (type_id)
    REFERENCES notification_message_type (id)
END
;

BEGIN
ALTER TABLE notification_message
    ADD CONSTRAINT notification_message_FK_3 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;




/* ---------------------------------------------------------------------- */
/* notification_message                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* notification_message_arch                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE notification_message_arch_line
    ADD CONSTRAINT notif_mess_arch_line_FK_1 FOREIGN KEY (message_archive_id)
    REFERENCES notification_message_arch (id)
END
;




/* ---------------------------------------------------------------------- */
/* notification_message_arch_line                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE notification_message_line
    ADD CONSTRAINT notification_message_line_FK_1 FOREIGN KEY (message_section_id)
    REFERENCES notification_message_section (id)
END
;




/* ---------------------------------------------------------------------- */
/* notification_message_line                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE notification_message_section
    ADD CONSTRAINT notification_message_sect_FK_1 FOREIGN KEY (message_id)
    REFERENCES notification_message (id)
END
;




/* ---------------------------------------------------------------------- */
/* notification_message_section                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* notification_message_type                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* order_billing_type                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE order_line
    ADD CONSTRAINT order_line_FK_1 FOREIGN KEY (item_id)
    REFERENCES item (id)
END
;

BEGIN
ALTER TABLE order_line
    ADD CONSTRAINT order_line_FK_2 FOREIGN KEY (order_id)
    REFERENCES purchase_order (id)
END
;

BEGIN
ALTER TABLE order_line
    ADD CONSTRAINT order_line_FK_3 FOREIGN KEY (type_id)
    REFERENCES order_line_type (id)
END
;




/* ---------------------------------------------------------------------- */
/* order_line                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* order_line_type                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE order_period
    ADD CONSTRAINT order_period_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;

BEGIN
ALTER TABLE order_period
    ADD CONSTRAINT order_period_FK_2 FOREIGN KEY (unit_id)
    REFERENCES period_unit (id)
END
;




/* ---------------------------------------------------------------------- */
/* order_period                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE order_process
    ADD CONSTRAINT order_process_FK_1 FOREIGN KEY (order_id)
    REFERENCES purchase_order (id)
END
;




/* ---------------------------------------------------------------------- */
/* order_process                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* paper_invoice_batch                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE partner
    ADD CONSTRAINT partner_FK_1 FOREIGN KEY (period_unit_id)
    REFERENCES period_unit (id)
END
;

BEGIN
ALTER TABLE partner
    ADD CONSTRAINT partner_FK_2 FOREIGN KEY (fee_currency_id)
    REFERENCES currency (id)
END
;

BEGIN
ALTER TABLE partner
    ADD CONSTRAINT partner_FK_3 FOREIGN KEY (related_clerk)
    REFERENCES base_user (id)
END
;

BEGIN
ALTER TABLE partner
    ADD CONSTRAINT partner_FK_4 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
END
;




/* ---------------------------------------------------------------------- */
/* partner                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE partner_payout
    ADD CONSTRAINT partner_payout_FK_1 FOREIGN KEY (partner_id)
    REFERENCES partner (id)
END
;




/* ---------------------------------------------------------------------- */
/* partner_payout                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* partner_range                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_1 FOREIGN KEY (ach_id)
    REFERENCES ach (id)
END
;

BEGIN
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_2 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
END
;

BEGIN
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_3 FOREIGN KEY (payment_id)
    REFERENCES payment (id)
END
;

BEGIN
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_4 FOREIGN KEY (credit_card_id)
    REFERENCES credit_card (id)
END
;

BEGIN
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_5 FOREIGN KEY (result_id)
    REFERENCES payment_result (id)
END
;

BEGIN
ALTER TABLE payment
    ADD CONSTRAINT payment_FK_6 FOREIGN KEY (method_id)
    REFERENCES payment_method (id)
END
;




/* ---------------------------------------------------------------------- */
/* payment                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE payment_authorization
    ADD CONSTRAINT payment_authorization_FK_1 FOREIGN KEY (payment_id)
    REFERENCES payment (id)
END
;




/* ---------------------------------------------------------------------- */
/* payment_authorization                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE payment_info_cheque
    ADD CONSTRAINT payment_info_cheque_FK_1 FOREIGN KEY (payment_id)
    REFERENCES payment (id)
END
;




/* ---------------------------------------------------------------------- */
/* payment_info_cheque                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE payment_invoice
    ADD CONSTRAINT payment_invoice_FK_1 FOREIGN KEY (invoice_id)
    REFERENCES invoice (id)
END
;

BEGIN
ALTER TABLE payment_invoice
    ADD CONSTRAINT payment_invoice_FK_2 FOREIGN KEY (payment_id)
    REFERENCES payment (id)
END
;




/* ---------------------------------------------------------------------- */
/* payment_invoice                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* payment_method                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* payment_result                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* period_unit                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE permission
    ADD CONSTRAINT permission_FK_1 FOREIGN KEY (type_id)
    REFERENCES permission_type (id)
END
;




/* ---------------------------------------------------------------------- */
/* permission                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE permission_role_map
    ADD CONSTRAINT permission_role_map_FK_1 FOREIGN KEY (role_id)
    REFERENCES role (id)
END
;

BEGIN
ALTER TABLE permission_role_map
    ADD CONSTRAINT permission_role_map_FK_2 FOREIGN KEY (permission_id)
    REFERENCES permission (id)
END
;




/* ---------------------------------------------------------------------- */
/* permission_role_map                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* permission_type                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE permission_user
    ADD CONSTRAINT permission_user_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
END
;

BEGIN
ALTER TABLE permission_user
    ADD CONSTRAINT permission_user_FK_2 FOREIGN KEY (permission_id)
    REFERENCES permission (id)
END
;




/* ---------------------------------------------------------------------- */
/* permission_user                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE pluggable_task
    ADD CONSTRAINT pluggable_task_FK_1 FOREIGN KEY (type_id)
    REFERENCES pluggable_task_type (id)
END
;

BEGIN
ALTER TABLE pluggable_task
    ADD CONSTRAINT pluggable_task_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;




/* ---------------------------------------------------------------------- */
/* pluggable_task                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE pluggable_task_parameter
    ADD CONSTRAINT pluggable_task_parameter_FK_1 FOREIGN KEY (task_id)
    REFERENCES pluggable_task (id)
END
;




/* ---------------------------------------------------------------------- */
/* pluggable_task_parameter                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE pluggable_task_type
    ADD CONSTRAINT pluggable_task_type_FK_1 FOREIGN KEY (category_id)
    REFERENCES pluggable_task_type_category (id)
END
;




/* ---------------------------------------------------------------------- */
/* pluggable_task_type                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* pluggable_task_type_category                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE preference
    ADD CONSTRAINT preference_FK_1 FOREIGN KEY (type_id)
    REFERENCES preference_type (id)
END
;

BEGIN
ALTER TABLE preference
    ADD CONSTRAINT preference_FK_2 FOREIGN KEY (table_id)
    REFERENCES jbilling_table (id)
END
;




/* ---------------------------------------------------------------------- */
/* preference                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* preference_type                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE promotion
    ADD CONSTRAINT promotion_FK_1 FOREIGN KEY (item_id)
    REFERENCES item (id)
END
;




/* ---------------------------------------------------------------------- */
/* promotion                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_1 FOREIGN KEY (currency_id)
    REFERENCES currency (id)
END
;

BEGIN
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_2 FOREIGN KEY (billing_type_id)
    REFERENCES order_billing_type (id)
END
;

BEGIN
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_3 FOREIGN KEY (period_id)
    REFERENCES order_period (id)
END
;

BEGIN
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_4 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
END
;

BEGIN
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_5 FOREIGN KEY (created_by)
    REFERENCES base_user (id)
END
;

BEGIN
ALTER TABLE purchase_order
    ADD CONSTRAINT purchase_order_FK_6 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
END
;




/* ---------------------------------------------------------------------- */
/* purchase_order                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* report                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE report_entity_map
    ADD CONSTRAINT report_entity_map_FK_1 FOREIGN KEY (report_id)
    REFERENCES report (id)
END
;

BEGIN
ALTER TABLE report_entity_map
    ADD CONSTRAINT report_entity_map_FK_2 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;




/* ---------------------------------------------------------------------- */
/* report_entity_map                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE report_field
    ADD CONSTRAINT report_field_FK_1 FOREIGN KEY (report_id)
    REFERENCES report (id)
END
;




/* ---------------------------------------------------------------------- */
/* report_field                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* report_type                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE report_type_map
    ADD CONSTRAINT report_type_map_FK_1 FOREIGN KEY (type_id)
    REFERENCES report_type (id)
END
;

BEGIN
ALTER TABLE report_type_map
    ADD CONSTRAINT report_type_map_FK_2 FOREIGN KEY (report_id)
    REFERENCES report (id)
END
;




/* ---------------------------------------------------------------------- */
/* report_type_map                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE report_user
    ADD CONSTRAINT report_user_FK_1 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
END
;

BEGIN
ALTER TABLE report_user
    ADD CONSTRAINT report_user_FK_2 FOREIGN KEY (report_id)
    REFERENCES report (id)
END
;




/* ---------------------------------------------------------------------- */
/* report_user                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* role                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* user_credit_card_map                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE user_role_map
    ADD CONSTRAINT user_role_map_FK_1 FOREIGN KEY (role_id)
    REFERENCES role (id)
END
;

BEGIN
ALTER TABLE user_role_map
    ADD CONSTRAINT user_role_map_FK_2 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
END
;




/* ---------------------------------------------------------------------- */
/* user_role_map                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE mediation_cfg
    ADD CONSTRAINT mediation_cfg_FK_1 FOREIGN KEY (pluggable_task_id)
    REFERENCES pluggable_task (id)
END
;




/* ---------------------------------------------------------------------- */
/* mediation_cfg                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE mediation_process
    ADD CONSTRAINT mediation_process_FK_1 FOREIGN KEY (configuration_id)
    REFERENCES mediation_cfg (id)
END
;




/* ---------------------------------------------------------------------- */
/* mediation_process                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE mediation_order_map
    ADD CONSTRAINT mediation_order_map_FK_1 FOREIGN KEY (mediation_process_id)
    REFERENCES mediation_process (id)
END
;

BEGIN
ALTER TABLE mediation_order_map
    ADD CONSTRAINT mediation_order_map_FK_2 FOREIGN KEY (order_id)
    REFERENCES purchase_order (id)
END
;




/* ---------------------------------------------------------------------- */
/* mediation_order_map                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE mediation_record
    ADD CONSTRAINT mediation_record_FK_1 FOREIGN KEY (mediation_process_id)
    REFERENCES mediation_process (id)
END
;

BEGIN
ALTER TABLE mediation_record
    ADD CONSTRAINT mediation_record_FK_2 FOREIGN KEY (status_id)
    REFERENCES generic_status (id)
END
;




/* ---------------------------------------------------------------------- */
/* mediation_record                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE mediation_record_line
    ADD CONSTRAINT mediation_record_line_FK_1 FOREIGN KEY (mediation_record_id)
    REFERENCES mediation_record (id_key)
END
;

BEGIN
ALTER TABLE mediation_record_line
    ADD CONSTRAINT mediation_record_line_FK_2 FOREIGN KEY (order_line_id)
    REFERENCES order_line (id)
END
;




/* ---------------------------------------------------------------------- */
/* mediation_record_line                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE blacklist
    ADD CONSTRAINT blacklist_FK_1 FOREIGN KEY (entity_id)
    REFERENCES entity (id)
END
;

BEGIN
ALTER TABLE blacklist
    ADD CONSTRAINT blacklist_FK_2 FOREIGN KEY (user_id)
    REFERENCES base_user (id)
END
;




/* ---------------------------------------------------------------------- */
/* blacklist                                                      */
/* ---------------------------------------------------------------------- */




/* ---------------------------------------------------------------------- */
/* generic_status_type                                                      */
/* ---------------------------------------------------------------------- */

BEGIN
ALTER TABLE generic_status
    ADD CONSTRAINT generic_status_FK_1 FOREIGN KEY (dtype)
    REFERENCES generic_status_type (id)
END
;



