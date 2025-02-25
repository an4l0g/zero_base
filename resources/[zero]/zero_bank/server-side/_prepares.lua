zero._prepare('zero_bank/getPix', 'select chave from pix where user_id = @user_id')
zero._prepare('zero_bank/editPix', 'update pix set chave = @chave where user_id = @user_id')
zero._prepare('zero_bank/checkPix', 'select chave from pix where chave = @chave')
zero._prepare('zero_bank/addPix', 'insert pix (user_id, chave) values (@user_id, @chave)')
zero._prepare('zero_bank/delPix', 'delete from pix where user_id = @user_id')
zero._prepare('zero_bank/addMultas', 'insert fine (user_id, fine_reason, fine_value, fine_time, fine_description) values (@user_id, @reason, @value, @time, @description)')
zero._prepare('zero_bank/getMultas', 'select * from fine where user_id = @user_id')
zero._prepare('zero_bank/getMulta', 'select * from fine where id = @multa_id')
zero._prepare('zero_bank/delMulta', 'delete from fine where user_id = @user_id and id = @multa_id')
zero._prepare('zero_bank/delAllMultas', 'delete from fine where user_id = @user_id')