# locals {
#     server_id = "676568200229552140"
# }

# data discord_member member {
#     server_id = local.server_id
#     username = var.discord_name
#     discriminator = var.discord_number
# }

# data discord_role role {
#     server_id = local.server_id
#     name      = var.class
# }

# resource discord_member_roles member_role {
#     user_id = data.discord_member.member.id
#     server_id = local.server_id
#     role {
#         role_id = data.discord_role.role.role_id
#     }
# }