CREATE TABLE organizations
(
    id   BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE permissions
(
    id   BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE roles
(
    id              BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR(255) UNIQUE NOT NULL,
    organization_id BIGINT              NOT NULL,
    CONSTRAINT fk_roles__organization FOREIGN KEY (organization_id)
        REFERENCES organizations (id)
        ON DELETE RESTRICT
);

CREATE TABLE users
(
    id              BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    username        VARCHAR(255) UNIQUE  NOT NULL,
    password        VARCHAR(255)         NOT NULL,
    enabled         BOOLEAN DEFAULT TRUE NOT NULL,
    organization_id BIGINT               NOT NULL,
    CONSTRAINT fk_users__organization FOREIGN KEY (organization_id)
        REFERENCES organizations (id)
        ON DELETE RESTRICT
);

CREATE TABLE role_permissions
(
    role_id       BIGINT NOT NULL,
    permission_id BIGINT NOT NULL,
    PRIMARY KEY (role_id, permission_id),
    CONSTRAINT fk_role_permissions__role FOREIGN KEY (role_id)
        REFERENCES roles (id) ON DELETE CASCADE,
    CONSTRAINT fk_role_permissions__permission FOREIGN KEY (permission_id)
        REFERENCES permissions (id) ON DELETE CASCADE
);

CREATE TABLE user_roles
(
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, role_id),
    CONSTRAINT fk_user_roles__user FOREIGN KEY (user_id)
        REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_user_roles__role FOREIGN KEY (role_id)
        REFERENCES roles (id) ON DELETE CASCADE
);

CREATE INDEX idx_roles_organization_id ON roles (organization_id);
CREATE INDEX idx_users_organization_id ON users (organization_id);
