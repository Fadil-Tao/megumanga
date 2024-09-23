-- +goose Up
-- +goose StatementBegin
CREATE TABLE genres(
    id SERIAL PRIMARY KEY,
    nama varchar(255) not null,
    description text not null
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table if exists genres;
-- +goose StatementEnd
