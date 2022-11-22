#!/bin/bash
set -e

base_dir=$(git rev-parse --show-toplevel)
echo "start terraform fmt"
terraform fmt -check -recursive "$base_dir"
echo "start tflint"
tflint --module "$base_dir"/modules/*
echo "start tfsec"
tfsec "$base_dir"
