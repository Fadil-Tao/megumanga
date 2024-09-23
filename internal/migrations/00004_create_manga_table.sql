-- +goose Up
-- +goose StatementBegin
create type manga_status as ENUM ('done' , 'in_progress' ,'later');

create table manga(
    id serial primary key,
    title varchar(255) not null,
    synopsys text not null,
    manga_status manga_status,
    published_at date not null,
    finished_at date
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
drop table if exists manga;
drop type if exists manga_status; 
-- +goose StatementEnd
