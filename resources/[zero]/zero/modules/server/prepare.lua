---------------------------------------------------------------------------------------------------------------------------------
-- BASE.LUA
---------------------------------------------------------------------------------------------------------------------------------
zero.prepare('zero_framework/createUser', 'insert into users (whitelist, banned) values (false, false)')
zero.prepare('zero_framework/addIdentifier', 'insert into user_ids (identifier, user_id) values (@identifier, @user_id)')
zero.prepare('zero_framework/getIdentifier', 'select user_id from user_ids where identifier = @identifier')
zero.prepare("vRP/set_userdata", "REPLACE INTO user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
zero.prepare("vRP/get_userdata", "SELECT dvalue FROM user_data WHERE user_id = @user_id AND dkey = @key")
zero.prepare("vRP/set_srvdata", "REPLACE INTO srv_data(dkey,dvalue) VALUES(@key,@value)")
zero.prepare("vRP/get_srvdata", "SELECT dvalue FROM srv_data WHERE dkey = @key")
zero.prepare("vRP/rem_srv_data", "DELETE FROM srv_data WHERE dkey = @dkey")
zero.prepare("vRP/get_banned", "SELECT banned FROM users WHERE id = @user_id")
zero.prepare("vRP/get_identifiers_by_userid", "SELECT identifier FROM user_ids WHERE user_id = @user_id")
zero.prepare("vRP/set_banned", "UPDATE users SET banned = @banned WHERE id = @user_id")
zero.prepare('zero_framework/getWhitelist', 'SELECT whitelist FROM users WHERE id = @user_id')
zero.prepare('zero_framework/setWhitelist', 'UPDATE users SET whitelist = @whitelist WHERE id = @user_id')
zero.prepare('zero_framework/setLogin', 'UPDATE users SET last_login = current_timestamp(), ip = @ip WHERE id = @user_id')
---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------
-- GROUP.LUA
---------------------------------------------------------------------------------------------------------------------------------
zero.prepare('vRP/get_user_groups', 'SELECT groupId, gradeId, active FROM user_groups WHERE user_id = @user_id')
zero.prepare('vRP/get_user_group_grade', 'SELECT gradeId FROM user_groups WHERE user_id = @user_id AND groupId = @groupId')
zero.prepare('vRP/get_user_group_active', 'SELECT active FROM user_groups WHERE user_id = @user_id AND groupId = @groupId')
zero.prepare('vRP/add_user_group', 'REPLACE INTO user_groups(user_id,groupId,gradeId,active) VALUES(@user_id,@groupId,@gradeId,1)')
zero.prepare('vRP/rem_user_group', 'DELETE FROM user_groups WHERE user_id = @user_id AND groupId = @groupId')
zero.prepare('vRP/updt_user_group', 'UPDATE user_groups SET gradeId = @gradeId WHERE user_id = @user_id AND groupId = @groupId')
zero.prepare('vRP/updt_user_active', 'UPDATE user_groups SET active = @active WHERE user_id = @user_id AND groupId = @groupId')
---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------
-- MONEY.LUA
---------------------------------------------------------------------------------------------------------------------------------
zero.prepare('zero_framework/money_init_user','INSERT IGNORE INTO user_moneys(user_id,wallet,bank) VALUES(@user_id,@wallet,@bank)')
zero.prepare('zero_framework/getAllMoney', 'select wallet, bank, paypal from user_moneys where user_id = @user_id')
zero.prepare('zero_framework/getWalletMoney', 'select wallet from user_moneys where user_id = @user_id')
zero.prepare('zero_framework/getBankMoney', 'select bank from user_moneys where user_id = @user_id')
zero.prepare('zero_framework/getPaypalMoney', 'select paypal from users where id = @user_id')
zero.prepare('zero_framework/setMoney', 'update user_moneys set wallet = @wallet where user_id = @user_id')
zero.prepare('zero_framework/setBankMoney', 'update user_moneys set bank = @bank where user_id = @user_id')
zero.prepare('zero_framework/setPaypalMoney', 'update users set paypal = @paypal where id = @user_id')
---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------
-- IDENTITY.LUA
---------------------------------------------------------------------------------------------------------------------------------
zero.prepare("vRP/get_user_identity","SELECT * FROM user_identities WHERE user_id = @user_id")
zero.prepare("vRP/init_user_identity","INSERT IGNORE INTO user_identities(user_id,registration,phone,lastname,firstname,age) VALUES(@user_id,@registration,@phone,@lastname,@firstname,@age)")
zero.prepare("vRP/update_user_identity","UPDATE user_identities SET lastname = @lastname, firstname = @firstname, age = @age, registration = @registration, phone = @phone WHERE user_id = @user_id")
zero.prepare("vRP/get_userbyreg","SELECT user_id FROM user_identities WHERE registration = @registration")
zero.prepare("vRP/get_userbyplate","SELECT user_id FROM user_vehicles WHERE plate = @plate")
zero.prepare("vRP/get_userbyphone","SELECT user_id FROM user_identities WHERE phone = @phone")
zero.prepare("vRP/update_user_first_spawn","UPDATE user_identities SET lastname = @lastname, firstname = @firstname, age = @age WHERE user_id = @user_id")
---------------------------------------------------------------------------------------------------------------------------------