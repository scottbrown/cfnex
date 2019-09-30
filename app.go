package main

import (
	"context"

	"github.com/aws/aws-sdk-go-v2/aws/external"
	"github.com/aws/aws-sdk-go-v2/service/cloudformation"
)

func exportVal(name string) (string, error) {
	var exportValue string
	config, err := external.LoadDefaultAWSConfig(
		external.WithSharedConfigProfile(env.AWSProfile),
		external.WithRegion(env.AWSRegion),
	)
	if err != nil {
		return "", err
	}

	input := cloudformation.ListExportsInput{}
	if err := input.Validate(); err != nil {
		return "", err
	}

	client := cloudformation.New(config)
	req := client.ListExportsRequest(&input)
	p := cloudformation.NewListExportsPaginator(req)
	for p.Next(context.TODO()) {
		page := p.CurrentPage()

		for _, i := range page.Exports {
			if *i.Name == name {
				exportValue = *i.Value
				break
			}
		}
	}

	return exportValue, nil
}
