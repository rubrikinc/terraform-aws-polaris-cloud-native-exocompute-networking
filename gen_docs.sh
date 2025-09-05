#!/usr/bin/env bash
terraform-docs markdown table --hide-empty --output-file README.md --sort .
terraform-docs markdown table --hide-empty --output-file README.md --sort ./examples/basic
terraform-docs markdown table --hide-empty --output-file README.md --sort ./examples/rsc_managed_exocompute
