package main

import (
	"context"
	"flag"
	"fmt"
	"log/slog"
	"os"

	"github.com/Fadil-Tao/megumanga/pkgs/config"
	"github.com/joho/godotenv"
	"github.com/pressly/goose/v3"
	_ "github.com/jackc/pgx/v5/stdlib"
	
)

const (
	dialect     = "pgx"
	fmtDBString = "host=%s user=%s password=%s dbname=%s port=%d sslmode=disable"
)

var (
	flags = flag.NewFlagSet("migrate", flag.ExitOnError)
	dir   = flags.String("dir", "internal/migrations", "directory with migration files")
)

func main() {
	err := godotenv.Load()
	if err != nil {
		slog.Error("Error Loading .env file")
	}

	flags.Usage = usage 
	flags.Parse(os.Args[1:])

	args := flags.Args()
	if len(args) == 0 || args[0] == "-h" || args[0] == "--help" {
		flags.Usage()
		return
	}

	command := args[0]

	c := config.NewDBEnv()
	dbString := fmt.Sprintf(fmtDBString, c.Host, c.User, c.Pass, c.Name, c.Port)

	db, err := goose.OpenDBWithDriver(dialect, dbString)
	if err != nil {
		slog.Error("Open with driver failed" , "err" , err)
	}

	defer func() {
		if err := db.Close(); err != nil {
		slog.Error("Closing db failed" , "err" , err)
		}
	}()

	if err := goose.RunContext(context.Background(),command, db, *dir, args[1:]...); err != nil {
		slog.Error("migrate %v: %v", "command" , command,"err" , err)
	}
}


func usage() {
	fmt.Println(usagePrefix)
	flags.PrintDefaults()
	fmt.Println(usageCommands)
}

var (
	usagePrefix = `Usage: migrate COMMAND
Examples:
    migrate status
`

	usageCommands = `
Commands:
    up                   Migrate the DB to the most recent version available
    up-by-one            Migrate the DB up by 1
    up-to VERSION        Migrate the DB to a specific VERSION
    down                 Roll back the version by 1
    down-to VERSION      Roll back to a specific VERSION
    redo                 Re-run the latest migration
    reset                Roll back all migrations
    status               Dump the migration status for the current DB
    version              Print the current version of the database
    create NAME [sql|go] Creates new migration file with the current timestamp
    fix                  Apply sequential ordering to migrations`
)