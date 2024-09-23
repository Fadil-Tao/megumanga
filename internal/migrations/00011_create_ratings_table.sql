-- +goose Up
-- +goose StatementBegin
create table ratings(
    id serial primary key,
    manga_id integer,
    user_id integer ,
    foreign key(manga_id) references manga(id),
    foreign key(user_id) references users(id),
    rating SMALLINT NOT NULL CHECK (rating between 1 and 10),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table if exists ratings; 
-- +goose StatementEnd
