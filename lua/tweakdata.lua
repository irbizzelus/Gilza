if not Gilza then
	dofile("mods/Gilza/lua/1_GilzaBase.lua")
end

if tweak_data and tweak_data.projectiles then
	-- high velocity nades
	tweak_data.projectiles.launcher_velocity = deep_clone(tweak_data.projectiles.launcher_frag)
	tweak_data.projectiles.launcher_velocity.launch_speed = 3750
	tweak_data.projectiles.launcher_velocity.name_id = "bm_launcher_frag_velocity"
	tweak_data.weapon_disable_crit_for_damage.launcher_velocity = {explosion = false,fire = false}
	tweak_data.projectiles.launcher_velocity_m32 = deep_clone(tweak_data.projectiles.launcher_velocity)
	tweak_data.weapon_disable_crit_for_damage.launcher_velocity_m32 = {explosion = false,fire = false}
	tweak_data.projectiles.launcher_velocity_china = deep_clone(tweak_data.projectiles.launcher_velocity)
	tweak_data.projectiles.launcher_velocity_china.damage = 96
	tweak_data.weapon_disable_crit_for_damage.launcher_velocity_china = {explosion = false,fire = false}
	tweak_data.projectiles.launcher_velocity_slap = deep_clone(tweak_data.projectiles.launcher_velocity)
	tweak_data.weapon_disable_crit_for_damage.launcher_velocity_slap = {explosion = false,fire = false}

	tweak_data.projectiles.underbarrel_velocity_frag = deep_clone(tweak_data.projectiles.launcher_frag)
	tweak_data.projectiles.underbarrel_velocity_frag.launch_speed = 3750
	tweak_data.projectiles.underbarrel_velocity_frag.name_id = "bm_launcher_underbarrel_velocity_frag"
	tweak_data.weapon_disable_crit_for_damage.underbarrel_velocity_frag = {explosion = false,fire = false}
	tweak_data.projectiles.underbarrel_velocity_frag_groza = deep_clone(tweak_data.projectiles.underbarrel_velocity_frag)
	tweak_data.weapon_disable_crit_for_damage.underbarrel_velocity_frag_groza = {explosion = false,fire = false}
	
	tweak_data.projectiles.crossbow_arrow.damage = 41
	tweak_data.projectiles.crossbow_poison_arrow.damage = 20
	tweak_data.projectiles.crossbow_arrow_exp.damage = 82
	
	tweak_data.projectiles.frankish_arrow.damage = 41
	tweak_data.projectiles.frankish_poison_arrow.damage = 20
	tweak_data.projectiles.frankish_arrow_exp.damage = 82
	
	tweak_data.projectiles.arblast_arrow.damage = 90
	tweak_data.projectiles.arblast_poison_arrow.damage = 60
	tweak_data.projectiles.arblast_arrow_exp.damage = 180
	
	tweak_data.projectiles.ecp_arrow.damage = 20
	tweak_data.projectiles.ecp_arrow_poison.damage = 5
	tweak_data.projectiles.ecp_arrow_exp.damage = 50
	
	tweak_data.projectiles.west_arrow.damage = 50
	tweak_data.projectiles.west_arrow_exp.damage = 100
	tweak_data.projectiles.bow_poison_arrow.damage = 40
	
	tweak_data.projectiles.long_arrow.damage = 130
	tweak_data.projectiles.long_poison_arrow.damage = 60
	tweak_data.projectiles.long_arrow_exp.damage = 250
	
	tweak_data.projectiles.elastic_arrow.damage = 130
	tweak_data.projectiles.elastic_arrow_poison.damage = 60
	tweak_data.projectiles.elastic_arrow_exp.damage = 250
	
	-- throwables that we can adjust for better breakpoints, since they are client authorative. thank fuck.
	tweak_data.projectiles.wpn_prj_ace.damage = 30
	tweak_data.projectiles.wpn_prj_four.damage = 15
	tweak_data.projectiles.wpn_prj_target.damage = 100
	tweak_data.projectiles.wpn_prj_hur.damage = 130
	
end

-- set up weapon hold while ADS'ing with all lmg's and their new bipod states, like wall leaning
if tweak_data and tweak_data.player and tweak_data.player.stances then
	
	-- rpk
	if tweak_data.player.stances.rpk and tweak_data.player.stances.rpk.bipod then
		
		local pivot_shoulder_translation = Vector3(10.6, 27.7166, -4.93564)
		local pivot_shoulder_rotation = Rotation(0.06, -0.085, 0.629)
		local pivot_head_translation = Vector3(0, 28, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.rpk.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.rpk.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		
		local pivot_shoulder_translation = Vector3(10.65, 8, -5.03)
		local pivot_shoulder_rotation = Rotation(0.1, 0, 0)
		local pivot_head_translation = Vector3(0, -3, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.rpk.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.rpk.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.rpk.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.rpk.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.rpk.bipod.shakers.breathing.amplitude = 0
		-- tweak_data.player.stances.rpk.bipod.FOV = nil
		tweak_data.player.stances.rpk.bipod.leaning_offsets = {
			iron_sights = {
				default_lean = {
					rotation = Rotation(0,0,0),
					translation = Vector3(0,0,0)
				},
				right_lean = {
					rotation = Rotation(-0,-0,-36),
					translation = Vector3(-0.92,0,-7.2)
				},
				left_lean = {
					rotation = Rotation(0,0,36),
					translation = Vector3(5,0,5.32)
				}
			},
			scope_adjustment = {
				default = {
					default_lean = {translation = Vector3(-0.03,10,-0.06)},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(0.82,10,-6.67)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(3.15,10,5.8)
					},
					scopemount = {
						wpn_fps_upg_o_ak_scopemount = {
							default_lean = Vector3(-0.02,0,0),
							right_lean = Vector3(0.96,0,0.25),
							left_lean = Vector3(-0.96,0,0.35),
						}
					}
				},
				wpn_fps_upg_o_specter_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(-0.08,10,-0.05)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(2.65,10,-6.08)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(1.25,10,6.48)
					},
					scopemount = {
						wpn_fps_upg_o_ak_scopemount = {
							default_lean = Vector3(-0.05,0,-0.05),
							right_lean = Vector3(1,0,0.25),
							left_lean = Vector3(-0.95,0,0.3),
						}
					}
				},
				wpn_fps_upg_o_cs_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(-0.08,10,-0.06)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(2.75,10,-6.05)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(1.15,10,6.5)
					},
					scopemount = {
						wpn_fps_upg_o_ak_scopemount = {
							default_lean = Vector3(0,0,0),
							right_lean = Vector3(0.98,0,0.25),
							left_lean = Vector3(-0.95,0,0.3),
						}
					}
				},
				wpn_fps_upg_o_hamr_reddot = {
					default_lean = {
						rotation = Rotation(0,0.1,0),
						translation = Vector3(0,10,0)
					},
					right_lean = {
						rotation = Rotation(0,0.2,-36),
						translation = Vector3(2.8,10,-6.1)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(1.1,10,6.5)
					},
					scopemount = {
						wpn_fps_upg_o_ak_scopemount = {
							default_lean = Vector3(-0.05,0,-0.05),
							right_lean = Vector3(1,0,0.25),
							left_lean = Vector3(-0.95,0,0.35),
						}
					}
				},
				wpn_fps_upg_o_atibal = {
					default_lean = {
						rotation = Rotation(0.05,-0.09,0),
						translation = Vector3(0,10,0)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(1.3,10,-6.53)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(2.68,10,5.93)
					},
					scopemount = {
						wpn_fps_upg_o_ak_scopemount = {
							default_lean = Vector3(-0.05,0,-0.05),
							right_lean = Vector3(0.95,0,0.25),
							left_lean = Vector3(-0.95,0,0.35),
						}
					}
				},
				wpn_fps_upg_o_atibal_reddot = {
					default_lean = {
						rotation = Rotation(0,0.1,0),
						translation = Vector3(-0.07,10,-0.2)
					},
					right_lean = {
						rotation = Rotation(0,0.2,-36),
						translation = Vector3(4.3,10,-5.8)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-0.31,10,6.95)
					},
					scopemount = {
						wpn_fps_upg_o_ak_scopemount = {
							default_lean = Vector3(-0.05,0,-0.05),
							right_lean = Vector3(1,0,0.25),
							left_lean = Vector3(-0.95,0,0.35),
						}
					}
				}
			}
		}
		
	end
	
	-- par/ksp58
	if tweak_data.player.stances.par and tweak_data.player.stances.par.bipod then
		
		local pivot_shoulder_translation = Vector3(10.02, 5, -3.94)
		local pivot_shoulder_rotation = Rotation(0, 0, 0) 
		local pivot_head_translation = Vector3(0, 12, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.par.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.par.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		
		local pivot_shoulder_translation = Vector3(10, 5, -3.7)
		local pivot_shoulder_rotation = Rotation(0, 0, 0)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.par.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.par.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.par.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.par.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.par.bipod.shakers.breathing.amplitude = 0
		-- tweak_data.player.stances.par.bipod.FOV = nil
		tweak_data.player.stances.par.bipod.leaning_offsets = {
			iron_sights = {
				default_lean = {
					rotation = Rotation(0,0,0),
					translation = Vector3(0,0,0)
				},
				right_lean = {
					rotation = Rotation(0.8,0,-36),
					translation = Vector3(0.8,-2,-6.5)
				},
				left_lean = {
					rotation = Rotation(-0.3,0.6,36),
					translation = Vector3(3.2,-2,4.5)
				}
			},
			scope_adjustment = {
				default = {
					default_lean = {translation = Vector3(0,12,0.25)},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(1.46,12,-5.78)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(2.33,12,5.99)
					},
				},
				wpn_fps_upg_o_specter_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(-0.02,12,0.3)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(3.31,12,-5.16)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(0.49,12,6.6)
					}
				},
				wpn_fps_upg_o_cs_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,12,0.3)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(3.45,12,-5.1)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(0.36,12,6.68)
					}
				},
				wpn_fps_upg_o_hamr_reddot = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,12,0.3)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(3.35,12,-5)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(0.35,12,6.7)
					}
				},
				wpn_fps_upg_o_atibal = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(-0.01,12,0.25)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(1.92,12,-5.63)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(1.88,12,6.13)
					}
				},
				wpn_fps_upg_o_atibal_reddot = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,12,0)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(5,12,-4.8)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-1.1,12,7.1)
					}
				}
			}
		}
		
	end
	
	-- m60
	if tweak_data.player.stances.m60 and tweak_data.player.stances.m60.bipod then
		
		local pivot_shoulder_translation = Vector3(10.63, 22, 0.05)
		local pivot_shoulder_rotation = Rotation(0.265, -0.25, 0)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.m60.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.m60.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		
		local pivot_shoulder_translation = Vector3(10.65, 14, 0.1)
		local pivot_shoulder_rotation = Rotation(0.23, -0.36, 0.6285)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.m60.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.m60.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.m60.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.m60.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.m60.bipod.shakers.breathing.amplitude = 0
		-- tweak_data.player.stances.m60.bipod.FOV = nil
		tweak_data.player.stances.m60.bipod.leaning_offsets = {
			iron_sights = {
				default_lean = {
					rotation = Rotation(0,0,0),
					translation = Vector3(0,0,0)
				},
				right_lean = {
					rotation = Rotation(0.15,0,-36),
					translation = Vector3(2.12,1.5,-6.15)
				},
				left_lean = {
					rotation = Rotation(-0.32,-0.28,36),
					translation = Vector3(1.85,1.5,6.35)
				}
			},
			scope_adjustment = {
				default = {
					default_lean = {translation = Vector3(0.04,-8,0.02)},
					right_lean = {
						rotation = Rotation(0.2,0,-36),
						translation = Vector3(4.62,-8,-4.04)
					},
					left_lean = {
						rotation = Rotation(-0.4,-0.4,36),
						translation = Vector3(-1.28,-8,6.07)
					},
				},
				wpn_fps_upg_o_specter_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0.05,-8,0.04)
					},
					right_lean = {
						rotation = Rotation(0.1,-0.1,-36),
						translation = Vector3(6.4,-8,-3.4)
					},
					left_lean = {
						rotation = Rotation(-0.4,-0.5,36),
						translation = Vector3(-3.1,-8,6.7)
					}
				},
				wpn_fps_upg_o_cs_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0.06,-8,0)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(6.55,-8,-3.4)
					},
					left_lean = {
						rotation = Rotation(-0.25,-0.3,36),
						translation = Vector3(-3.2,-8,6.7)
					}
				},
				wpn_fps_upg_o_hamr_reddot = {
					default_lean = {
						rotation = Rotation(-0.07,0,0),
						translation = Vector3(0,-8,0)
					},
					right_lean = {
						rotation = Rotation(0.09,0,-36),
						translation = Vector3(6.6,-8,-3.4)
					},
					left_lean = {
						rotation = Rotation(-0.35,-0.4,36),
						translation = Vector3(-3.2,-8,6.8)
					}
				},
				wpn_fps_upg_o_atibal = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0.06,-8,0.02)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(5.01,-8,-3.88)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-1.66,-8,6.09)
					}
				},
				wpn_fps_upg_o_atibal_reddot = {
					default_lean = {
						rotation = Rotation(-0.05,-0.1,0),
						translation = Vector3(0,-8,0)
					},
					right_lean = {
						rotation = Rotation(0.1,0,-36),
						translation = Vector3(8.1,-8,-3.05)
					},
					left_lean = {
						rotation = Rotation(-0.4,-0.4,36),
						translation = Vector3(-4.65,-8,7.15)
					}
				}
			}
		}
		
	end
	
	-- m249
	if tweak_data.player.stances.m249 and tweak_data.player.stances.m249.bipod then
		
		local pivot_shoulder_translation = Vector3(10.716, 4, -0.55)
		local pivot_shoulder_rotation = Rotation(0.1066, -0.084, 0.629)    
		local pivot_head_translation = Vector3(0, 12, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.m249.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.m249.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		
		local pivot_shoulder_translation = Vector3(10.71, -8.3, -0.6)
		local pivot_shoulder_rotation = Rotation(0.1066, -0.085, 0.6285)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.m249.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.m249.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.m249.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.m249.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.m249.bipod.shakers.breathing.amplitude = 0
		-- tweak_data.player.stances.m249.bipod.FOV = nil
		tweak_data.player.stances.m249.bipod.leaning_offsets = {
			iron_sights = {
				default_lean = {
					rotation = Rotation(0,0,0),
					translation = Vector3(0,0,0)
				},
				right_lean = {
					rotation = Rotation(0,0,-36),
					translation = Vector3(1.71,1.5,-6.35)
				},
				left_lean = {
					rotation = Rotation(0,0,36),
					translation = Vector3(2.32,1.5,6.2)
				}
			},
			scope_adjustment = {
				default = {
					default_lean = {translation = Vector3(-0.02,0,-0.06)},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(3.77,0,-5.76)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(0.25,0,6.78)
					},
				},
				wpn_fps_upg_o_specter_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,0,-0.06)
					},
					right_lean = {
						rotation = Rotation(-0.05,-0.05,-36),
						translation = Vector3(5.62,0,-5.15)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-1.6,0,7.39)
					}
				},
				wpn_fps_upg_o_cs_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,0,-0.06)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(5.76,0,-5.12)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-1.71,0,7.46)
					}
				},
				wpn_fps_upg_o_hamr_reddot = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,0,0)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(5.8,0,-5.05)
					},
					left_lean = {
						rotation = Rotation(-0.1,-0.1,36),
						translation = Vector3(-1.65,0,7.5)
					}
				},
				wpn_fps_upg_o_atibal = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(-0.01,0,-0.07)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(4.25,0,-5.61)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-0.21,0,6.93)
					}
				},
				wpn_fps_upg_o_atibal_reddot = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,0,0)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(7.3,0,-4.8)
					},
					left_lean = {
						rotation = Rotation(-0.1,-0.1,36),
						translation = Vector3(-3.2,0,7.9)
					}
				}
			}
		}
		
	end
	
	-- mg42
	if tweak_data.player.stances.mg42 and tweak_data.player.stances.mg42.bipod then
		
		local pivot_shoulder_translation = Vector3(10.74, 10, 0.87)
		local pivot_shoulder_rotation = Rotation(0.1, -0.02, 0)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.mg42.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.mg42.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		
		local pivot_shoulder_translation = Vector3(10.72, 8, 0.82)
		local pivot_shoulder_rotation = Rotation(0.106, -0.086, 0)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.mg42.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.mg42.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.mg42.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.mg42.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.mg42.bipod.shakers.breathing.amplitude = 0
		-- tweak_data.player.stances.mg42.bipod.FOV = nil
		tweak_data.player.stances.mg42.bipod.leaning_offsets = {
			iron_sights = {
				default_lean = {
					rotation = Rotation(0,0,0),
					translation = Vector3(0,0,0)
				},
				right_lean = {
					rotation = Rotation(0,0,-36),
					translation = Vector3(2.52,0,-6.15)
				},
				left_lean = {
					rotation = Rotation(-0.07,0,36),
					translation = Vector3(1.535,-5,6.41)
				}
			},
			scope_adjustment = {
				default = {
					default_lean = {translation = Vector3(-0.02,-2,-0.08)},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(3.95,-2,-5.75)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(0.1,-2,6.84)
					},
				},
				wpn_fps_upg_o_specter_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(-0.06,-2,-0.04)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(5.75,-2,-5.15)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-1.77,-2,7.5)
					}
				},
				wpn_fps_upg_o_cs_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(-0.05,-2,-0.05)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(5.88,-2,-5.1)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-1.9,-2,7.52)
					}
				},
				wpn_fps_upg_o_hamr_reddot = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,-2,0)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(5.9,-2,-5.05)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-1.92,-2,7.55)
					}
				},
				wpn_fps_upg_o_atibal = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(-0.02,-2,-0.087)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(4.4,-2,-5.6)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-0.37,-2,6.99)
					}
				},
				wpn_fps_upg_o_atibal_reddot = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,-2,0)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(7.4,-2,-4.69)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-3.35,-2,8)
					}
				}
			}
		}
		
	end
	
	-- hk21
	if tweak_data.player.stances.hk21 and tweak_data.player.stances.hk21.bipod then
		
		local pivot_shoulder_translation = Vector3(8.54, 8, -3.29)
		local pivot_shoulder_rotation = Rotation(0, 0, 0)     
		local pivot_head_translation = Vector3(0, 10, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.hk21.steelsight.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.hk21.steelsight.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		
		local pivot_shoulder_translation = Vector3(8.545, 5.8, -3.35)
		local pivot_shoulder_rotation = Rotation(0, 0, 0)
		local pivot_head_translation = Vector3(0, 0, 0)
		local pivot_head_rotation = Rotation(0, 0, 0)
		tweak_data.player.stances.hk21.bipod.shoulders.translation = pivot_head_translation - pivot_shoulder_translation:rotate_with(pivot_shoulder_rotation:inverse()):rotate_with(pivot_head_rotation)
		tweak_data.player.stances.hk21.bipod.shoulders.rotation = pivot_head_rotation * pivot_shoulder_rotation:inverse()
		tweak_data.player.stances.hk21.bipod.vel_overshot.pivot = pivot_shoulder_translation + Vector3(0, -0, 0)
		tweak_data.player.stances.hk21.bipod.shakers = {breathing = {}}	
		tweak_data.player.stances.hk21.bipod.shakers.breathing.amplitude = 0
		-- tweak_data.player.stances.hk21.bipod.FOV = nil
		tweak_data.player.stances.hk21.bipod.leaning_offsets = {
			iron_sights = {
				default_lean = {
					rotation = Rotation(0,0,0),
					translation = Vector3(0,0,0)
				},
				right_lean = {
					rotation = Rotation(0,0,-36),
					translation = Vector3(-0.3,0.25,-5.65)
				},
				left_lean = {
					rotation = Rotation(0,0,36),
					translation = Vector3(3.6,0.25,4.4)
				}
			},
			scope_adjustment = {
				default = {
					default_lean = {translation = Vector3(0,8,-0.05)},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(1.6,8,-5.09)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(1.7,8,4.95)
					},
				},
				wpn_fps_upg_o_specter_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,8,-0.03)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(3.45,8,-4.48)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-0.16,8,5.52)
					}
				},
				wpn_fps_upg_o_cs_piggyback = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,8,0)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(3.55,8,-4.45)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-0.3,8,5.58)
					}
				},
				wpn_fps_upg_o_hamr_reddot = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,8,0)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(3.5,8,-4.4)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-0.3,8,5.6)
					}
				},
				wpn_fps_upg_o_atibal = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,8,-0.05)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(2.04,8,-4.94)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(1.22,8,5.09)
					}
				},
				wpn_fps_upg_o_atibal_reddot = {
					default_lean = {
						rotation = Rotation(0,0,0),
						translation = Vector3(0,8,0)
					},
					right_lean = {
						rotation = Rotation(0,0,-36),
						translation = Vector3(5.1,8,-4.1)
					},
					left_lean = {
						rotation = Rotation(0,0,36),
						translation = Vector3(-1.8,8,6)
					}
				}
			}
		}
		
	end
	
end

-- overrides total ammo mod table to enable support for float values for total_ammo_mod, while keeping older values the same.
-- goes up to 20000 entries aka 200 total_ammo_mod max. base game has 20k entries at 20k total_ammo_mod max, thus the limit
-- techincally can be increased to include the base game limit of 1000x times the max ammo, but screw that
-- i dont think anyone should be able to use total_ammo_mod with values over 2x max ammo anyway, with only exceptions being some weird custom guns
-- so, this func here provides a limit of 10x, to avoid using more memory then this table would in the base game.
local function Override_total_ammo_mod_values()
	tweak_data.weapon.stats.total_ammo_mod = {}
	local mod_value = -1
	for i=1,200, 0.01 do
		i = math.floor(i * 1000 + 0.5)
		i = i / 1000
		mod_value = math.floor(mod_value * 100000 + 0.5)
		mod_value = mod_value / 100000
		tweak_data.weapon.stats.total_ammo_mod[i] = mod_value
		mod_value = mod_value + 0.0005
	end
end
Override_total_ammo_mod_values()