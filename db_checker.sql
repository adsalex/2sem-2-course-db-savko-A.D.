ALTER TABLE adress
ADD CONSTRAINT CHK_adress CHECK (a_floor>0 and appartment >0);

ALTER TABLE parts
add CONSTRAINT CHK_parts_all CHECK (price >0 and p_count >-1);

ALTER TABLE Order_elems
ADD CONSTRAINT CHK_ord_count CHECK (count>0);

ALTER TABLE cpu
add CONSTRAINT CHK_cpu CHECK (freq>0 and cores >0);

ALTER TABLE gpu
ADD CONSTRAINT CHK_gpu CHECK (memory>0);

ALTER TABLE ram
ADD CONSTRAINT CHK_ram CHECK (memory>0 and freq>0);

ALTER TABLE storage
ADD CONSTRAINT CHK_storage CHECK (memory>0);