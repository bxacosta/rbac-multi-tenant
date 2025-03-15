INSERT INTO organizations (name)
VALUES ('Org Demo 1'),
       ('Org Demo 2');

INSERT INTO permissions (name)
VALUES ('READ'),
       ('WRITE'),
       ('DELETE'),
       ('UPDATE');

INSERT INTO roles (name, organization_id)
VALUES ('ADMIN', (SELECT id FROM organizations WHERE name = 'Org Demo 1')),
       ('USER', (SELECT id FROM organizations WHERE name = 'Org Demo 1')),
       ('MANAGER', (SELECT id FROM organizations WHERE name = 'Org Demo 2')),
       ('STAFF', (SELECT id FROM organizations WHERE name = 'Org Demo 2'));

INSERT INTO users (username, password, enabled, organization_id)
VALUES ('admin@mail.com', '{bcrypt}$2a$10$E9Y/i1IurE4Lg1rz6IG93OafMZoxv8cSMR1Th//9eptfM9PlTrWmW', TRUE,
        (SELECT id FROM organizations WHERE name = 'Org Demo 1')),
       ('user@mail.com', '{bcrypt}$2a$10$E9Y/i1IurE4Lg1rz6IG93OafMZoxv8cSMR1Th//9eptfM9PlTrWmW', TRUE,
        (SELECT id FROM organizations WHERE name = 'Org Demo 1')),
       ('manager@mail.com', '{bcrypt}$2a$10$E9Y/i1IurE4Lg1rz6IG93OafMZoxv8cSMR1Th//9eptfM9PlTrWmW', TRUE,
        (SELECT id FROM organizations WHERE name = 'Org Demo 2')),
       ('staff@mail.com', '{bcrypt}$2a$10$E9Y/i1IurE4Lg1rz6IG93OafMZoxv8cSMR1Th//9eptfM9PlTrWmW', TRUE,
        (SELECT id FROM organizations WHERE name = 'Org Demo 2'));

INSERT INTO user_roles (user_id, role_id)
VALUES ((SELECT id FROM users WHERE username = 'admin@mail.com'), (SELECT id FROM roles WHERE name = 'ADMIN')),
       ((SELECT id FROM users WHERE username = 'user@mail.com'), (SELECT id FROM roles WHERE name = 'USER')),
       ((SELECT id FROM users WHERE username = 'manager@mail.com'), (SELECT id FROM roles WHERE name = 'MANAGER')),
       ((SELECT id FROM users WHERE username = 'staff@mail.com'), (SELECT id FROM roles WHERE name = 'STAFF'));

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r,
     permissions p
WHERE r.name = 'ADMIN';

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r,
     permissions p
WHERE r.name = 'USER'
  AND p.name = 'READ';

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r,
     permissions p
WHERE r.name = 'MANAGER'
  AND p.name IN ('READ', 'WRITE', 'UPDATE');

INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r,
     permissions p
WHERE r.name = 'STAFF'
  AND p.name IN ('READ', 'UPDATE');
