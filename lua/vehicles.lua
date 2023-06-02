if Gilza then

	local newFOV = math.clamp(Gilza.settings.v_fov, 75, 105)

	Hooks:PostHook( VehicleTweakData , "_init_data_falcogini" , "gib_falcofov" , function( self , params )
		self.falcogini.fov = newFOV
	end)

	Hooks:PostHook( VehicleTweakData , "_init_data_muscle" , "gib_musclefov" , function( self , params )
		self.muscle.fov = newFOV
	end)

	Hooks:PostHook( VehicleTweakData , "_init_data_forklift" , "gib_forkliftfov" , function( self , params )
		self.forklift.fov = newFOV
	end)

	Hooks:PostHook( VehicleTweakData , "_init_data_forklift_2" , "gib_forklift2fov" , function( self , params )
		self.forklift_2.fov = newFOV
	end)

	Hooks:PostHook( VehicleTweakData , "_init_data_box_truck_1" , "gib_boxtruckfov" , function( self , params )
		self.box_truck_1.fov = newFOV
	end)
	-- unused vehicle
	Hooks:PostHook( VehicleTweakData , "mower_1" , "gib_lawnmemerfov" , function( self , params )
		self.mower_1.fov = newFOV
	end)

	Hooks:PostHook( VehicleTweakData , "_init_data_boat_rib_1" , "gib_ribfov" , function( self , params )
		self.boat_rib_1.fov = newFOV
	end)

	Hooks:PostHook( VehicleTweakData , "_init_data_blackhawk_1" , "gib_bhfov" , function( self , params )
		self.blackhawk_1.fov = newFOV
	end)

	Hooks:PostHook( VehicleTweakData , "_init_data_bike_1" , "gib_bike1fov" , function( self , params )
		self.bike_1.fov = newFOV
		self.bike_1.camera_limits = {
			driver = { yaw = 170, pitch = 45 }
		}
	end)

	Hooks:PostHook( VehicleTweakData , "_init_data_bike_2" , "gib_bike2fov" , function( self , params )
		self.bike_2.fov = newFOV
		self.bike_2.camera_limits = {
			driver = { yaw = 170, pitch = 45 }
		}
	end)
	-- is this breakfast in tihuana escape car??
	Hooks:PostHook( VehicleTweakData , "_init_data_wanker" , "gib_wanker" , function( self , params )
		self.wanker.fov = newFOV
	end)
	
	Hooks:PostHook( VehicleTweakData , "_init_data_golfcart" , "gib_golfcart" , function( self , params )
		self.golfcart.fov = newFOV
	end)

end