CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE users(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    name VARCHAR(60) NOT NULL
        CHECK (char_length(name) BETWEEN 3 AND 60)
        CHECK (name ~ '^[A-Za-z ]+$'), 

    email VARCHAR(100) UNIQUE NOT NULL
        CHECK (email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$'), 

    password_hash VARCHAR(255) NOT NULL
        CHECK (char_length(password_hash) > 20),

    address VARCHAR(400),
        CHECK (char_length(address) <= 400),

    role VARCHAR(20) NOT NULL
        CHECK ((role = 'NORMAL_USER' AND last_login IS NOT NULL) OR (role IN ('ADMIN', 'STORE_OWNER')))

    is_active BOOLEAN NOT NULL DEFAULT true,

    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    last_login TIMESTAMP,

    CONSTRAINT email_lowercase CHECK (email = lower(email))
)

CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_users_role ON users (role);
CREATE INDEX idx_users_is_active ON users (is_active);
CREATE INDEX idx_users_created_at ON users (created_at DESC);
CREATE INDEX idx_users_name_lower ON users (LOWER(name));