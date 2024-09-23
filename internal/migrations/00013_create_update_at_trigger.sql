-- +goose Up
-- +goose StatementBegin
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = now();
   RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_readlist_updated_at before update on readlist for each row EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_ratings_updated_at before update on ratings for each row EXECUTE FUNCTION update_updated_at_column();

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop TRIGGER if exists update_users_updated_at on users;
drop TRIGGER if exists update_readlist_updated_at on readlist;
drop TRIGGER if exists update_ratings_updated_at on ratings;
drop function if exists update_updated_at_column;
-- +goose StatementEnd
