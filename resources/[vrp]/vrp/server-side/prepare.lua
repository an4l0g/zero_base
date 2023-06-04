---------------------------------------------------------------------------------------------------------------------------------
-- BASE.LUA
---------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/create_user", "INSERT INTO zero_users(whitelist,banned) VALUES(false,false)")
vRP.prepare("vRP/add_identifier", "INSERT INTO zero_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
vRP.prepare("vRP/userid_byidentifier", "SELECT user_id FROM zero_user_ids WHERE identifier = @identifier")
vRP.prepare("vRP/set_userdata", "REPLACE INTO zero_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
vRP.prepare("vRP/get_userdata", "SELECT dvalue FROM zero_user_data WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("vRP/set_srvdata", "REPLACE INTO zero_srv_data(dkey,dvalue) VALUES(@key,@value)")
vRP.prepare("vRP/get_srvdata", "SELECT dvalue FROM zero_srv_data WHERE dkey = @key")
vRP.prepare("vRP/rem_srv_data", "DELETE FROM zero_srv_data WHERE dkey = @dkey")
vRP.prepare("vRP/get_banned", "SELECT banned FROM zero_users WHERE id = @user_id")
vRP.prepare("vRP/get_identifiers_by_userid", "SELECT identifier FROM zero_user_ids WHERE user_id = @user_id")
vRP.prepare("vRP/set_banned", "UPDATE zero_users SET banned = @banned WHERE id = @user_id")
vRP.prepare("vRP/get_whitelist", "SELECT whitelist FROM zero_users WHERE id = @user_id")
vRP.prepare("vRP/set_whitelist", "UPDATE zero_users SET whitelist = @whitelist WHERE id = @user_id")
vRP.prepare("vRP/set_login", "UPDATE zero_users SET last_login = current_timestamp(), ip = @ip WHERE id = @user_id")
---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------
-- GROUP.LUA
---------------------------------------------------------------------------------------------------------------------------------
vRP.prepare('vRP/get_user_groups', 'SELECT groupId, gradeId, active FROM zero_user_groups WHERE user_id = @user_id')
vRP.prepare('vRP/get_user_group_grade', 'SELECT gradeId FROM zero_user_groups WHERE user_id = @user_id AND groupId = @groupId')
vRP.prepare('vRP/get_user_group_active', 'SELECT active FROM zero_user_groups WHERE user_id = @user_id AND groupId = @groupId')
vRP.prepare('vRP/add_user_group', 'REPLACE INTO zero_user_groups(user_id,groupId,gradeId,active) VALUES(@user_id,@groupId,@gradeId,1)')
vRP.prepare('vRP/rem_user_group', 'DELETE FROM zero_user_groups WHERE user_id = @user_id AND groupId = @groupId')
vRP.prepare('vRP/updt_user_group', 'UPDATE zero_user_groups SET gradeId = @gradeId WHERE user_id = @user_id AND groupId = @groupId')
vRP.prepare('vRP/updt_user_active', 'UPDATE zero_user_groups SET active = @active WHERE user_id = @user_id AND groupId = @groupId')
---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------
-- MONEY.LUA
---------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/money_init_user","INSERT IGNORE INTO zero_user_moneys(user_id,wallet,bank) VALUES(@user_id,@wallet,@bank)")
vRP.prepare("vRP/get_money","SELECT wallet,bank FROM zero_user_moneys WHERE user_id = @user_id")
vRP.prepare("vRP/set_money","UPDATE zero_user_moneys SET wallet = @wallet, bank = @bank WHERE user_id = @user_id")
---------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------
-- IDENTITY.LUA
---------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_user_identity","SELECT * FROM zero_user_identities WHERE user_id = @user_id")
vRP.prepare("vRP/init_user_identity","INSERT IGNORE INTO zero_user_identities(user_id,registration,phone,lastname,firstname,age) VALUES(@user_id,@registration,@phone,@lastname,@firstname,@age)")
vRP.prepare("vRP/update_user_identity","UPDATE zero_user_identities SET lastname = @lastname, firstname = @firstname, age = @age, registration = @registration, phone = @phone WHERE user_id = @user_id")
vRP.prepare("vRP/get_userbyreg","SELECT user_id FROM zero_user_identities WHERE registration = @registration")
vRP.prepare("vRP/get_userbyphone","SELECT user_id FROM zero_user_identities WHERE phone = @phone")
vRP.prepare("vRP/update_user_first_spawn","UPDATE zero_user_identities SET lastname = @lastname, firstname = @firstname, age = @age WHERE user_id = @user_id")
---------------------------------------------------------------------------------------------------------------------------------