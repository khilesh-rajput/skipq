USE skipq;
INSERT INTO canteens(name,location,opening_time,closing_time) VALUES('College Canteen 1','Main academic block','08:00','20:00'),('College Canteen 2','Library courtyard','08:30','19:00'),('Hostel Canteen','Hostel common area','07:00','23:00');
INSERT INTO categories(name) VALUES('Snacks'),('Meals'),('Beverages');
INSERT INTO menu_items(canteen_id,category_id,name,description,price,preparation_minutes,stock_quantity,is_vegetarian) VALUES
(1,1,'Samosa','Crispy potato pastry',20,5,80,TRUE),(1,1,'Poha','Flattened rice with peanuts',35,8,40,TRUE),(1,3,'Tea','Masala chai',15,3,100,TRUE),(1,3,'Coffee','Fresh filter coffee',25,4,60,TRUE),(1,1,'Vada Pav','Mumbai style potato fritter bun',30,6,50,TRUE),(1,2,'Veg Sandwich','Grilled vegetable sandwich',55,8,25,TRUE),
(2,1,'Samosa','Crispy potato pastry',22,5,60,TRUE),(2,1,'Poha','Flattened rice with peanuts',38,8,35,TRUE),(2,3,'Tea','Masala chai',15,3,90,TRUE),(2,2,'Veg Thali','Rice, dal, vegetables and roti',90,15,30,TRUE),
(3,1,'Vada Pav','Mumbai style potato fritter bun',28,6,70,TRUE),(3,3,'Coffee','Fresh filter coffee',25,4,50,TRUE),(3,2,'Hostel Meal','Rice, dal, seasonal vegetables',75,15,50,TRUE),(3,1,'Paneer Sandwich','Grilled paneer sandwich',65,10,20,TRUE);
-- Create available slots for the next 7 days at each canteen using local server time.
DELIMITER //
CREATE PROCEDURE seed_slots()
BEGIN
 DECLARE d INT DEFAULT 0; DECLARE c BIGINT; DECLARE tm TIME; DECLARE close_tm TIME; DECLARE interval_m INT;
 WHILE d<7 DO
  SET c=1;
  WHILE c<=3 DO
   SELECT opening_time,closing_time,slot_interval_minutes INTO tm,close_tm,interval_m FROM canteens WHERE canteen_id=c;
   WHILE tm<close_tm DO
    INSERT IGNORE INTO pickup_slots(canteen_id,slot_at,capacity_minutes) VALUES(c,TIMESTAMP(DATE_ADD(CURDATE(),INTERVAL d DAY),tm),120);
    SET tm=ADDTIME(tm,SEC_TO_TIME(interval_m*60));
   END WHILE;
   SET c=c+1;
  END WHILE;
  SET d=d+1;
 END WHILE;
END//
CALL seed_slots()//
DROP PROCEDURE seed_slots//
DELIMITER ;
-- For demos, register student accounts in the UI. To provision staff/admin, promote a user only via trusted SQL:
-- UPDATE users SET role='staff' WHERE email='staff@college.edu'; INSERT INTO staff_canteens(user_id,canteen_id) SELECT user_id,1 FROM users WHERE email='staff@college.edu';
-- UPDATE users SET role='admin' WHERE email='admin@college.edu';
