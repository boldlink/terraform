output "private_key_pem" {
  value = tls_private_key.main.private_key_pem
}

output "public_key_pem" {
  value = tls_private_key.main.public_key_pem
}

output "public_key_openssh" {
  value = tls_private_key.main.public_key_openssh
}

output "public_key_fingerprint_md5" {
  value = tls_private_key.main.public_key_fingerprint_md5
}

