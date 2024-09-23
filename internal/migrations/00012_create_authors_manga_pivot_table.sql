-- +goose Up
-- +goose StatementBegin
create table authors_manga_pivot(
    id serial primary key ,
    id_manga integer not null, 
    id_author integer not null,
    foreign key(id_manga) references manga(id),
    foreign key(id_author) references authors(id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table if exists authors_manga_pivot;
-- +goose StatementEnd
