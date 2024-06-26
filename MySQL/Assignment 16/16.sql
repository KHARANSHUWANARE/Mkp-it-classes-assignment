/*
1. **Inventory Stock Alert**:
   - **Problem Statement**: Whenever a new rental is created, check the inventory quantity for the rented film. If the quantity falls below a certain threshold (e.g., 5 copies), log a warning message in a `low_stock_alerts` table.
*/

DELIMITER $$
CREATE TRIGGER rental_insert_trigger AFTER INSERT ON rentals FOR EACH ROW
BEGIN
  DECLARE film_id INT;
  DECLARE film_quantity INT;

  SET film_id = NEW.film_id;

  SELECT quantity INTO film_quantity FROM inventory WHERE film_id = old.film_id;

  IF film_quantity < 5 THEN
    INSERT INTO low_stock_alerts (film_id, alerttimestamp) VALUES (film_id, NOW());
  END IF;
END $$
DELIMITER ;


/*
2. **Prevent Deletion of Active Customers**:
   - **Problem Statement**: Prevent the deletion of a customer who has any active rentals.
   - **Trigger Description**: Create a `BEFORE DELETE` trigger on the `customer` table that checks for active rentals. If active rentals exist, raise an error and prevent the deletion.
*/
DELIMITER //

CREATE TRIGGER prevent_customer_delete
BEFORE DELETE ON customer
FOR EACH ROW
BEGIN
  DECLARE has_rentals INT;

  SELECT COUNT(*) INTO has_rentals
  FROM rental r
  WHERE r.customer_id = OLD.customer_id 
  AND r.return_date IS NULL;

  IF has_rentals > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer deletion denied! Active rentals exist.';
  END IF;
END;
//

DELIMITER ;

/*
3. **Update Last Updated Timestamp**:
   - **Problem Statement**: Automatically update the `last_update` timestamp column in the `film` table whenever a film's details are modified.
   - **Trigger Description**: Create a `BEFORE UPDATE` trigger on the `film` table that sets the `last_update` column to the current timestamp.
*/
DELIMITER $$
CREATE TRIGGER film_update_trigger BEFORE UPDATE ON film FOR EACH ROW
BEGIN
  SET NEW.last_update = NOW(); 
END $$
DELIMITER ;
/*
4. **Log Film Deletion**:
   - **Problem Statement**: Log details of any film deletions into a `deleted_films_log` table for auditing purposes.
   - **Trigger Description**: Create an `AFTER DELETE` trigger on the `film` table that inserts the deleted film's details into the `deleted_films_log` table.
*/

Create table deleted_films_log(
	film_id INTEGER,
	title VARCHAR(255),
	release_year VARCHAR (5)
)
select * from sakila.deleted_films_log;

DELIMITER //

CREATE TRIGGER Log_Film_Deletion
BEFORE DELETE ON film
FOR EACH ROW
BEGIN
	INSERT into deleted_films_log(film_id ,title ,release_year) 
    VALUE(OLD.film_id,OLD.title,old.release_year);
END;
//

DELIMITER ;

DELETE from film 
where film_id=1;


/*
5. **Ensure Valid Rental Dates**:
   - **Problem Statement**: Ensure that the `return_date` in the `rental` table is always after the `rental_date`.
   - **Trigger Description**: Create a `BEFORE INSERT` or `BEFORE UPDATE` trigger on the `rental` table that checks if the `return_date` is after the `rental_date`. If not, raise an error to prevent the insert or update.
*/

DELIMITER $$
CREATE TRIGGER rental_date_validation_trigger BEFORE INSERT OR UPDATE ON rental FOR EACH ROW
BEGIN
  DECLARE is_valid_date BOOLEAN DEFAULT FALSE;

  SET is_valid_date = NEW.return_date > NEW.rental_date;  

  IF NOT is_valid_date THEN  
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Return date must be after rental date.';
  END IF;
END $$
DELIMITER ;
