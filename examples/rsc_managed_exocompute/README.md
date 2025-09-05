# Basic Exocompute networking
The configuration in this directory creates a VPC with a network and an Exocompute configuration for an RSC managed
Exocompute cluster.

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
| <a name="requirement_polaris"></a> [polaris](#requirement\_polaris) | >=1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.26.0 |
| <a name="provider_polaris"></a> [polaris](#provider\_polaris) | >=1.0.0 |

## Resources

| Name | Type |
|------|------|
| [polaris_aws_exocompute.rsc_managed](https://registry.terraform.io/providers/rubrikinc/polaris/latest/docs/resources/aws_exocompute) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_exocompute_networking"></a> [exocompute\_networking](#module\_exocompute\_networking) | ../../ | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_rsc_aws_cnp_account_id"></a> [rsc\_aws\_cnp\_account\_id](#input\_rsc\_aws\_cnp\_account\_id) | Polaris cloud account ID for the AWS account hosting Exocompute. | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
