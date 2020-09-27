--1----Create a PL/SQL block which displays the list of customers (all the informations)

DECLARE
 CURSOR cur IS SELECT * FROM Customer;
BEGIN
 FOR rec IN cur LOOP
 dbms_output.put_line(rec.Customer_id ||' '||rec.customer_Name ' '||rec.customer_Tel);
 END LOOP;
END;

--2--Create a Procedure PS_Customer_Prodcuts which displays the list of product names of a given customer

CREATE OR REPLACE PROCEDURE PS_Customer_Prodcuts (v_cost_id Costumer.costumer_id%type) IS 
 CURSOR cur IS SELECT Product_name FROM Product WHERE Costumer_id=v_cost_id;
BEGIN
 FOR rec IN cur LOOP
 dbms_output.put_line("the name of product :"|| rec.Product_name);
 END LOOP;
 EXCEPTION 
 WHEN NO DATA FOUND THEN
 dbms_output.put_line('No products returned or customer not found');
END;

--3--Create a Function FN_Customer_Orders which returns the number of orders of a given customer (customer_id)

CREATE OR REPLACE FUNCTION FN_Customer_Orders (v_cost_id costumer.costumer_id%type) RETURN number IS
	nb_emp number;
BEGIN
	SELECT count(*) into nb_emp FROM orders WHERE costumer_id=v_cost_id;
	RETURN nb_emp;
END;

--4--Create a trigger TRIG_INS_ORDERS which starts before each INSERT on Orders tables 
--and test if the OrderDate >= SYSDATE. If not the following message
-- is displayed “Order Date must be greater than or equal to today's date

CREATE TRIG_INS_ORDERS
BEFORE INSERT ON Orders FOR EACH ROW
BEGIN
	IF ( :new.OrderDate >= SYSDATE ) THEN
    dbms_output.put_line("Order Date must be greater than or equal to today's date"); 
END IF ;
END;
