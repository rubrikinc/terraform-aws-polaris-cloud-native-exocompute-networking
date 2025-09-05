# Basic Exocompute networking
The configuration in this directory creates a VPC with a network which an Exocompute EKS cluster will run on.

## Usage
To run this example you need to execute:
```bash
$ terraform init
$ terraform plan
$ terraform apply
```
Note that this example may create resources which can cost money. Run `terraform destroy` when you don't need these
resources.

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.26.0 |

## Providers

No providers.

## Resources

No resources.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_exocompute_networking"></a> [exocompute\_networking](#module\_exocompute\_networking) | ../../ | n/a |

## Inputs

No inputs.

## Outputs

No outputs.

<!-- END_TF_DOCS -->
