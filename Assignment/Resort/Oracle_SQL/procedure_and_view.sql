CREATE VIEW statisticCustomer AS
SELECT  EXTRACT(YEAR FROM timebooking) AS YEAR_V,
        EXTRACT(MONTH FROM timebooking) AS MONTH_V,
        Count (NoCustumer) As Number_of_Customer
FROM Booking
WHERE situation = 1
GROUP BY     EXTRACT(YEAR FROM timebooking),  EXTRACT(MONTH FROM timebooking)
ORDER BY    EXTRACT(YEAR FROM timebooking),  EXTRACT(MONTH FROM timebooking);

SELECT * FROM statisticCustomer;
CREATE OR REPLACE PROCEDURE ThongKeLuotKhac (yearsatistic NUMBER)
IS q SYS_REFCURSOR;
BEGIN 
     OPEN q FOR SELECT Month_V, Number_of_Customer
     FROM statisticCustomer
     WHERE  yearsatistic= statisticCustomer.YEAR_V;
     DBMS_SQL.return_result (q);
END;
EXECUTE ThongKeLuotKhac (2021);