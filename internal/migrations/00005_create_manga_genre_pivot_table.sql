-- +goose Up
-- +goose StatementBegin
CREATE TABLE manga_genres_pivot(
    id_manga_genre serial primary key  ,
    id_manga integer,
    id_genre integer,
    foreign key( id_manga) references manga(id),
    foreign key (id_genre) references genres(id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table if exists genres;
-- +goose StatementEnd
