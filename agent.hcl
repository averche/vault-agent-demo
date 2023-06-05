
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

env_template "CERT" {
  contents             = "{{ with pkiCert \"pki/issue/example-dot-com\" \"common_name=foo.example.com\" }}{{ .Data.Cert }}{{ end }}"
  error_on_missing_key = true
}
env_template "CERT_KEY" {
  contents             = "{{ with pkiCert \"pki/issue/example-dot-com\" \"common_name=foo.example.com\" }}{{ .Data.Key }}{{ end }}"
  error_on_missing_key = true
}

exec {
  command                   = ["./demo-app3.sh"]
  restart_on_secret_changes = "always"
  restart_stop_signal       = "SIGTERM"
}
