CREATE OR REPLACE procedure create_customer (mail in nvarchar2,pass in nvarchar2)
is 
begin 
if REGEXP_LIKE(mail, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') then
insert into customers(email,password) values(mail,pass);

else
DBMS_OUTPUT.PUT_LINE('проверьте почту');
end if;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ошибка' || sqlcode);
END;

CREATE OR REPLACE TRIGGER notifier
AFTER INSERT ON customers
FOR EACH ROW
BEGIN
    
    DBMS_OUTPUT.PUT_LINE('добавление записи');
END;

CREATE OR REPLACE TRIGGER taxWriter
BEFORE INSERT ON parts
FOR EACH ROW
BEGIN
    :NEW.price := :NEW.price * 1.2; 
END;
select * from parts;
CREATE OR REPLACE TRIGGER manWriter
BEFORE INSERT ON parts
FOR EACH ROW
BEGIN
  :NEW.manufacturer := :NEW.manufacturer || 'manufatured by: ';
END;
CREATE OR REPLACE TRIGGER modWriter
BEFORE INSERT ON parts
FOR EACH ROW
BEGIN
  :NEW.p_model := :NEW.p_model || 'model ';
END;

select * from user_procedures;

CREATE OR REPLACE procedure create_adress ( 
p_email in adress.email%TYPE,p_pass in customers.password%TYPE, p_city in adress.city%TYPE, p_street in adress.street%TYPE, 
p_house in adress.house%TYPE,p_a_floor in adress.a_floor%TYPE,p_appartment in adress.appartment%TYPE
)
is 
rcount int;
begin 
select count(*) into rcount from customers where email=p_email and password=p_pass;
IF rcount = 1 THEN
      insert into adress values(null, p_email,p_city,p_street,p_house,p_a_floor,p_appartment);
      dbms_output.put_line('ок');
       ELSE
      dbms_output.put_line('проверьте пароль или почту');
    END IF;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
       WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);    
end;
select * from adress;
drop procedure soft_delete_part


CREATE OR REPLACE procedure get_all_parts (part_cursor out sys_refcursor)
is 
begin 
open part_cursor for
select * from customers;
EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);    
end;

select * from parts;
exec create_part(null, 'ModelTtt', 'ABC Company', 1000, 10, 'Part description 1', 'TypeA');

begin
create_customer('ads','testpass');
end;

CREATE OR REPLACE PROCEDURE soft_delete_part (p_row_id IN int) AS
BEGIN
  DECLARE
    l_quantity int;
    l_status smallint;
  BEGIN
    SELECT p_count, p_status
    INTO l_quantity, l_status
    FROM parts
    WHERE part_id = p_row_id;

    IF l_quantity < 1 THEN
      DELETE FROM parts
      WHERE part_id = p_row_id;
    ELSE
      UPDATE parts
      SET p_status = 1
      WHERE part_id = p_row_id;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Row not found');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred');
  END;
END;

CREATE OR REPLACE PROCEDURE make_order (part_id_p IN INT, qty IN INT)
IS 
before_qty INT;
table_stat SMALLINT;
BEGIN
  SELECT p_count, p_status
  INTO before_qty, table_stat
  FROM parts
  WHERE part_id = part_id_p;
  
  IF before_qty >= qty THEN
    INSERT INTO orders VALUES (11);
  END IF;
  
  IF table_stat = 1 AND before_qty < 1 THEN 
    DELETE FROM parts WHERE part_id = part_id_p;
  END IF;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
       WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);    
END;  

drop procedure make_order;

select * from user_procedures;
--select * from parts;
begin
create_customer('ads','testpass');
end;


--grant execute on create_customer to customer;

--drop procedure create_user;
