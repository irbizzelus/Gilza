-- Spoof our custom perk decks if desired
local orig_skilltreemanager_pack_string = SkillTreeManager.pack_to_string
function SkillTreeManager:pack_to_string()
	if not Gilza or not Gilza.custom_specialization_indexes or not Gilza.settings.spoof_custom_perks then
		return orig_skilltreemanager_pack_string(self)
	end

	local current_specialization = self:digest_value(self._global.specializations.current_specialization, false, 1)
	if current_specialization ~= Gilza.custom_specialization_indexes.brawler and current_specialization ~= Gilza.custom_specialization_indexes.junkie then
		return orig_skilltreemanager_pack_string(self)
	end
	
	if current_specialization == Gilza.custom_specialization_indexes.brawler then
		current_specialization = 3
	else
		current_specialization = 6
	end

	local packed_string = ""

	for tree, data in ipairs(tweak_data.skilltree.trees) do
		local points, num_skills = managers.skilltree:get_tree_progress_new(tree)
		packed_string = packed_string .. tostring(points)

		if tree ~= #tweak_data.skilltree.trees then
			packed_string = packed_string .. "_"
		end
	end

	local tree_data = self._global.specializations[current_specialization]

	if tree_data then
		local tier_data = tree_data.tiers

		if tier_data then
			local current_tier = self:digest_value(tier_data.current_tier, false)
			if current_tier ~= 9 then
				current_tier = 9
			end
			packed_string = packed_string .. "-" .. tostring(current_specialization) .. "_" .. tostring(current_tier)
		end
	end

	return packed_string
end