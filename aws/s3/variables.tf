// REQUIRED
variable "buckets" {
  type = list(object({
    name                    = string
    acl                     = string
    versioning              = string
    block_public_acl        = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  }))
}
