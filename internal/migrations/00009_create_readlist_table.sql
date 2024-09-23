-- +goose Up
-- +goose StatementBegin
create table readlist(
    id serial primary key,
    user_id integer not null,
    nama varchar(255),
    description text ,
    foreign key (user_id) references users(id),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp 
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table if exists readlist;
-- +goose StatementEnd
