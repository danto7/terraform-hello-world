# hello-world

This module creates a lambda that prints a nice message to the world.

## Usage

To use this module use the example in the [main.tf](main.tf)

```terraform
module "hello-world" {
  source = "github.com/danto7/sda_coding_challenge?ref=v0.0.0"

  cron_expression = "* * ? * * *"
}
```

## Versioning

This module uses semantic versioning.
Bug fixes will be represented by the third digit,
new features can will be represented by the second digit
and breaking changes will be represented by the first digit.
To reference a specific version take a look at the example above.


Changes will be documented in the [changelog.md](Changelog).

