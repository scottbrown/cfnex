package main

import "errors"

var ErrMissingAWSProfile = errors.New("Missing AWS Profile")

var ErrMissingAWSRegion = errors.New("Missing AWS Region")
