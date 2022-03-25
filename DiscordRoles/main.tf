locals {
    player_list = split("\n", file("Roster.txt"))
    classes = {
        "Bard" = {
            position = 1
        },
        "Beastlord" = {
            position = 2
        },
        "Berserker" = {
            position = 3 
        },
        "Cleric" = {
            position = 4
        },
        "Druid" = {
            position = 5
        },
        "Enchanter" = {
            position = 6
        },
        "Magician" = {
            position = 7
        },
        "Monk" = {
            position = 8
        },
        "Necromancer" = {
            position = 9
        },
        "Paladin" = {
            position = 10
        },
        "Ranger" = {
            position = 11
        },
        "Rogue" = {
            position = 12
        },
        "Shadow Knight" = {
            position = 13
        },
        "Shaman" = {
            position = 14
        },
        "Warrior" = {
            position = 15
        },
        "Wizard" = {
            position = 16
        }
    }
}

data discord_color blue {
    hex = "#4287f5"
}

data "local_file" "foo" {
    filename = "${path.module}/Roster.txt"
}

data discord_permission member {
    view_channel     = "allow"
    send_messages    = "allow"
    use_vad          = "deny"
    priority_speaker = "deny"
}

data discord_permission moderator {
    allow_extends = data.discord_permission.member.allow_bits
    deny_extends = data.discord_permission.member.deny_bits
    kick_members     = "allow"
    ban_members      = "allow"
    manage_nicknames = "allow"
    view_audit_log   = "allow"
    priority_speaker = "allow"
}

# resource discord_role moderator {
#     server_id = var.server_id
#     name = "Moderator"
#     permissions = data.discord_permission.moderator.allow_bits
#     color = data.discord_color.blue.dec
#     hoist = true
#     mentionable = true
#     position = 5
# }

data discord_role role {
    server_id = var.server_id
    name      = "Director"
}

data discord_member member {
    server_id = var.server_id
    username = "Kubat"
    discriminator = "7046"
}

# resource discord_member_roles member_role {
#     user_id = data.discord_member.member.id
#     server_id = var.server_id
#     role {
#         role_id = data.discord_role.role.role_id
#     }
#     role {
#         role_id = data.discord_role.role.role_id
#         has_role = false
#     }
# }

# output jakes_username_and_discrim {
#     value = data.discord_member.member.id
# }

# output mods_color {
#     value = data.discord_role.role.color
# }

module roles {
    source = "./modules/discord_role"
    for_each = local.classes
    role = each.key
    position = sum([28,each.value.position])
}
/*
module player {
    source = "./modules/player"
    for_each = toset(local.player_list)
    class = split("==",each.value)[1]
    discord_name = split("#",split("==",each.value)[0])[0]
    discord_number = split("#",split("==",each.value)[0])[1]
}*/
output test {
    value = data.discord_role.role.position
}
