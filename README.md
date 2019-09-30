# cfnex

Displays the value of an AWS CloudFormation export, without having to
install Python, install AWSCLI, or learn JMESPath.

## Usage

```bash
$ cfnex [--profile PROFILE] [--region REGION] EXPORT_NAME
```

## Example

Assuming your AWS_PROFILE and DEFAULT_AWS_REGION are already set, this command is
simple:

```bash
$ cfnex "dev:route53:domain-name"
example.com
```

If your AWS environment variables are not setup, or you want to control the
AWS configuration at runtime, you can do this:

```bash
$ cfnex --profile PROFILE --region REGION "dev:route53:domain-name"
example.com
```
