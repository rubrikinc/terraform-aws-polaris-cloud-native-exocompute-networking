# Changelog

## v0.3.1
* Improve the RSC managed Exocompute example.

## v0.3.0
* Remove the AWS provider block from the module. Must now be provided in the Terraform root module.
* Add module usage examples.
* Mark the `aws_profile` and `rsc_exocompute_region` variables as deprecated. They are no longer used by the module and
  have no replacements. The Exocompute region is now the region used by the AWS provider.
* Add support for specifying additional tags to the resources being created in AWS.
* Add the `aws_security_group_control_plane_id` and `aws_security_group_worker_node_id` outputs. The existing outputs
  for the values partially used hyphens instead of underscores in their names.
* Add the `rsc_exocompute_vpc_id` output.

## v0.2.0
* Relax the AWS provider version constraint to `>=5.26.0`.
* Dynamically look up the primary and secondary availability zones from the set of available zones for the region.
  Previously the availability zones were hardcoded to `a` and `b`. The `use_availability_zones_a_and_b` input variable
  can be set to `true` to restore the previous behavior.
