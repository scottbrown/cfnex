package main

import (
	"log"
	"os"

	"github.com/urfave/cli"
)

var env CliEnv

func main() {
	app := cli.NewApp()
	setup(app)

	if err := app.Run(os.Args); err != nil {
		log.Fatal(err)
	}
}
