config.texts = {
    notify_title = 'Mochila',
    ground_title = 'Chão',
    survival_title = 'Pessoa',
    loot_title = 'Loot',
    chest_title = 'Baú',
    notify_full_bag_error = 'Sua mochila está cheia!',
    notify_non_existent_item = 'Este item não existe!',
    notify_success_delete_bag = function(bag_name)
        return 'Mochila '..bag_name..' deletada com sucesso!'
    end,
    notify_receive_item = function(amount, item)
        return 'Você recebeu '..amount..'x de '..item..'.'
    end,
    notify_send_item = function(amount, item)
        return amount..'x '..item..' enviado com sucesso!'
    end,
    notify_no_nearest_player = 'Nâo há pessoas por perto!',
    notify_player_no_weight = 'A pessoa não possui espaço na mochila!',
    notify_player_no_item = 'Você não possui este item!',
    notify_equip_weapon = function(item)
        return 'Você equipou '..item..'!'
    end,
    notify_unequip_weapon = function(item)
        return 'Você desequipou '..item..'!'
    end,
    notify_weapon_already_equiped = 'Você já possui esta arma equipada!',
    notify_no_weapon_ammo = 'Você não tem uma arma que use esta munição equipada!',
    notify_no_has_permission = 'Você não possui permissão!',
    notify_nearest_player = "Você não pode acessar o baú/armazém com outras pessoas por perto!",
    chestTitle = 'Baú',
    trunkTitle = 'Porta Malas',
    gloveTitle = 'Porta Luva',
    notify_no_register_vehicle = 'Veículo não registrado!',
    notify_locked_vehicle = 'Veículo trancado!',
    no_space = 'Você não possui slots disponíveis!',
}