# Terraform moduleName module

- [Terraform moduleName module](#terraform-modulename-module)
  - [Input Variables](#input-variables)
  - [Variable definitions](#variable-definitions)
    - [name](#name)
    - [tags](#tags)
    - [partner_source](#partner_source)
    - [create_archive](#create_archive)
    - [description](#description)
    - [retention_days](#retention_days)
    - [event_pattern](#event_pattern)
  - [Examples](#examples)
    - [`main.tf`](#maintf)
    - [`terraform.tfvars.json`](#terraformtfvarsjson)
    - [`provider.tf`](#providertf)
    - [`variables.tf`](#variablestf)
    - [`outputs.tf`](#outputstf)

## Input Variables
| Name     | Type    | Default   | Example     | Notes   |
| -------- | ------- | --------- | ----------- | ------- |
| name | string |  | "test-event_bus" |  |
| tags | map(string) | {} | {"environment": "prod"} | |
| partner_source | string | "" | "aws.partner/testpartner.com" |  |
| create_archive | bool | false | true |  |
| description | string | null | "Descriptrion of test event bus archive." |  |
| retention_days | number | null | 7 |  |
| event_pattern | any | null | `see below` |  |

## Variable definitions

### name
Name of custom Event bus.
If `partner_source` is used it will be forced to match it during creation but this custom one will be used for naming the archive if used.
```json
"name": "<Event bus name>"
```

### tags
Tags for created bucket.
```json
"tags": {<map of tag keys and values>}
```

Default:
```json
"tags": {}
```

### partner_source
Name of partner event source. If specified name of Event bus will be forced to be same as this.
```json
"partner_source": "<partner source name>"
```

Default:
```json
"partner_source": ""
```

### create_archive
Specifies if archive is created for this Event bus.
```json
"create_archive": <true or false>
```

Default:
```json
"create_archive": false
```

### description
Sets description of Event bus archive.
```json
"description": "<description of Event bus archive>"
```

Default:
```json
"description": null
```

### retention_days
Number of days for keeping archived messages, if not set it keeps indefinite by default.
```json
"retention_days": <number of days for archive retention>
```

Default:
```json
"retention_days": null
```

### event_pattern
Specifies event pattern for archive, if not specified it archives all events from the Event bus.
```json
"event_pattern": {<object specifying event patter for archive>}
```

Default:
```json
"event_pattern": {}
```

## Examples
### `main.tf`
```terarform
module "event_bus" {
  source = "github.com/variant-inc/terraform-aws-eventbridge-event-bus?ref=v1"

  name            = var.name
  tags            = var.tags
  partner_source  = var.partner_source

  create_archive  = var.create_archive
  description     = var.description
  retention_days  = var.retention_days
  event_pattern   = var.event_pattern
}
```

### `terraform.tfvars.json`
```json
{
  "name": "test-event_bus",
  "tags": {
    "environment": "prod"
  },
  "create_archive": true,
  "description": "Descriptrion of test event bus archive.",
  "retention_days": 183,
  "event_pattern": {
    "source": ["test.source"]
  }
}
```

Basic
```json
{
  "name": "test-event_bus"
}
```

### `provider.tf`
```terraform
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      team : "DataOps",
      purpose : "custom_event_bus_test",
      owner : "Luka"
    }
  }
}
```

### `variables.tf`
copy ones from module

### `outputs.tf`
```terraform
output "event_bus_name" {
  value       = module.event_bus.event_bus_name
  description = "Name of the EventBridge Event bus"
}
```