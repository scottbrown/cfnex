package main

type CliEnv struct {
	AWSProfile string
	AWSRegion  string
}

func (e CliEnv) Validate() error {
	if e.AWSProfile == "" {
		return ErrMissingAWSProfile
	}
	if e.AWSRegion == "" {
		return ErrMissingAWSRegion
	}
	return nil
}
