 resource "aws_iam_role" "step_role" {
  name = "abc-step-function-role-v2"
 
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
 
resource "aws_iam_role_policy" "step_policy" {
  name = "step-function-policy"
  role = aws_iam_role.step_role.id
 
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "events:PutRule",
          "events:PutTargets",
          "events:DescribeRule"
        ]
        Resource = "*"
      }
    ]
  })
}
 resource "aws_iam_role_policy" "ecs_policy" {
  name = "ecs-run-task-policy"
  role = aws_iam_role.step_role.id
 
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecs:RunTask",
          "ecs:DescribeTasks"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = "*"
      }
    ]
  })
}
 
