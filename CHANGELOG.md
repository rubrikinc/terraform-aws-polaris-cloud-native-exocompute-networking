# Changelog

## v0.2.0
* Relax the AWS provider version constraint to `>=5.26.0`.
* Dynamically look up the primary and secondary availability zones from the set of available zones for the region.
  Previously the availability zones were hardcoded to `a` and `b`. The `use_availability_zones_a_and_b` input variable
  can be set to `true` to restore the previous behavior.
