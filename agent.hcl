
auto_auth {

  method {
    type = "token_file"

    config {
      token_file_path = "/Users/avean/.vault-token"
    }
  }
}

template_config {
  static_secret_render_interval = "5m"
  exit_on_retry_failure         = true
}

vault {
  address = "http://localhost:8200"
}

env_template "TEST_PASSWORD" {
  contents             = "{{ with secret \"secret/data/test\" }}{{ .Data.data.password }}{{ end }}"
  error_on_missing_key = true
}
env_template "TEST_USER" {
  contents             = "{{ with secret \"secret/data/test\" }}{{ .Data.data.user }}{{ end }}"
  error_on_missing_key = true
}
env_template "API_KEYS_KEY1" {
  contents             = "{{ with secret \"secret/data/my-app/api-keys\" }}{{ .Data.data.key1 }}{{ end }}"
  error_on_missing_key = true
}
env_template "API_KEYS_KEY2" {
  contents             = "{{ with secret \"secret/data/my-app/api-keys\" }}{{ .Data.data.key2 }}{{ end }}"
  error_on_missing_key = true
}
env_template "DATABASE_PASSWORD" {
  contents             = "{{ with secret \"secret/data/my-app/database\" }}{{ .Data.data.password }}{{ end }}"
  error_on_missing_key = true
}
env_template "DATABASE_USER" {
  contents             = "{{ with secret \"secret/data/my-app/database\" }}{{ .Data.data.user }}{{ end }}"
  error_on_missing_key = true
}
env_template "NESTED_VALUE" {
  contents             = "{{ with secret \"secret/data/my-app/foo/bar/nested\" }}{{ .Data.data.value }}{{ end }}"
  error_on_missing_key = true
}

exec {
  command                   = ["./demo-app1.sh"]
  restart_on_secret_changes = "always"
  restart_stop_signal       = "SIGTERM"
}
