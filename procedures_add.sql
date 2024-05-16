-- Процедура для добавления значений в таблицу parts
CREATE OR REPLACE PROCEDURE Add_Part(
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    type IN parts.type%TYPE,
    p_status IN parts.p_status%TYPE DEFAULT 0
)
IS
BEGIN
    if p_count < 0 then 
    null;
    INSERT INTO parts (p_model, manufacturer, price, p_count, p_description, type, p_status)
    VALUES (p_model, manufacturer, price, p_count, p_description, type, p_status);
    COMMIT;
    else
     DBMS_OUTPUT.PUT_LINE('количество меньше нуля, откат.');
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
       WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные.');
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);  
END Add_Part;


-- Процедура для добавления значений в таблицу, соответствующую типу товара CPU
CREATE OR REPLACE PROCEDURE Add_CPU(
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    freq IN CPU.freq%TYPE,
    cores IN CPU.cores%TYPE,
    arch IN CPU.arch%TYPE,
    socket IN CPU.socket%TYPE
)
IS
    part_id NUMBER;
BEGIN
    Add_Part(p_model, manufacturer, price, p_count, p_description, 'CPU');
    SELECT part_id INTO part_id FROM parts WHERE p_model = p_model AND type = 'CPU';
    INSERT INTO CPU (part_id, freq, cores, arch, socket)
    VALUES (part_id, freq, cores, arch, socket);
    COMMIT;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
       WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные.');
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);  
END Add_CPU;


-- Процедура для добавления значений в таблицу, соответствующую типу товара GPU
CREATE OR REPLACE PROCEDURE Add_GPU(
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    memtype IN GPU.memtype%TYPE,
    memory IN GPU.memory%TYPE,
    gpu_chip IN GPU.gpu_chip%TYPE
)
IS
    part_id NUMBER;
BEGIN
    Add_Part(p_model, manufacturer, price, p_count, p_description, 'GPU');
    SELECT part_id INTO part_id FROM parts WHERE p_model = p_model AND type = 'GPU';
    INSERT INTO GPU (part_id, memtype, memory, gpu_chip)
    VALUES (part_id, memtype, memory, gpu_chip);
    COMMIT;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
       WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные.');
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);  
END Add_GPU;


-- Процедура для добавления значений в таблицу, соответствующую типу товара RAM
CREATE OR REPLACE PROCEDURE Add_RAM(
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    memtype IN RAM.memtype%TYPE,
    memory IN RAM.memory%TYPE,
    freq IN RAM.freq%TYPE
)
IS
    part_id NUMBER;
BEGIN
    Add_Part(p_model, manufacturer, price, p_count, p_description, 'RAM');
    SELECT part_id INTO part_id FROM parts WHERE p_model = p_model AND type = 'RAM';
    INSERT INTO RAM (part_id, memtype, memory, freq)
    VALUES (part_id, memtype, memory, freq);
    COMMIT;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
       WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные.');
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);  
END Add_RAM;
/

-- Процедура для добавления значений в таблицу, соответствующую типу товара Storage
CREATE OR REPLACE PROCEDURE Add_Storage(
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    interface IN Storage.interface%TYPE,
    memory IN Storage.memory%TYPE,
    memtype IN Storage.memtype%TYPE
)
IS
    part_id NUMBER;
BEGIN
    Add_Part(p_model, manufacturer, price, p_count, p_description, 'Storage');
    SELECT part_id INTO part_id FROM parts WHERE p_model = p_model AND type = 'Storage';
    INSERT INTO Storage (part_id, interface, memory, memtype)
    VALUES (part_id, interface, memory, memtype);
    COMMIT;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
       WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные.');
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);  
END Add_Storage;


-- Процедура для добавления значений в таблицу, соответствующую типу товара Mboard
CREATE OR REPLACE PROCEDURE Add_Mboard(
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    socket IN Mboard.socket%TYPE,
    chipset IN Mboard.chipset%TYPE,
    memtype IN Mboard.memtype%TYPE
)
IS
    part_id NUMBER;
BEGIN
    Add_Part(p_model, manufacturer, price, p_count, p_description, 'Mboard');
    SELECT part_id INTO part_id FROM parts WHERE p_model = p_model AND type = 'Mboard';
    INSERT INTO Mboard (part_id, socket, chipset, memtype)
    VALUES (part_id, socket, chipset, memtype);
    COMMIT;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
       WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные.');
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);  
END Add_Mboard;


-- Процедура для добавления значений в таблицу parts для типа товара "other"
CREATE OR REPLACE PROCEDURE Add_Other_Part(
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE
)
IS
BEGIN
    Add_Part(p_model, manufacturer, price, p_count, p_description, 'other');
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      rollback;
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
       WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные.');
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);    
END Add_Other_Part;

select * from orders;
dbms_output.put_line(sysdate+1);
select CURRENT_DATE from dual;

CREATE OR REPLACE procedure make_order ( 
p_email in adress.email%TYPE,p_pass in customers.password%TYPE, p_adress in adress.adress_id%TYPE, 
ord_date in date
)
is 
rcount int;
tommorow date;
begin 
tommorow := sysdate+1;
select count(*) into rcount from customers where email=p_email and password=p_pass;
if ord_date>=tommorow then 
IF rcount = 1 THEN
      insert into orders values(null, p_email,p_adress,ord_date,0);
      dbms_output.put_line('ок');
       ELSE
      dbms_output.put_line('проверьте пароль или почту');
    END IF;
    else
    dbms_output.put_line('нельзя заказывать на эту дату'); end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');
       WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);    
end;
select * from parts;
CREATE OR REPLACE procedure fill_order ( 
p_order_id in order_elems.order_id%TYPE,p_part_id in order_elems.part_id%TYPE , pa_count in order_elems.order_id%TYPE)
is
counter int;
trg int;
begin 
select p_count into counter from parts where part_id = p_part_id ;
select p_status into trg from parts where part_id = p_part_id ;

if pa_count >0 and counter>pa_count-1 and trg =0 then 
insert into order_elems values(p_order_id,p_part_id,pa_count);
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


CREATE OR REPLACE procedure cut_order ( 
p_order_id in order_elems.order_id%TYPE)
is 
begin 

delete order_elems where order_id = p_order_id;
EXCEPTION
     WHEN OTHERS THEN
       dbms_output.put_line('ошибка '||sqlcode);
end;

select * from orders;
CREATE OR REPLACE procedure finish_order ( 
p_order_id in orders.order_id%TYPE
)
is 

begin 
update orders set ord_status = 1 where p_order_id = order_id;
EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ошибка '||sqlcode);   
end;

CREATE OR REPLACE procedure unfinish_order ( 
p_order_id in orders.order_id%TYPE
)
is 

begin 
update orders set ord_status = 0 where p_order_id = order_id;
EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ошибка '||sqlcode);    
end;

CREATE OR REPLACE procedure edit_part_count ( 
p_part_id in parts.part_id%TYPE,part_count in parts.p_count%TYPE
)
is 

begin 
update parts set p_count = part_count where part_id=p_part_id;
EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ошибка '||sqlcode);    
end;

