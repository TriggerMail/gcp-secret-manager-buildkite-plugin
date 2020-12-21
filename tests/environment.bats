#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

environment_hook="$PWD/hooks/environment"

export SECRET_NAME1='secret1'
export SECRET_VALUE1='{"SecretString":"pretty-secret","SecretBinary":null}'
export SECRET_NAME2='secret2'
export SECRET_VALUE2='{"SecretString":"{\"nested\":\"secret\"}","SecretBinary":null}'

@test "Fetches values from GCP Secret Manager into env" {
  export BUILDKITE_PLUGIN_GCP_SECRET_MANAGER_ENV_TARGET1="${SECRET_NAME1}"
  export BUILDKITE_PLUGIN_GCP_SECRET_MANAGER_ENV_TARGET2="${SECRET_NAME2}"

  # export -f aws

  run "${environment_hook}"

  assert_success
  # assert_output --partial "Reading ${SECRET_NAME1} from AWS SM into environment variable TARGET1"
  # assert_output --partial "Reading ${SECRET_NAME2} from AWS SM into environment variable TARGET2"

  unset BUILDKITE_PLUGIN_GCP_SECRET_MANAGER_ENV_TARGET1
  unset BUILDKITE_PLUGIN_GCP_SECRET_MANAGER_ENV_TARGET2
}