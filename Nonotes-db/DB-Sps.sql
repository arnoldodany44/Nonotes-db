-- -- Nonotes Sored procedures v1.0.0
-- -- Date: 2024-09-01

--
-- Procedure structure for `sp_create_note`
--
DROP PROCEDURE IF EXISTS sp_create_note;
DELIMITER //
CREATE PROCEDURE sp_create_note(
    IN p_uuid VARCHAR(60),
    IN p_title VARCHAR(30),
    IN p_subtitle VARCHAR(50),
    IN p_description VARCHAR(200),
    IN p_status SMALLINT,
    IN p_image VARCHAR(200),
    IN p_code VARCHAR(10),
    IN p_starts_at DATETIME,
    IN p_ends_at DATETIME
)
BEGIN
    DECLARE code_result INT DEFAULT 400;
    DECLARE message_result VARCHAR(200) DEFAULT 'Bad Request';
    DECLARE inserted_id INT;
    DECLARE transaction_result BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET transaction_result = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sql_state = RETURNED_SQLSTATE, @mysql_errno = MYSQL_ERRNO, @error_message = MESSAGE_TEXT;
        SET message_result = CONCAT('Error crítico al crear la nota, notificar al departamento de desarrollo. ', @sql_state, ' - ', @mysql_errno, ' - ', @error_message);
        SELECT code_result, message_result;
        ROLLBACK;
    END;
    START TRANSACTION;
    INSERT INTO Notes (uuid, title, subtitle, description, status, image, code, starts_at, ends_at, created_at)
    VALUES (p_uuid, p_title, p_subtitle, p_description, p_status, p_image, p_code, p_starts_at, p_ends_at, NOW());

    SET code_result = 201;
    SET message_result = 'Nota creada correctamente';
    SET inserted_id = LAST_INSERT_ID();
    SELECT code_result, message_result, inserted_id;
    COMMIT;
END //
DELIMITER ;

--
-- Procedure structure for `sp_create_user`
--
DROP PROCEDURE IF EXISTS sp_create_user;
DELIMITER //
CREATE PROCEDURE sp_create_user(
    IN p_uuid VARCHAR(60),
    IN p_name VARCHAR(30),
    IN p_last_name VARCHAR(30),
    IN p_username VARCHAR(20),
    IN p_email VARCHAR(30),
    IN p_password VARCHAR(100),
    IN p_status SMALLINT
)
BEGIN
    DECLARE code_result INT DEFAULT 400;
    DECLARE message_result VARCHAR(200) DEFAULT 'Bad Request';
    DECLARE inserted_id INT;
    DECLARE transaction_result BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET transaction_result = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sql_state = RETURNED_SQLSTATE, @mysql_errno = MYSQL_ERRNO, @error_message = MESSAGE_TEXT;
        SET message_result = CONCAT('Error crítico al crear el usuario, notificar al departamento de desarrollo. ', @sql_state, ' - ', @mysql_errno, ' - ', @error_message);
        SELECT code_result, message_result;
        ROLLBACK;
    END;
    START TRANSACTION;
    INSERT INTO Users (uuid, name, last_name, username, email, password, status, created_at)
    VALUES (p_uuid, p_name, p_last_name, p_username, p_email, p_password, p_status, NOW());

    SET code_result = 201;
    SET message_result = 'Usuario creado correctamente';
    SET inserted_id = LAST_INSERT_ID();
    SELECT code_result, message_result, inserted_id;
    COMMIT;
END //
DELIMITER ;

--
-- Procedure structure for `sp_create_user_note`
--
DROP PROCEDURE IF EXISTS sp_create_user_note;
DELIMITER //
CREATE PROCEDURE sp_create_user_note(
    IN p_user_id INT,
    IN p_note_id INT
)
BEGIN
    DECLARE code_result INT DEFAULT 400;
    DECLARE message_result VARCHAR(200) DEFAULT 'Bad Request';
    DECLARE transaction_result BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET transaction_result = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sql_state = RETURNED_SQLSTATE, @mysql_errno = MYSQL_ERRNO, @error_message = MESSAGE_TEXT;
        SET message_result = CONCAT('Error crítico al asignar la nota al usuario, notificar al departamento de desarrollo. ', @sql_state, ' - ', @mysql_errno, ' - ', @error_message);
        SELECT code_result, message_result;
        ROLLBACK;
    END;
    START TRANSACTION;
    INSERT INTO UserNotes (user_id, note_id, created_at)
    VALUES (p_user_id, p_note_id, NOW());

    SET code_result = 201;
    SET message_result = 'Nota asignada correctamente';
    SELECT code_result, message_result;
    COMMIT;
END //
DELIMITER ;

--
-- Procedure structure for `sp_create_user_session`
--
DROP PROCEDURE IF EXISTS sp_create_user_session;
DELIMITER //
CREATE PROCEDURE sp_create_user_session(
    IN p_uuid VARCHAR(60),
    IN p_user_id SMALLINT,
    IN p_login_at DATETIME,
    IN p_logout_at DATETIME,
    IN p_device VARCHAR(40),
    IN p_in_use SMALLINT
)
BEGIN
    DECLARE code_result INT DEFAULT 400;
    DECLARE message_result VARCHAR(200) DEFAULT 'Bad Request';
    DECLARE inserted_id INT;
    DECLARE transaction_result BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET transaction_result = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sql_state = RETURNED_SQLSTATE, @mysql_errno = MYSQL_ERRNO, @error_message = MESSAGE_TEXT;
        SET message_result = CONCAT('Error crítico al crear la sesión del usuario, notificar al departamento de desarrollo. ', @sql_state, ' - ', @mysql_errno, ' - ', @error_message);
        SELECT code_result, message_result;
        ROLLBACK;
    END;
    START TRANSACTION;
    INSERT INTO UserSessions (uuid, user_id, login_at, logout_at, device, in_use, created_at)
    VALUES (p_uuid, p_user_id, p_login_at, p_logout_at, p_device, p_in_use, NOW());

    SET code_result = 201;
    SET message_result = 'Sesión creada correctamente';
    SET inserted_id = LAST_INSERT_ID();
    SELECT code_result, message_result, inserted_id;
    COMMIT;
END //
DELIMITER ;

--
-- Procedure structure for `sp_delete_note`
--
DROP PROCEDURE IF EXISTS sp_delete_note;
DELIMITER //
CREATE PROCEDURE sp_delete_note(
    IN p_id INT
)
BEGIN
    DECLARE code_result INT DEFAULT 400;
    DECLARE message_result VARCHAR(200) DEFAULT 'Bad Request';
    DECLARE transaction_result BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET transaction_result = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sql_state = RETURNED_SQLSTATE, @mysql_errno = MYSQL_ERRNO, @error_message = MESSAGE_TEXT;
        SET message_result = CONCAT('Error crítico al eliminar la nota, notificar al departamento de desarrollo. ', @sql_state, ' - ', @mysql_errno, ' - ', @error_message);
        SELECT code_result, message_result;
        ROLLBACK;
    END;
    START TRANSACTION;
    UPDATE Notes
    SET deleted_at = NOW()
    WHERE id = p_id;

    SET code_result = 200;
    SET message_result = 'Nota eliminada correctamente';
    SELECT code_result, message_result;
    COMMIT;
END //
DELIMITER ;

--
-- Procedure structure for `sp_delete_user`
--
DROP PROCEDURE IF EXISTS sp_delete_user;
DELIMITER //
CREATE PROCEDURE sp_delete_user(
    IN p_id INT
)
BEGIN
    DECLARE code_result INT DEFAULT 400;
    DECLARE message_result VARCHAR(200) DEFAULT 'Bad Request';
    DECLARE transaction_result BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET transaction_result = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sql_state = RETURNED_SQLSTATE, @mysql_errno = MYSQL_ERRNO, @error_message = MESSAGE_TEXT;
        SET message_result = CONCAT('Error crítico al eliminar el usuario, notificar al departamento de desarrollo. ', @sql_state, ' - ', @mysql_errno, ' - ', @error_message);
        SELECT code_result, message_result;
        ROLLBACK;
    END;
    START TRANSACTION;
    UPDATE Users
    SET deleted_at = NOW()
    WHERE id = p_id;

    SET code_result = 200;
    SET message_result = 'Usuario eliminado correctamente';
    SELECT code_result, message_result;
    COMMIT;
END //
DELIMITER ;

--
-- Procedure structure for `sp_delete_user_note`
--
DROP PROCEDURE IF EXISTS sp_delete_user_note;
DELIMITER //
CREATE PROCEDURE sp_delete_user_note(
    IN p_user_id INT,
    IN p_note_id INT
)
BEGIN
    DECLARE code_result INT DEFAULT 400;
    DECLARE message_result VARCHAR(200) DEFAULT 'Bad Request';
    DECLARE transaction_result BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET transaction_result = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sql_state = RETURNED_SQLSTATE, @mysql_errno = MYSQL_ERRNO, @error_message = MESSAGE_TEXT;
        SET message_result = CONCAT('Error crítico al desasignar la nota al usuario, notificar al departamento de desarrollo. ', @sql_state, ' - ', @mysql_errno, ' - ', @error_message);
        SELECT code_result, message_result;
        ROLLBACK;
    END;
    START TRANSACTION;
    UPDATE UserNotes
    SET deleted_at = NOW()
    WHERE user_id = p_user_id AND note_id = p_note_id;

    SET code_result = 200;
    SET message_result = 'Nota desasignada correctamente';
    SELECT code_result, message_result;
    COMMIT;
END //
DELIMITER ;

--
-- Procedure structure for `sp_delete_user_session`
--
DROP PROCEDURE IF EXISTS sp_delete_user_session;
DELIMITER //
CREATE PROCEDURE sp_delete_user_session(
    IN p_id INT
)
BEGIN
    DECLARE code_result INT DEFAULT 400;
    DECLARE message_result VARCHAR(200) DEFAULT 'Bad Request';
    DECLARE transaction_result BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET transaction_result = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sql_state = RETURNED_SQLSTATE, @mysql_errno = MYSQL_ERRNO, @error_message = MESSAGE_TEXT;
        SET message_result = CONCAT('Error crítico al eliminar la sesión del usuario, notificar al departamento de desarrollo. ', @sql_state, ' - ', @mysql_errno, ' - ', @error_message);
        SELECT code_result, message_result;
        ROLLBACK;
    END;
    START TRANSACTION;
    UPDATE UserSessions
    SET deleted_at = NOW()
    WHERE id = p_id;

    SET code_result = 200;
    SET message_result = 'Sesión eliminada correctamente';
    SELECT code_result, message_result;
    COMMIT;
END //
DELIMITER ;

--
-- Procedure structure for `sp_delete_notes_by_user`
--
DROP PROCEDURE IF EXISTS sp_delete_notes_by_user;
DELIMITER //
CREATE PROCEDURE sp_delete_notes_by_user(
    IN p_user_id INT
)
BEGIN
    DECLARE code_result INT DEFAULT 400;
    DECLARE message_result VARCHAR(200) DEFAULT 'Bad Request';
    DECLARE transaction_result BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET transaction_result = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sql_state = RETURNED_SQLSTATE, @mysql_errno = MYSQL_ERRNO, @error_message = MESSAGE_TEXT;
        SET message_result = CONCAT('Error crítico al eliminar las notas del usuario, notificar al departamento de desarrollo. ', @sql_state, ' - ', @mysql_errno, ' - ', @error_message);
        SELECT code_result, message_result;
        ROLLBACK;
    END;
    START TRANSACTION;
    UPDATE UserNotes
    SET deleted_at = NOW()
    WHERE user_id = p_user_id;

    SET code_result = 200;
    SET message_result = 'Notas eliminadas correctamente';
    SELECT code_result, message_result;
    COMMIT;
END //
DELIMITER ;

--
-- Procedure structure for `sp_update_note`
--
DROP PROCEDURE IF EXISTS sp_update_note;
DELIMITER //
CREATE PROCEDURE sp_update_note(
    IN p_id INT,
    IN p_title VARCHAR(30),
    IN p_subtitle VARCHAR(50),
    IN p_description VARCHAR(200),
    IN p_status SMALLINT,
    IN p_image VARCHAR(200),
    IN p_code VARCHAR(10),
    IN p_starts_at DATETIME,
    IN p_ends_at DATETIME
)
BEGIN
    DECLARE code_result INT DEFAULT 400;
    DECLARE message_result VARCHAR(200) DEFAULT 'Bad Request';
    DECLARE transaction_result BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET transaction_result = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sql_state = RETURNED_SQLSTATE, @mysql_errno = MYSQL_ERRNO, @error_message = MESSAGE_TEXT;
        SET message_result = CONCAT('Error crítico al actualizar la nota, notificar al departamento de desarrollo. ', @sql_state, ' - ', @mysql_errno, ' - ', @error_message);
        SELECT code_result, message_result;
        ROLLBACK;
    END;
    START TRANSACTION;
    UPDATE Notes
    SET title = p_title,
        subtitle = p_subtitle,
        description = p_description,
        status = p_status,
        image = p_image,
        code = p_code,
        starts_at = p_starts_at,
        ends_at = p_ends_at,
        updated_at = NOW()
    WHERE id = p_id;

    SET code_result = 200;
    SET message_result = 'Nota actualizada correctamente';
    SELECT code_result, message_result;
    COMMIT;
END //
DELIMITER ;

--
-- Procedure structure for `sp_update_user`
--
DROP PROCEDURE IF EXISTS sp_update_user;
DELIMITER //
CREATE PROCEDURE sp_update_user(
    IN p_id INT,
    IN p_name VARCHAR(30),
    IN p_last_name VARCHAR(30),
    IN p_username VARCHAR(20),
    IN p_email VARCHAR(30),
    IN p_password VARCHAR(100),
    IN p_status SMALLINT
)
BEGIN
    DECLARE code_result INT DEFAULT 400;
    DECLARE message_result VARCHAR(200) DEFAULT 'Bad Request';
    DECLARE transaction_result BOOLEAN DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET transaction_result = TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION, SQLWARNING BEGIN
        GET DIAGNOSTICS CONDITION 1
            @sql_state = RETURNED_SQLSTATE, @mysql_errno = MYSQL_ERRNO, @error_message = MESSAGE_TEXT;
        SET message_result = CONCAT('Error crítico al actualizar el usuario, notificar al departamento de desarrollo. ', @sql_state, ' - ', @mysql_errno, ' - ', @error_message);
        SELECT code_result, message_result;
        ROLLBACK;
    END;
    START TRANSACTION;
    UPDATE Users
    SET name = p_name,
        last_name = p_last_name,
        username = p_username,
        email = p_email,
        password = p_password,
        status = p_status,
        updated_at = NOW()
    WHERE id = p_id;

    SET code_result = 200;
    SET message_result = 'Usuario actualizado correctamente';
    SELECT code_result, message_result;
    COMMIT;
END //
DELIMITER ;

