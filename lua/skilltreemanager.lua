-- Spoof our custom perk decks if desired
local last_sent_perk_sync = "vanilla"
local orig_skilltreemanager_pack_string = Hooks:GetFunction(SkillTreeManager, "pack_to_string")
Hooks:OverrideFunction(SkillTreeManager, "pack_to_string", function (self)
	
	-- failsafe
	if not Gilza.custom_specialization_indexes then
		return orig_skilltreemanager_pack_string(self)
	end
	
	-- figure out what we have and prepare spoof ids
	local current_specialization = self:digest_value(self._global.specializations.current_specialization, false, 1)
	local spoof_as = current_specialization
	local deck_sync_str = "vanilla"
	if current_specialization == Gilza.custom_specialization_indexes.brawler then
		spoof_as = 3 -- armorer
		deck_sync_str = "brawler"
	elseif current_specialization == Gilza.custom_specialization_indexes.junkie then
		deck_sync_str = "junkie"
		spoof_as = 6 -- crook
	elseif current_specialization == Gilza.custom_specialization_indexes.guardian then
		deck_sync_str = "guardian"
		spoof_as = 2 -- muscle
	end
	
	-- gilza to gilza player sync, always happens
	if last_sent_perk_sync ~= deck_sync_str then
		last_sent_perk_sync = deck_sync_str
		for i=1, 4 do
			if Gilza.peers_with_mod[i].has_Gilza and not (managers.network:session():local_peer():id() == i) then
				LuaNetworking:SendToPeer(i, "Gilza_peer_sync", "Equipped_perk_deck_"..tostring(deck_sync_str))
			end
		end
	end
	
	-- if spoof is disabled return standard string
	if not Gilza.settings.spoof_custom_perks then
		return orig_skilltreemanager_pack_string(self)
	end

	-- if non-gilza or vanilla deck is used return standard string
	if current_specialization ~= Gilza.custom_specialization_indexes.brawler and current_specialization ~= Gilza.custom_specialization_indexes.junkie and current_specialization ~= Gilza.custom_specialization_indexes.guardian then
		return orig_skilltreemanager_pack_string(self)
	end
	
	-- otherwise spoof
	local packed_string = ""
	for tree, data in ipairs(tweak_data.skilltree.trees) do
		local points, num_skills = managers.skilltree:get_tree_progress_new(tree)
		packed_string = packed_string .. tostring(points)

		if tree ~= #tweak_data.skilltree.trees then
			packed_string = packed_string .. "_"
		end
	end

	local tree_data = self._global.specializations[spoof_as]

	if tree_data then
		local tier_data = tree_data.tiers

		if tier_data then
			local current_tier = self:digest_value(tier_data.current_tier, false)
			if current_tier ~= 9 then
				current_tier = 9 -- always spoof it to be maxed out. ngl idk why i added this
			end
			packed_string = packed_string .. "-" .. tostring(spoof_as) .. "_" .. tostring(current_tier)
		end
	end

	return packed_string
end)