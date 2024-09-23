package db

import (
	"context"
	"log"
	"strconv"
	"time"

	"github.com/Fadil-Tao/megumanga/pkgs/config"
	"github.com/Fadil-Tao/megumanga/pkgs/types/pool"
	"github.com/jackc/pgx/v5/pgxpool"
)

var pool customPool.PgxCustomPool

func InitDB(cfg *config.ConfDB)customPool.PgxCustomPool{

	dsn := "postgres://"+cfg.User+ ":" + cfg.Pass + "@" + cfg.Host + ":" + strconv.Itoa(cfg.Port) + "/" + cfg.Name
	config , err := pgxpool.ParseConfig(dsn)
	if err != nil {
		log.Fatalf("Unable to parse database url : %v" , err)
	}
	config.MaxConns = 10
	config.MinConns = 1 
	config.HealthCheckPeriod = time.Minute

	pool, err := pgxpool.NewWithConfig(context.Background(), config)

	if err != nil {
		log.Fatalf("Unable create database connection pool: %v" , err)
	}

	log.Print("Successfully connect to database")
	return pool
}

func GetDB()customPool.PgxCustomPool{
	return pool
}

func CloseDB(){
	if pool != nil {
		pool.Close()
	}
}