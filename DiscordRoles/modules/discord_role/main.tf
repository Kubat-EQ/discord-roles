locals {
    server_id = "676568200229552140"
}

data discord_permission member {
    view_channel     = "allow"
    send_messages    = "allow"
    use_vad          = "deny"
    priority_speaker = "deny"
}

resource discord_role role {
    server_id = local.server_id
    name = "${var.role}-tf"
    permissions = data.discord_permission.member.allow_bits
    hoist = true
    mentionable = true
    //position = var.position
}