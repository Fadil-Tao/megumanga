-- +goose Up
-- +goose StatementBegin
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    nama VARCHAR(255) NOT NULL,
    is_admin BOOLEAN not null,
    password TEXT NOT NULL,
    salt varchar(255) not null,
    created_at TIMESTAMP DEFAULT current_timestamp ,
    updated_at datetime DEFAULT current_timestamp on update current_timestamp
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS USERS;
-- +goose StatementEnd
