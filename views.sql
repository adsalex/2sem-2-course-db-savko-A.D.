-- Представление для таблицы parts
CREATE OR REPLACE VIEW Parts_V AS
SELECT *
FROM parts;

CREATE OR REPLACE VIEW adress_xml_view AS
SELECT XMLELEMENT("Address",
           XMLFOREST(adress_id AS "AddressID",
                     email AS "Email",
                     city AS "City",
                     street AS "Street",
                     house AS "House",
                     a_floor AS "Floor",
                     appartment AS "Apartment")
          ).getClobVal() AS xml_data
FROM adress;

drop view adress_xml;

-- Представление для таблицы CPU
CREATE OR REPLACE VIEW CPU_V AS
SELECT P.part_id, P.p_model, P.manufacturer, P.price, P.p_count, P.p_description,
       C.freq, C.cores, C.arch, C.socket
FROM parts P
JOIN CPU C ON P.part_id = C.part_id;

-- Представление для таблицы GPU
CREATE OR REPLACE VIEW GPU_V AS
SELECT P.part_id, P.p_model, P.manufacturer, P.price, P.p_count, P.p_description,
       G.memtype, G.memory, G.gpu_chip
FROM parts P
JOIN GPU G ON P.part_id = G.part_id;

-- Представление для таблицы RAM
CREATE OR REPLACE VIEW RAM_V AS
SELECT P.part_id, P.p_model, P.manufacturer, P.price, P.p_count, P.p_description,
       R.memtype, R.memory, R.freq
FROM parts P
JOIN RAM R ON P.part_id = R.part_id;

-- Представление для таблицы Storage
CREATE OR REPLACE VIEW Storage_V AS
SELECT P.part_id, P.p_model, P.manufacturer, P.price, P.p_count, P.p_description,
       S.interface, S.memory, S.memtype
FROM parts P
JOIN Storage S ON P.part_id = S.part_id;

-- Представление для таблицы Mboard
CREATE OR REPLACE VIEW Mboard_V AS
SELECT P.part_id, P.p_model, P.manufacturer, P.price, P.p_count, P.p_description,
       M.socket, M.chipset, M.memtype
FROM parts P
JOIN Mboard M ON P.part_id = M.part_id;

CREATE OR REPLACE VIEW adress_V AS
SELECT *
FROM adress;

CREATE OR REPLACE VIEW orders_V AS
SELECT *
FROM orders;

CREATE OR REPLACE VIEW orders_in_elems_V AS
SELECT ord.order_id,email,adress_id,elem.part_id,ord_date,ord_status,count
FROM orders ord join order_elems elem
on ord.order_id = elem.order_id
;

CREATE OR REPLACE VIEW usermails AS
SELECT email from customers;

select * from orders;

select * from order_elems;
grant select on Parts_V to customer;
grant select on CPU_V to customer;
grant select on GPU_V to customer;
grant select on RAM_V to customer;
grant select on Mboard_V to customer;
grant select on Storage_V to customer;