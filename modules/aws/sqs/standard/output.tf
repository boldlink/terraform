output "sqs_arn" {
  value = "${aws_sqs_queue.main.arn}"
}

output "sqs_id" {
  value = "${aws_sqs_queue.main.id}"
}