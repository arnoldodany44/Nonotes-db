-- Nonotes Views v1.0.0
-- Date: 2024-09-01

--
-- View structure for view `vw_notes`
--
CREATE OR REPLACE VIEW vw_notes AS
SELECT
    n.id,
    n.uuid,
    n.title,
    n.subtitle,
    n.description,
    n.status,
    n.image,
    n.code,
    n.starts_at,
    n.ends_at,
    n.created_at,
    n.updated_at,
    n.deleted_at
FROM
    Notes n

--
-- View structure for view `vw_alarms`
--
CREATE OR REPLACE VIEW vw_alarms AS
SELECT
    a.id,
    a.uuid,
    a.alarm_time,
    a.note_id,
    a.created_at,
    a.updated_at,
    a.deleted_at
FROM
    Alarms a

--
-- View structure for view `vw_users`
--
CREATE OR REPLACE VIEW vw_users AS
SELECT
    u.id,
    u.uuid,
    u.name,
    u.last_name,
    u.username,
    u.email,
    u.password,
    u.status,
    u.created_at,
    u.updated_at,
    u.deleted_at
FROM
    Users u

--
-- View structure for view `vw_user_notes`
--
CREATE OR REPLACE VIEW vw_user_notes AS
SELECT
    un.id,
    un.user_id,
    un.note_id,
    un.created_at,
    un.updated_at,
    un.deleted_at,
    u.uuid AS user_uuid,
    u.name,
    u.last_name,
    u.username,
    u.email,
    n.uuid AS note_uuid,
    n.title,
    n.subtitle,
    n.description,
    n.status,
    n.image,
    n.code,
    n.starts_at,
    n.ends_at
FROM
    UserNotes un
    JOIN Users u ON un.user_id = u.id
    JOIN Notes n ON un.note_id = n.id;

--
-- View structure for view `vw_user_sessions`
--
CREATE OR REPLACE VIEW vw_user_sessions AS
SELECT
    us.id,
    us.uuid,
    us.user_id,
    us.login_at,
    us.logout_at,
    us.device,
    us.in_use,
    us.created_at,
    us.updated_at,
    us.deleted_at,
    u.uuid AS user_uuid,
    u.name,
    u.last_name,
    u.username,
    u.email
FROM
    UserSessions us
    JOIN Users u ON us.user_id = u.id;

