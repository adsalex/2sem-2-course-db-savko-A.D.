CREATE OR REPLACE PROCEDURE GenerateAddressXML IS
    xml_data CLOB;
BEGIN
    SELECT XMLELEMENT("Adress",
               XMLFOREST(adress_id AS "AddressID",
                         email AS "Email",
                         city AS "City",
                         street AS "Street",
                         house AS "House",
                         a_floor AS "Floor",
                         appartment AS "Apartment")
              ).getClobVal()
    INTO xml_data
    FROM adress;
    DBMS_OUTPUT.PUT_LINE(xml_data);
END;

--UpdateCourse
CREATE OR REPLACE Procedure import_xml
(xml_text in nvarchar2) is
  v_xml XMLType;
BEGIN
  -- ��������� XML ��������
  v_xml := XMLType(xml_text);

  -- ��������� ������ �� XML � ������� adress
  INSERT INTO adress (adress_id, email, city, street, house, a_floor, appartment)
  VALUES (null,
          v_xml.extract('/Address/Email/text()').getStringVal(),
          v_xml.extract('/Address/City/text()').getStringVal(),
          v_xml.extract('/Address/Street/text()').getStringVal(),
          v_xml.extract('/Address/House/text()').getStringVal(),
          v_xml.extract('/Address/Floor/text()').getNumberVal(),
          v_xml.extract('/Address/Apartment/text()').getNumberVal());

  COMMIT;
  EXCEPTION
    WHEN VALUE_ERROR THEN
      -- ��������� ������ ��������, ��������, �������� ����� ������
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('������ � ��������� ������.');

    WHEN NO_DATA_FOUND THEN
      -- ��������� ������ ���������� ������
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('�� ������� ����� ����������� ������ � XML.');

    WHEN DUP_VAL_ON_INDEX THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('��������� ����������� �����������. ������������� ��������.');

    WHEN OTHERS THEN
      -- ��������� ������ ����������
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('��������� ������ �� ����� ���������� ��������.');
  END;

END;



select * from adress