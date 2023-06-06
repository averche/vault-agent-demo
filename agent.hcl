
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

exec {
  command                   = ["./demo-app1.sh"]
  restart_on_secret_changes = "always"
  restart_stop_signal       = "SIGTERM"
}
