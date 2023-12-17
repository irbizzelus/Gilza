-- override grenade anti cheat check, to use normal grenade amounts instead of our smaller ones @10
function NetworkPeer:verify_grenade(value)
	local grenade_id = self:grenade_id()
	local tweak_entry = grenade_id and tweak_data.blackmarket.projectiles[grenade_id]

	if tweak_entry.base_cooldown then
		return true
	end
	
	if grenade_id == "frag_com" then
		tweak_entry.max_amount = 3
	elseif grenade_id == "dada_com" then
		tweak_entry.max_amount = 3
	elseif grenade_id == "frag" then
		tweak_entry.max_amount = 3
	elseif grenade_id == "dynamite" then
		tweak_entry.max_amount = 3
	elseif grenade_id == "fir_com" then
		tweak_entry.max_amount = 6
	elseif grenade_id == "molotov" then
		tweak_entry.max_amount = 3
	elseif grenade_id == "wpn_gre_electric" then
		tweak_entry.max_amount = 4
	elseif grenade_id == "wpn_prj_four" then
		tweak_entry.max_amount = 10
	elseif grenade_id == "wpn_prj_ace" then
		tweak_entry.max_amount = 21
	elseif grenade_id == "wpn_prj_hur" then
		tweak_entry.max_amount = 3
	elseif grenade_id == "wpn_prj_jav" then
		tweak_entry.max_amount = 3
	elseif grenade_id == "wpn_prj_target" then
		tweak_entry.max_amount = 6
	elseif grenade_id == "concussion" then
		tweak_entry.max_amount = 6
	end
	
	
	local max_amount = tweak_entry and tweak_entry.max_amount or tweak_data.equipments.max_amount.grenades
	max_amount = managers.modifiers:modify_value("PlayerManager:GetThrowablesMaxAmount", max_amount)
	if self._grenades and max_amount < self._grenades + value then
		if Network:is_server() then
			self:mark_cheater(VoteManager.REASON.many_grenades, true)
		else
			managers.network:session():server_peer():mark_cheater(VoteManager.REASON.many_grenades, Network:is_server())
		end

		print("[NetworkPeer:verify_grenade]: Failed to use grenade", self:id(), self._grenades, value)

		return false
	end

	self._grenades = self._grenades and self._grenades + value or value

	return true
end