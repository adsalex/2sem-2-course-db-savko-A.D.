Create tablespace  shopts
   DATAFILE 'shopts.dbf' 
   SIZE 10m
   AUTOEXTEND ON NEXT 10m MAXSIZE UNLIMITED;

Create temporary tablespace  shopts_tmp
   TempFILE 'shopts_temp.dbf' 
   SIZE 10m
   AUTOEXTEND ON NEXT 10m MAXSIZE UNLIMITED;
--drop tablespace shopts_tmp;

ALTER SESSION SET "_oracle_script" = TRUE

create role dev_role not identified;
create role customer_role not identified;
create role salesman_role not identified;
--pr-start
CREATE PROFILE pf_customer LIMIT
PASSWORD_LIFE_TIME 640
SESSIONS_PER_USER 5000 
FAILED_LOGIN_ATTEMPTS 7 
PASSWORD_LOCK_TIME 1 
PASSWORD_REUSE_TIME 10 
PASSWORD_GRACE_TIME DEFAULT 
CONNECT_TIME 180 
IDLE_TIME 30;
--
CREATE PROFILE pf_salesman LIMIT
PASSWORD_LIFE_TIME 640
SESSIONS_PER_USER 200 
FAILED_LOGIN_ATTEMPTS 7 
PASSWORD_LOCK_TIME 1 
PASSWORD_REUSE_TIME 10 
PASSWORD_GRACE_TIME DEFAULT 
CONNECT_TIME 180 
IDLE_TIME 30;
---
CREATE PROFILE pf_dev LIMIT
PASSWORD_LIFE_TIME 640
SESSIONS_PER_USER 5 
FAILED_LOGIN_ATTEMPTS 7 
PASSWORD_LOCK_TIME 1 
PASSWORD_REUSE_TIME 10 
PASSWORD_GRACE_TIME DEFAULT 
CONNECT_TIME 180 
IDLE_TIME 30;
--pr-end
--ustart
Create user dev identified by ads
DEFault tablespace shopts
temporary tablespace shopts_tmp
profile pf_dev
account unlock;
--password expire;

Create user customer identified by ads
DEFault tablespace shopts
temporary tablespace shopts_tmp
profile pf_customer
account unlock;
password expire;

Create user salesman identified by ads
DEFault tablespace shopts
temporary tablespace shopts_tmp
profile pf_salesman
account unlock;
--password expire;
--u-end

select * from dba_profiles;

select * from dba_tablespaces;
select * from dba_roles;
select * from all_users where username like 'DEV';

Grant create session, create procedure,create any table,create any view,create any synonym,trigger to dev_role;
Grant dev_role to dev;
Grant create sequence to dev_role
Grant create session to salesman_role;
Grant salesman_role to salesman;
Grant create session to customer_role;
Grant customer_role to customer;
alter user dev quota unlimited on shopts;
--security 
show parameter wallet;
SELECT * FROM v$encryption_wallet;
ADMINISTER KEY MANAGEMENT CREATE KEYSTORE 'D:\ORACLEDB\ADMIN\ORCL\WALLET' IDENTIFIED BY ads ;
alter system set TDE_CONFIGURATION="KEYSTORE_CONFIGURATION=FILE" SCOPE=both ;
ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN  IDENTIFIED BY ads;
--
ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY ads with backup;
ADMINISTER KEY MANAGEMENT CREATE AUTO_LOGIN KEYSTORE FROM KEYSTORE 'D:\ORACLEDB\ADMIN\ORCL\WALLET\tde\' identified by ads;

select * from dev.testing2;
