-- +goose Up
-- +goose StatementBegin

create type read_status as enum('done', 'in_progress', 'later');
create table readlist_items_pivot(
    id serial primary key,
    readlist_id integer,
    read_status read_status,
    manga_id integer ,
    foreign key(manga_id) references manga(id),
    foreign key(readlist_id) references readlist(id),
    added_at timestamp default current_timestamp
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table if exists readlist_items_pivot;
drop type if exists read_status;
-- +goose StatementEnd
