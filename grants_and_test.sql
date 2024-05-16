create index part_index on parts ( TYPE,MANUFACTURER,P_MODEL);
create index part_index2 on parts ( TYPE,P_MODEL);
create index part_index3 on parts ( MANUFACTURER);
create index part_index4 on parts ( MANUFACTURER,P_MODEL);

drop index part_index;
drop index part_index2;
drop index part_index3;
drop index part_index4;


grant create trigger to dev;

select * from customers;

begin 
create_customer('выыв','testsmoonlign');
end;
select * from customers;
delete customers where email='uiadfsa';

DECLARE
   j NUMBER;
BEGIN
   FOR j IN 1..2 LOOP
   Add_Other_Part('testo_test_ming');
   END LOOP;
END;

DECLARE
     j NUMBER;
    v_model parts.p_model%TYPE;
    v_manufacturer parts.manufacturer%TYPE;
    v_price parts.price%TYPE;
    v_count parts.p_count%TYPE;
    v_description parts.p_description%TYPE;
BEGIN
     FOR j IN 1..200000 LOOP
    v_model := 'Model_' || DBMS_RANDOM.STRING('A', 5);  
    v_manufacturer := DBMS_RANDOM.STRING('A', 10);      
    v_price := ROUND(DBMS_RANDOM.VALUE(10, 1000), 2);   
    v_count := ROUND(DBMS_RANDOM.VALUE(1, 100));        
    v_description := DBMS_RANDOM.STRING('A', 20);       
    Add_Other_Part(v_model, v_manufacturer, v_price, v_count, v_description);
    END LOOP;
end;
delete parts;
select * from parts where MANUFACTURER like 'e%' and p_model like 'Model_ad%'; 

----dd
select * from customers;select * from orders;

CREATE OR REPLACE procedure fill_order_cust ( 
p_order_id in order_elems.order_id%TYPE,p_part_id in order_elems.part_id%TYPE , p_count in order_elems.order_id%TYPE,p_pass in customers.password%TYPE)
is 
counter int;
trg int;
ch_pass customers.password%TYPE;
begin 
select p_count into counter from parts where part_id = p_part_id ;
select p_status into trg from parts where part_id = p_part_id ;

select password into ch_pass from customers where email = (select email from orders where order_id = p_order_id);
if p_count >0 and p_pass = ch_pass and counter>p_count-1 and trg=0 then 
insert into order_elems values(p_order_id,p_part_id,p_count);
dbms_output.put_line('ok');
else
dbms_output.put_line('проверьте введеные данные');end if;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
       WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);    
end;


CREATE OR REPLACE procedure cut_order_cust ( 
p_order_id in order_elems.order_id%TYPE,p_pass in customers.password%TYPE)
is 
ch_pass customers.password%TYPE;
begin 
select password into ch_pass from customers where email = (select email from orders where order_id = p_order_id);
if p_pass = ch_pass then 
delete order_elems where order_id = p_order_id;
else 
DBMS_OUTPUT.PUT_LINE('проверьте данные.');
end if;
EXCEPTION
     WHEN OTHERS THEN
       dbms_output.put_line('ошибка '||sqlcode);
end;

select * from user_procedures where object_name like '%mbo%';

GRANt execute on UNFINISH_ORDER to salesman_role;
GRANt execute on FINISH_ORDER to salesman_role;

GRANt execute on update_cpu to salesman_role;
GRANt execute on update_gpu to salesman_role;
GRANt execute on update_storage to salesman_role;
GRANt execute on update_ram to salesman_role;
GRANt execute on update_other to salesman_role;
GRANt execute on update_mboard to salesman_role;

GRANt execute on add_cpu to salesman_role;
GRANt execute on add_gpu to salesman_role;
GRANt execute on add_storage to salesman_role;
GRANt execute on add_ram to salesman_role;
GRANt execute on add_other_part to salesman_role;
GRANt execute on add_mboard to salesman_role;

GRANt execute on delete_part to salesman_role;
GRANt execute on return_part to salesman_role;
GRANt execute on cut_order to salesman_role;
GRANt execute on fill_order to salesman_role;

GRANt execute on count_money to salesman_role;

GRANt execute on return_part to salesman_role;
GRANt execute on cut_order to salesman_role;
GRANt execute on fill_order to salesman_role;

grant select on Parts_V to salesman_role;
grant select on gpu_V to salesman_role;
grant select on cpu_V to salesman_role;
grant select on storage_V to salesman_role;
grant select on ram_V to salesman_role;
grant select on mboard_V to salesman_role;
grant select on adress_V to salesman_role;
grant select on orders_in_elems_V to salesman_role;
grant select on adress_V to salesman_role;
grant execute on edit_part_count
 to salesman_role;

grant select on orders_V to salesman_role;


grant select on Parts_V to customer_role;
grant select on gpu_V to customer_role;
grant select on cpu_V to customer_role;
grant select on storage_V to customer_role;
grant select on ram_V to customer_role;
grant select on mboard_V to customer_role;



GRANt execute on create_customer to customer_role;
GRANt execute on make_order to customer_role;
GRANt execute on cut_order_cust to customer_role;
GRANt execute on fill_order_cust to customer_role;
GRANt execute on create_adress to customer_role;

select * from user_procedures;


drop procedure show_orders_cust;

CREATE OR REPLACE FUNCTION show_orders_cust (p_email IN customers.password%TYPE, p_pass IN customers.password%TYPE) RETURN sys_refcursor
IS
    ord_cursor sys_refcursor;
    rcount INT;
BEGIN
    SELECT COUNT(*)
    INTO rcount
    FROM customers
    WHERE customers.email = p_email
    AND customers.password = p_pass;
    
    IF rcount = 1 THEN
        OPEN ord_cursor FOR
        SELECT ord.order_id, email, adress_id, elem.part_id, ord_date, ord_status, count
        FROM orders ord
        JOIN order_elems elem ON ord.order_id = elem.order_id
        WHERE email = p_email;
        
        RETURN ord_cursor;
    ELSE
        DBMS_OUTPUT.PUT_LINE('проверьте данные.');
        RETURN NULL;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ошибка '||SQLCODE);
        RETURN NULL;
END;

CREATE OR REPLACE FUNCTION show_adress_cust ( 
p_email in customers.password%TYPE,
p_pass in customers.password%TYPE) RETURN sys_refcursor 
is 
ord_cursor sys_refcursor;
rcount int;
begin 
select count(*) into rcount from customers where customers.email = p_email and customers.password = p_pass;
if rcount = 1 then 
open ord_cursor for
select * from adress where email = p_email;
return ord_cursor;
else 
DBMS_OUTPUT.PUT_LINE('проверьте данные.');
return NULL;
end if;
EXCEPTION
     WHEN OTHERS THEN
       dbms_output.put_line('ошибка '||sqlcode);
end;

grant execute on show_orders_cust to customer_role

grant execute on show_adress_cust to customer_role
