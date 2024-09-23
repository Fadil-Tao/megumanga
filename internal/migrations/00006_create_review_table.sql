-- +goose Up
-- +goose StatementBegin

create type feelings as ENUM ('W' , 'mid' ,'L');

create table review(
    id serial primary key ,
    manga_id integer not null,
    user_id integer not null,
    review_text text not null,
    tag feelings,
    foreign key(user_id) references user(id),
    foreign key(manga_id) references manga(id),
    created_at TIMESTAMP DEFAULT current_timestamp
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table if exists review;
drop type if exists feelings;
-- +goose StatementEnd
