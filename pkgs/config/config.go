package config

import (
	"fmt"
	"time"

	"github.com/caarlos0/env/v6"
)

type Conf struct {
	DB     ConfDB
	Server ConfServer
}

type ConfDB struct {
	Host  string `env:"DB_HOST"`
	Port  int `env:"DB_PORT"`
	User  string `env:"DB_USER"`
	Pass  string `env:"DB_PASS"`
	Name  string `env:"DB_NAME"`
	Debug bool `env:"DB_DEBUG"`
}

type ConfServer struct {
	Port         int        `env:"SERVER_PORT"`
	TimeoutRead  time.Duration `env:"SERVER_TIMEOUT_READ"`
	TimeoutWrite time.Duration `env:"SERVER_TIMEOUT_WRITE"`
	TimeoutIdle  time.Duration `env:"SERVER_TIMEOUT_IDLE"`
	Debug        bool          `env:"SERVER_DEBUG"`
}


func New() *Conf{
	var c Conf
	
	if err := env.Parse(&c); err != nil{
		fmt.Printf("%+v\n" , err)
	}

	return &c
}

func NewDBEnv() *ConfDB{
	var c ConfDB
	if err := env.Parse(&c); err != nil{
		fmt.Printf("%+v\n" , err)
	}
	return &c
}
