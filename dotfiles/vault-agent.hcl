
auto_auth {
  method {
    type = "token_file"

    config {
      token_file_path = "/Users/csl04r/.vault-token"
    }
  }
}

template_config {
  static_secret_render_interval = "10m"
  exit_on_retry_failure         = true
  max_connections_per_host      = 10
}

vault {
  address = "https://vault.sherwin.com"
}

#path "auth/oidc/oidc/auth_url" {
#  capabilities = ["create", "update"]
#}

#exec {
#command                   = ["env"]
#restart_on_secret_changes = "always"
#restart_stop_signal       = "SIGTERM"
#}

template {
  destination = "vault-secrets-local.env"
  contents = <<EOT
{{- with secret "psg-merchant-services/kv2/local/pol/graphql" -}}
{{- range $key, $value := .Data.data -}}
{{ $key }}='{{ $value }}'
{{ end }}
{{- end }}
EOT
}

template {
  destination = "/Users/csl04r/.vault-secrets-local.sh"
  contents = <<EOT
{{- with secret "psg-merchant-services/kv2/local/pol/graphql" -}}
{{- range $key, $value := .Data.data -}}
export {{ $key }}='{{ $value }}'
{{ end }}
{{- end }}
EOT
}

// Sign SSH pub keys into SSH Certificates
template {
  destination = "/Users/csl04r/.ssh/id_ed25519-cert.pub"
  contents = <<EOT
{{ with secret "ssh-tag-test-client/sign/allday" "public_key=ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKg0EVAiHHzVz60wCTHfrHgOCnJ95FHRV7DlaMCS6YGb csl04r@Chads-MacBook-Pro.local" "valid_principals=helpdesk,csl04r,admin"  }}
{{ .Data.signed_key }}
{{ end }}
EOT
}
