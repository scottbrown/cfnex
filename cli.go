package main

import (
	"fmt"

	"github.com/urfave/cli"
)

func setup(app *cli.App) {
	app.Name = AppName
	app.Copyright = AppCopyright
	app.Usage = AppUsage
	app.ArgsUsage = "EXPORT_NAME"
	app.Version = AppVersion

	app.Flags = []cli.Flag{
		cli.StringFlag{
			Name:        "profile,p",
			Usage:       "Uses the AWS account named by `PROFILE`",
			EnvVar:      "AWS_PROFILE",
			Destination: &env.AWSProfile,
		},
		cli.StringFlag{
			Name:        "region,r",
			Usage:       "Targets the named AWS `REGION` where the CloudFormation exports live",
			EnvVar:      "AWS_DEFAULT_REGION",
			Destination: &env.AWSRegion,
		},
	}

	app.Action = start
}

func start(c *cli.Context) error {
	if c.NArg() == 0 {
		cli.ShowAppHelpAndExit(c, 1)
	}

	name := c.Args().Get(0)

	val, err := exportVal(name)
	if err != nil {
		return err
	}

	fmt.Println(val)

	return nil
}
