CREATE TABLE stores (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    name VARCHAR(120) NOT NULL 
        CHECK (char_length(name) BETWEEN 3 AND 120),

    email VARCHAR(255) NOT NULL UNIQUE
        CHECK (email = lower(email))
        CHECK (email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$'),

    address VARCHAR(400) NOT NULL
        CHECK (char_length(address) > 5),

    -- Assign store owner
    owner_id UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,

    is_active BOOLEAN NOT NULL DEFAULT true,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT store_owner_must_have_correct_role
        CHECK ((SELECT role FROM users WHERE id = owner_id) = 'STORE_OWNER'),

    CONSTRAINT store_email_not_same_as_owner 
        CHECK ((SELECT email FROM users WHERE id = owner_id) <> email)
);

CREATE INDEX idx_stores_name_lower ON stores(LOWER(name));
CREATE INDEX idx_stores_email ON stores(email);
CREATE INDEX idx_stores_owner ON stores(owner_id);
CREATE INDEX idx_stores_active ON stores(is_active);
CREATE INDEX idx_stores_created ON stores(created_at DESC);

