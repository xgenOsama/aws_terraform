output "sg_allow_http_ssh_id" {
  value = aws_security_group.allow_http_ssh.id
}

output "sg_allow_http_alb_sg_id" {
  value = aws_security_group.sg_allow_http_alb_sg.id
}

output "bastien_http_ssh_id" {
    value = aws_security_group.bastien_http_ssh.id

}