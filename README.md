# Terraform Hello World

[Hello World module documentation](modules/hello-world/README.md)

## Pre commit hook installation

The pre commit hook can be installed on unix based operating systems with the following command:
```bash
cd $(git rev-parse --show-toplevel)/.git/hooks && ln -s pre-commit ../../pre_commit_hook.sh
```

## Questions

**Please provide us with a solution how the module can recognize the region in which it is deployed.**


The aws region can be obtained with the following [data source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region):
```terraform
data "aws_region" "current" {}
```

