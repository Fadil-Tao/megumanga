-- +goose Up
-- +goose StatementBegin
create table favorites(
    id serial primary key ,
    user_id integer,
    manga_id integer, 
    created_at timestamp default current_timestamp ,
    foreign key (user_id) references users(id),
    foreign key (manga_id) references manga(id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table if exists favorites;
-- +goose StatementEnd
