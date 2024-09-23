-- +goose Up
-- +goose StatementBegin
CREATE TABLE authors(
    id SERIAL PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    biography text not null,
    birth date not null
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table if exists authors;
-- +goose StatementEnd
