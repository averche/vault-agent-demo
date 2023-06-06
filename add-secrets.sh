#!/bin/sh

vault kv put  -mount=secret  test                   user=hello    password=vault

# nested under my-app/
vault kv put  -mount=secret  my-app/database        user=admin    password=s3cr3t
vault kv put  -mount=secret  my-app/api-keys        key1=abc123   key2=xyz123
vault kv put  -mount=secret  my-app/foo/bar/nested  value=demo  
