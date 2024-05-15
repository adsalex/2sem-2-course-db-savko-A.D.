CREATE OR REPLACE PROCEDURE Update_Mboard(
    part_id IN parts.part_id%TYPE,
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    p_status IN parts.p_status%TYPE,
    socket IN Mboard.socket%TYPE,
    chipset IN Mboard.chipset%TYPE,
    memtype IN Mboard.memtype%TYPE
)
IS
    type_var parts.type%TYPE;
BEGIN
    -- Изменение типа товара и обновление данных
    UPDATE parts
    SET p_model = p_model,
        manufacturer = manufacturer,
        price = price,
        p_count = p_count,
        p_description = p_description,
        p_status = p_status
    WHERE part_id = part_id;
    
    
    
     SELECT type INTO type_var FROM parts WHERE part_id = part_id;
    IF type_var = 'Mboard' THEN
        UPDATE Mboard
        SET socket = socket,
            chipset = chipset,
            memtype = memtype
        WHERE part_id = part_id;
        Else
         Delete_Added_data(part_id);
         INSERT  INTO Mboard  values(part_id, socket, chipset, memtype);
        
        UPDATE parts
        set parts.type='Mboard';
    END IF;
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
END Update_Mboard;

CREATE OR REPLACE PROCEDURE Delete_Added_data(
    part_id IN parts.part_id%TYPE
)
IS
    type_var parts.type%TYPE;
BEGIN
    -- Получение типа товара по part_id
    SELECT type INTO type_var FROM parts WHERE part_id = part_id;
    
    -- Удаление данных в зависимости от типа товара
    CASE type_var
        WHEN 'CPU' THEN
            DELETE FROM CPU WHERE part_id = part_id;
        WHEN 'GPU' THEN
            DELETE FROM GPU WHERE part_id = part_id;
        WHEN 'RAM' THEN
            DELETE FROM RAM WHERE part_id = part_id;
        WHEN 'Storage' THEN
            DELETE FROM Storage WHERE part_id = part_id;
        WHEN 'Mboard' THEN
            DELETE FROM Mboard WHERE part_id = part_id;
    END CASE;
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
    COMMIT;
END Delete_Added_data;

create or replace procedure delete_part(
part_id IN parts.part_id%TYPE)
is
begin
--Delete_Added_data (part_id);
update parts set p_status=1 where parts.part_id = part_id;
EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('ошибка'||sqlcode);
end delete_part;

create or replace procedure return_part(
part_id IN parts.part_id%TYPE)
is
begin
update parts set p_status=0 where parts.part_id = part_id;
end return_part;
select * from user_procedures;
select * from user_tables;
-- Процедура для обновления данных товара типа CPU
CREATE OR REPLACE PROCEDURE Update_CPU(
    part_id IN parts.part_id%TYPE,
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    p_status IN parts.p_status%TYPE,
    freq IN CPU.freq%TYPE,
    cores IN CPU.cores%TYPE,
    arch IN CPU.arch%TYPE,
    socket IN CPU.socket%TYPE
)
IS
    type_var parts.type%TYPE;
BEGIN
    -- Получение типа товара по part_id
    SELECT type INTO type_var FROM parts WHERE part_id = part_id;
    
    -- Обновление данных в соответствующей таблице и типе товара
    IF type_var = 'CPU' THEN
        UPDATE CPU
        SET freq = freq,
            cores = cores,
            arch = arch,
            socket = socket
        WHERE part_id = part_id;
    ELSE
        -- Вставка данных в таблицу CPU
        INSERT INTO CPU (part_id, freq, cores, arch, socket)
        VALUES (part_id, freq, cores, arch, socket);
        
        -- Обновление типа товара в таблице parts
        UPDATE parts
        SET type = 'CPU'
        WHERE part_id = part_id;
    END IF;
    
    -- Обновление общих данных товара в таблице parts
    UPDATE parts
    SET p_model = p_model,
        manufacturer = manufacturer,
        price = price,
        p_count = p_count,
        p_description = p_description,
        p_status = p_status
    WHERE part_id = part_id;
    
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
END Update_CPU;



-- Процедура для обновления данных товара типа GPU
CREATE OR REPLACE PROCEDURE Update_GPU(
    part_id IN parts.part_id%TYPE,
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    p_status IN parts.p_status%TYPE,
    memtype IN GPU.memtype%TYPE,
    memory IN GPU.memory%TYPE,
    gpu_chip IN GPU.gpu_chip%TYPE
)
IS
    type_var parts.type%TYPE;
BEGIN
    -- Получение типа товара по part_id
    SELECT type INTO type_var FROM parts WHERE part_id = part_id;
    
    -- Обновление данных в соответствующей таблице и типе товара
    IF type_var = 'GPU' THEN
        UPDATE GPU
        SET memtype = memtype,
            memory = memory,
            gpu_chip = gpu_chip
        WHERE part_id = part_id;
    ELSE
        -- Вставка данных в таблицу GPU
        INSERT INTO GPU (part_id, memtype, memory, gpu_chip)
        VALUES (part_id, memtype, memory, gpu_chip);
        
        -- Обновление типа товара в таблице parts
        UPDATE parts
        SET type = 'GPU'
        WHERE part_id = part_id;
    END IF;
    
    -- Обновление общих данных товара в таблице parts
    UPDATE parts
    SET p_model = p_model,
        manufacturer = manufacturer,
        price = price,
        p_count = p_count,
        p_description = p_description,
        p_status = p_status
    WHERE part_id = part_id;
    
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
END Update_GPU;


-- Процедура для обновления данных товара типа RAM
CREATE OR REPLACE PROCEDURE Update_RAM(
    part_id IN parts.part_id%TYPE,
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    p_status IN parts.p_status%TYPE,
    memtype IN RAM.memtype%TYPE,
    memory IN RAM.memory%TYPE,
    freq IN RAM.freq%TYPE
)
IS
    type_var parts.type%TYPE;
BEGIN
    -- Получение типа товара по part_id
    SELECT type INTO type_var FROM parts WHERE part_id = part_id;
    
    -- Обновление данных в соответствующей таблице и типе товара
    IF type_var = 'RAM' THEN
        UPDATE RAM
        SET memtype = memtype,
            memory = memory,
            freq = freq
        WHERE part_id = part_id;
    ELSE
        -- Вставка данных в таблицу RAM
        INSERT INTO RAM (part_id, memtype, memory, freq)
        VALUES (part_id, memtype, memory, freq);
        
        -- Обновление типа товара в таблице parts
        UPDATE parts
        SET type = 'RAM'
        WHERE part_id = part_id;
    END IF;
    
    -- Обновление общих данных товара в таблице parts
    UPDATE parts
    SET p_model = p_model,
        manufacturer = manufacturer,
        price = price,
        p_count = p_count,
        p_description = p_description,
        p_status = p_status
    WHERE part_id = part_id;
    
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
END Update_RAM;


-- Процедура для обновления данных товара типа Storage
CREATE OR REPLACE PROCEDURE Update_Storage(
    part_id IN parts.part_id%TYPE,
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    p_status IN parts.p_status%TYPE,
    interface IN Storage.interface%TYPE,
    memory IN Storage.memory%TYPE,
    memtype IN Storage.memtype%TYPE
)
IS
    type_var parts.type%TYPE;
BEGIN
    -- Получение типа товара по part_id
    SELECT type INTO type_var FROM parts WHERE part_id = part_id;
    
    -- Обновление данных в соответствующей таблице и типе товара
    IF type_var = 'Storage' THEN
        UPDATE Storage
        SET interface = interface,
            memory = memory,
            memtype = memtype
        WHERE part_id = part_id;
    ELSE
        -- Вставка данных в таблицу Storage
        INSERT INTO Storage (part_id, interface, memory, memtype)
        VALUES (part_id, interface, memory, memtype);
        
        -- Обновление типа товара в таблице parts
        UPDATE parts
        SET type = 'Storage'
        WHERE part_id = part_id;
    END IF;
    
    -- Обновление общих данных товара в таблице parts
    UPDATE parts
    SET p_model = p_model,
        manufacturer = manufacturer,
        price = price,
        p_count = p_count,
        p_description = p_description,
        p_status = p_status
    WHERE part_id = part_id;
    
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
END Update_Storage;

CREATE OR REPLACE PROCEDURE Update_Other(
    part_id IN parts.part_id%TYPE,
    p_model IN parts.p_model%TYPE,
    manufacturer IN parts.manufacturer%TYPE,
    price IN parts.price%TYPE,
    p_count IN parts.p_count%TYPE,
    p_description IN parts.p_description%TYPE,
    p_status IN parts.p_status%TYPE,
    socket IN Mboard.socket%TYPE,
    chipset IN Mboard.chipset%TYPE,
    memtype IN Mboard.memtype%TYPE
)
IS
    type_var parts.type%TYPE;
BEGIN
    -- Изменение типа товара и обновление данных
     SELECT type INTO type_var FROM parts WHERE part_id = part_id;
    IF type_var = 'other' THEN
        UPDATE Mboard
        SET socket = socket,
            chipset = chipset,
            memtype = memtype
        WHERE part_id = part_id;
        Else
            INSERT  INTO Mboard  values(part_id, socket, chipset, memtype);
        UPDATE parts
        set parts.type='Mboard';
    END IF;
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
END Update_Other;

----ыаы
CREATE or replace FUNCTION count_money(order_id VARCHAR) RETURN NUMBER IS
    total_cost NUMBER;
BEGIN
    BEGIN
        SELECT SUM(count * (select price from parts where part_id=oe.part_id)) INTO total_cost
        FROM order_elems oe;
        
        IF total_cost IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'Ничего не найдено');
        END IF;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Ничего не найдено');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'Ошибка'||sqlcode);
    END;

    RETURN total_cost;
END; 