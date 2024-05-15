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
  -- Загружаем XML документ
  v_xml := XMLType(xml_text);

  -- Вставляем данные из XML в таблицу adress
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
      -- Обработка ошибок значений, например, неверных типов данных
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Ошибка в значениях данных.');

    WHEN NO_DATA_FOUND THEN
      -- Обработка ошибок отсутствия данных
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Не удалось найти необходимые данные в XML.');

    WHEN DUP_VAL_ON_INDEX THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Нарушение уникального ограничения. Дублирующиеся значения.');

    WHEN OTHERS THEN
      -- Обработка других исключений
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Произошла ошибка во время выполнения операции.');
  END;

END;



select * from adress