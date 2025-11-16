CREATE TABLE ratings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Rating user
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    -- Rated store
    store_id UUID NOT NULL REFERENCES stores(id) ON DELETE CASCADE,

    rating_value INTEGER NOT NULL 
    CHECK (rating_value >= 1 AND rating_value <= 5),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT unique_user_store_rating UNIQUE (user_id, store_id),

    CONSTRAINT only_normal_user_can_rate
        CHECK ((SELECT role FROM users WHERE id = user_id) = 'NORMAL_USER'),

    CONSTRAINT no_owner_rating_own_store
        CHECK ((SELECT owner_id FROM stores WHERE id = store_id) <> user_id)
);

CREATE INDEX idx_ratings_user_id ON ratings(user_id);
CREATE INDEX idx_ratings_store_id ON ratings(store_id);
CREATE INDEX idx_ratings_store_created ON ratings(store_id, created_at DESC);
CREATE INDEX idx_ratings_user_store ON ratings(user_id, store_id);
CREATE INDEX idx_ratings_created_at ON ratings(created_at DESC);
