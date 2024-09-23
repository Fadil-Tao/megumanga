-- +goose Up
-- +goose StatementBegin
create table likes_review(
    id serial primary key,
    user_id integer ,
    review_id integer,
    foreign key (user_id) references users(id),
    foreign key (review_id) references review(id),
    created_at timestamp default current_timestamp
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table if exists likes_review;
-- +goose StatementEnd
