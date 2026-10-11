-- new func needed for fully loaded temporary bulletstorm buff. kinda weird how this manager never needed a duration check function
function TemporaryPropertyManager:get_property_end_time(prop)
	
	if self:has_active_property(prop) and self._properties[prop][2] then
		return self._properties[prop][2]
	end
	
	return nil

end