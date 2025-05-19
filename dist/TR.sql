DELIMITER $$
	DROP TRIGGER IF EXISTS after_insert_lines;
	CREATE TRIGGER after_insert_lines
    AFTER INSERT ON hopi_hari_db.lines
    FOR EACH ROW
	BEGIN
        DECLARE wait_time INT;
        DECLARE line_count INT;
        DECLARE total_wait INT;
        
        SELECT waiting_time INTO wait_time
			FROM rides
		WHERE id = NEW.rides_id;
        
        SELECT COUNT(users_id) INTO line_count
			FROM hopi_hari_db.lines
		WHERE rides_id = NEW.rides_id;
        
        SET total_wait = wait_time * line_count;
        
        INSERT INTO notifications (description, rides_id, users_id, status)
		VALUES (concat(total_wait_time, " minutos de espera para o brinquedo "),8,5,TRUE);
END $$
DELIMITER ;
