#!/bin/sh

# mount the backend
vault secrets enable pki

# adjust maximum lifetime
vault secrets tune -max-lease-ttl=87600h pki

# generate root certificate
vault write pki/root/generate/internal common_name="myvault.com" ttl=87600h

# configure URLs
vault write pki/config/urls \
	issuing_certificates="http://vault.example.com:8200/v1/pki/ca" \
	crl_distribution_points="http://vault.example.com:8200/v1/pki/crl"

# configure role
vault write pki/roles/example-dot-com \
	allowed_domains=example.com \
	allow_subdomains=true \
	max_ttl=20s
