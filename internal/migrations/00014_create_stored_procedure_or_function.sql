-- +goose Up
-- +goose StatementBegin
CREATE FUNCTION average_rating(manga_id_input INTEGER)
RETURNS FLOAT AS $$
DECLARE
    avg_rating FLOAT;
BEGIN
    SELECT AVG(rating) INTO avg_rating
    FROM ratings
    WHERE manga_id = manga_id_input;

    RETURN avg_rating;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION create_initial_readlist()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO readlist (user_id, nama, description, created_at, updated_at)
    VALUES (NEW.user_id, NEW.username || ' list', 'Default readlist for user ' || NEW.username, NOW(), NOW());
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER create_initial_readlist_for_user
AFTER INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION create_initial_readlist();



CREATE OR REPLACE PROCEDURE add_to_readlist(
    user_id_input INTEGER,
    readlist_name_input VARCHAR,
    manga_id_input INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    readlist_id INTEGER;
BEGIN
    BEGIN;

    INSERT INTO readlist_items (readlist_id, manga_id, status, added_at)
    VALUES (readlist_id, manga_id_input, 'in_progress', NOW());


    COMMIT;
EXCEPTION
    ROLLBACK;
      
END;
$$;


-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop function if exists average_rating;
-- +goose StatementEnd
