locals {
  repo_map = { for repository, att in var.repository : att.name => att }
}

resource "aws_ecr_repository" "registry" {
  for_each             = local.repo_map
  name                 = each.value.name
  image_tag_mutability = each.value.tag_mutability

  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }
}

resource "aws_ecr_repository_policy" "ecr_policy" {
  for_each   = local.repo_map
  repository = each.value.name

  policy = each.value.ecr_policy

  depends_on = [aws_ecr_repository.registry]
}

resource "aws_ecr_lifecycle_policy" "registry_policy" {
  for_each   = local.repo_map
  repository = each.value.name

  policy = each.value.ecr_lifecycle

  depends_on = [aws_ecr_repository.registry]
}
