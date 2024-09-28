-- Nonotes Tables v1.0.0
-- Date: 2024-09-01

--
-- Table structure for table `Notes`
--
DROP TABLE IF EXISTS Notes;
CREATE TABLE Notes (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    uuid VARCHAR(60) NOT NULL,
    title VARCHAR(30) NOT NULL,
    subtitle VARCHAR(50) NULL,
    description VARCHAR(200) NULL,
    status SMALLINT NOT NULL,
    image VARCHAR(200) NULL,
    code VARCHAR(10) UNIQUE NOT NULL,
    starts_at DATETIME NULL,
    ends_at DATETIME NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,
    INDEX idx_uuid (uuid),
    INDEX idx_status (status),
    INDEX idx_starts_at (starts_at),
    INDEX idx_ends_at (ends_at)
) ENGINE=InnoDB;

--
-- Table structure for table `Alarms`
--
DROP TABLE IF EXISTS Alarms;
CREATE TABLE Alarms (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    uuid VARCHAR(60) NOT NULL,
    alarm_time DATETIME NOT NULL,
    note_id INTEGER NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,
    CONSTRAINT fk_alarm_note_id FOREIGN KEY (note_id) REFERENCES Notes(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    INDEX idx_uuid (uuid),
    INDEX idx_alarm_time (alarm_time)
) ENGINE=InnoDB;

--
-- Table structure for table `Users`
--
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    uuid VARCHAR(60) NOT NULL,
    name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NULL,
    username VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL,
    password VARCHAR(100) NOT NULL,
    status SMALLINT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,
    UNIQUE INDEX idx_username (username),
    UNIQUE INDEX idx_email (email),
    INDEX idx_uuid (uuid),
    INDEX idx_status (status)
) ENGINE=InnoDB;

--
-- Table structure for table `UserNotes`
--
DROP TABLE IF EXISTS UserNotes;
CREATE TABLE UserNotes (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER NOT NULL,
    note_id INTEGER NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_note_id (note_id),
    CONSTRAINT fk_user_notes_user_id FOREIGN KEY (user_id) REFERENCES Users(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT fk_user_notes_note_id FOREIGN KEY (note_id) REFERENCES Notes(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

--
-- Table structure for table `UserSessions`
--
DROP TABLE IF EXISTS UserSessions;
CREATE TABLE UserSessions (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    uuid VARCHAR(60) NOT NULL,
    user_id INTEGER NOT NULL,
    login_at DATETIME NOT NULL,
    logout_at DATETIME NULL,
    device VARCHAR(40) NULL,
    in_use SMALLINT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NULL,
    deleted_at DATETIME NULL,
    CONSTRAINT fk_sessions_user_id FOREIGN KEY (user_id) REFERENCES Users(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    INDEX idx_uuid (uuid),
    INDEX idx_user_id (user_id),
    INDEX idx_login_at (login_at),
    INDEX idx_logout_at (logout_at),
    INDEX idx_in_use (in_use)
) ENGINE=InnoDB;

