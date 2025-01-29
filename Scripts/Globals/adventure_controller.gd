extends Node

var current_arc : Arc = preload("res://Scripts/Arc/ArcResources/Lower Steyerian Mountains.tres")
var current_adventure_index : int = 0
var current_items_gained : Array[Object]
var current_currencies_gained : Array[Currency]
var member_encounter : Encounter
var adventure_running : bool = false
var adventure_status : ADVENTURE_STATUS = ADVENTURE_STATUS.READY
var party : Array[Character] = [null, null, null, null]
var party_panels : Array[PanelContainer]
var adventure_panels : Array[Button]
var current_encounter : Encounter
var total_encounter_count : int
var current_encounter_count : int = 0

enum ADVENTURE_STATUS {
	READY,
	RUNNING,
	SUCCESS,
	ABANDONED,
	FAIL
}

signal update_character_animation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_adventure():	
	# Set adventure status to running
	adventure_status = ADVENTURE_STATUS.RUNNING
	
	Globals.adventure_started.emit()
	
	print("\n[AdventureController] %s adventure started" % current_arc.adventures[current_adventure_index].display_name)
	
	# Wait until encounters are handled
	await handle_encounters()
	
	print("\n---------------------- ADVENTURE RESULTS ------------------------")
	# When encounters done, handle adventure status to resolve end of adventure
	match adventure_status:
		ADVENTURE_STATUS.SUCCESS:
			adventure_success()
		
		ADVENTURE_STATUS.ABANDONED:
			adventure_abandoned()
		
		ADVENTURE_STATUS.FAIL:
			adventure_fail()


func handle_encounters():
	var current_adventure : Adventure = current_arc.adventures[current_adventure_index] # Get current Adventure selected in Arc by index
	var number_of_encounters : int = current_adventure.calculate_number_of_encounters()
	
	print("[AdventureController] Handling %d(%d + %dd%d) encounters for %s" % [number_of_encounters, current_adventure.base_number_of_encounters, current_adventure.variance_number_of_encounter["quantity"], current_adventure.variance_number_of_encounter["magnitude"], current_adventure.display_name])
	
	current_encounter_count = 0
	total_encounter_count = number_of_encounters
	
	for count in number_of_encounters: 
		if adventure_status != ADVENTURE_STATUS.RUNNING: # If not adventuring, end handling encounters
			return
			
		current_encounter_count = count
		
		print("\n---------------------- GENERATED ENCOUNTER ----------------------")
		print("[AdventureController] Encounter progress: %d / %d" % [current_encounter_count, total_encounter_count])
		
		var generated_encounter = current_adventure.generate_encounter()
		print("[AdventureController] Selected Encounter: %s" % generated_encounter.display_name)
		
		# Set current encounter to generated encounter
		current_encounter = generated_encounter
		
		# Get success result from resolving encounter
		var current_encounter_result = await resolve_current_encounter()
		current_encounter.reset()
		
		# If encounter was successful, resolve loot and move to next adventure
		if current_encounter_result == true:
			print("[AdventureController] Encounter success!")
			if current_encounter.check_if_unlocks_member():
				current_encounter.unlock_member()
				
			print("[AdventureController] Items gained during adventure added to player items")
			for items in current_items_gained: # Add all items to Player Vault
				pass
			
			print("[AdventureController] Currencies gained during adventure added to player wallet")
			for currency in current_currencies_gained: # Add all currencies to Player Wallet
				pass
				
			continue
		
		print("Encounter Failed!")
		
		# If encounter was failed and was blocking, end adventure
		if current_encounter.check_blocking() == true:
			print("[AdventureController] Adventure failed because party failed a blocking encounter")
			adventure_status == ADVENTURE_STATUS.FAIL # Adventure failed
			return
	
	# If all encounters resolved and adventure still running, adventure was success
	print("\n[AdventureController] All %d encounters resolved for %s, success!" % [number_of_encounters, current_adventure.display_name])
	if adventure_status == ADVENTURE_STATUS.RUNNING:
		adventure_status = ADVENTURE_STATUS.SUCCESS

func resolve_current_encounter() -> bool:
	var encounter_succeeded : bool = false
	var encounter_success_flag : bool = false
	
	print("[AdventureController] %s encounter Started" % current_encounter.display_name)
	
	var encounter_skills = current_encounter.get_skills()
	
	match current_encounter.get_skill_check_type():
		EncounterEnums.ENCOUNTER_SKILL_CHECK_TYPE.TARGETED:
			# Add encounter to adventure text scroll
			Globals.add_adventure_text.emit("Party encountered a %s!" % current_encounter.display_name)
			
			print("[AdventureController] %s type is Targeted" % current_encounter.display_name)
			# Get first match for skill from party based on marching order and priority
			for encounter_skill : Skill in encounter_skills:
				var lowest_skill_order_index : int = 100000
				var targeted_member : Character # Default to first party member
				
				await TimerController.wait(current_encounter.get_time_in_seconds())
			
				# If not adventuring, end handling encounters
				if adventure_status != ADVENTURE_STATUS.RUNNING:
					return false
				
				for member : Character in party :
					if member is not Character: # If member slot not filled by character, go to next member
						continue
						
					if member.get_health() <= 0: # If member dead, go to next member
						continue
					
					# If party member's skill priority index is less than target member's, replace targeted member
					var index : int = member.get_skills_order().find(encounter_skill.skill_id)
					print("[AdventureController] %s index for %d is %d" % [member.display_name, encounter_skill.skill_id, index])
					if index < lowest_skill_order_index:
						lowest_skill_order_index = index
						targeted_member = member
				
				# Attempt to resolve with current skill and target member
				if targeted_member  != null:
					var targeted_member_result = targeted_member.calculate_skill_roll(encounter_skill.skill_id)
					var encounter_skill_result = current_encounter.calculate_skill_roll(encounter_skill.skill_id)
					var result = Roller._attack_versus_defend(targeted_member_result, encounter_skill_result)
					if result > 0: # Success
						print("%s was successful against %s using the %d skill!" % [targeted_member.display_name, current_encounter.display_name, encounter_skill.skill_id])
						Globals.add_adventure_text.emit("%s succeeded against the %s!" % [targeted_member.display_name, current_encounter.display_name])
						return true
					
					Globals.add_adventure_text.emit("%s failed against the %s!" % [targeted_member.display_name, current_encounter.display_name])
					continue
					
				# If not member targeted then all dead, failed encounter
				Globals.add_adventure_text.emit("Party is Dead!")
				return false
			# If no encounter skills, error and return false
			push_error("[AdventureController] No Skills in Encounter")

		EncounterEnums.ENCOUNTER_SKILL_CHECK_TYPE.MARCHING_ORDER:
			print("[AdventureController] %s type is Marching Order" % current_encounter.display_name)
			Globals.add_adventure_text.emit("Party entered combat with a %s!" % current_encounter.display_name)
			for member in party: # For every memeber in party, check if valid and alive
				if adventure_status != ADVENTURE_STATUS.RUNNING: # If not adventuring, end handling current encounter
					return false
				
				if member is not Character: # If member slot not filled by character, go to next member
					continue
				
				if member.get_health() <= 0: # If member dead, go to next member
					continue
					
				Globals.add_adventure_text.emit("%s is fighting a %s!" % [member.display_name, current_encounter.display_name])
				
				# While both member and enemy are alive, fight
				while(member.get_health() > 0 && current_encounter.get_health() > 0):
					await TimerController.wait(current_encounter.get_time_in_seconds())
			
					# If not adventuring, end handling encounters
					if adventure_status != ADVENTURE_STATUS.RUNNING: 
						return false
					
					# Resolve Member Attacking
					member_attack_current_encounter(member)
					
					# If enemy died from attack, encounter success
					if current_encounter.health <= 0:
						Globals.add_adventure_text.emit("%s is dead, success!" % current_encounter.display_name)
						return true
					
					# Resolve Enemy Attacking
					current_encounter_attack_member(member)
					
					if member.get_health() <= 0:
						Globals.add_adventure_text.emit("%s has died!" % member.display_name)
			
			# If enemy is dead, encounter success
			if current_encounter.health <= 0:
				Globals.add_adventure_text.emit("%s is dead, success!" % current_encounter.display_name)
				return true
			
			# If all members dead, failed adventure and encounter
			print("[AdventureController] Adventure failed because party died")
			adventure_status = ADVENTURE_STATUS.FAIL
			Globals.add_adventure_text.emit("Party is Dead!")
			return false
			
		EncounterEnums.ENCOUNTER_SKILL_CHECK_TYPE.GROUP_SUCCESS:
			print("[AdventureController] %s type is Group Success" % current_encounter.display_name)
			var success_count :int = 0
			var fail_count : int = 0
			
			var skill_id = current_encounter.get_skills()[0].skill_id
			
			await TimerController.wait(current_encounter.get_time_in_seconds())
			
			# If not adventuring, end handling encounters
			if adventure_status != ADVENTURE_STATUS.RUNNING: 
				return false
			
			for member in party: # For every member in party
				if member is not Character: # If member slot not filled by character, go to next member
					continue
				
				if member.get_health() <= 0: # If member dead, go to next member
					continue
						
				# Challenge first encounter skill with roll
				var member_result = member.calculate_skill_roll(skill_id)
				var encounter_result = current_encounter.calculate_skill_roll(skill_id)
				var result = Roller._attack_versus_defend(member_result, encounter_result)
								
				if result > 0: # If success, increment success count
					success_count += 1
				else: # If fail, increment fail count
					fail_count += 1
			
			if success_count >= fail_count: # If success is equal to or greater than fails, encounter success
				Globals.add_adventure_text.emit("Party collectively beat %s!" % current_encounter.display_name)
				return true
			
			print("[AdventureController] Encounter failed because party failed as a whole")
			Globals.add_adventure_text.emit("Party collectively failed %s!" % current_encounter.display_name)
			return false # If fail is greater than success, fail encounter
			
		EncounterEnums.ENCOUNTER_SKILL_CHECK_TYPE.INDIVIDUAL_SUCCESS:
			print("[AdventureController] %s type is Individual Success" % current_encounter.display_name)
			Globals.add_adventure_text.emit("Party encountered %s!" % current_encounter.display_name)
			var skill_id = current_encounter.get_skills()[0].skill_id
			
			await TimerController.wait(current_encounter.get_time_in_seconds())
			
			# If not adventuring, end handling encounters
			if adventure_status != ADVENTURE_STATUS.RUNNING:
				return false
			
			for member in party: # For every member in party	
				if member is not Character: # If member slot not filled by character, go to next member
					continue
					
				if member.get_health() <= 0: # If member dead, go to next member
					continue
							
				# Challenge first encounter skill with roll
				var member_skill_enum = SkillsEnum.COMBAT_DEFENSE_SKILL[skill_id]
				var encounter_result = current_encounter.calculate_skill_roll(skill_id)
				var member_result = member.calculate_skill_roll(member_skill_enum)
				var result = Roller._attack_versus_defend(encounter_result, member_result)
				
				if result > 0: # Member failed, resolve effects
					member.take_damage(result)
					Globals.update_character.emit(member)
			
			for member in party: # If any member in party is alive, success
				if member is not Character: # If member slot not filled by character, go to next member
					continue
					
				if member.get_health() > 0: 
					Globals.add_adventure_text.emit("Party members survived %s!" % current_encounter.display_name)
					return true
			
			# If all members in party died, fail adventure
			adventure_status == ADVENTURE_STATUS.FAIL # Adventure failed
			Globals.add_adventure_text.emit("Party is Dead!")
			return false
		
		_:
			push_error("[AdventureController] Failed To Get Skill Check Type")
			return false
	
	push_error("[AdventureController] Failed To Resolve Current Encounter")
	return false
	
	
func member_attack_current_encounter(member : Character):
	var member_skill_enum = member.get_first_combat_skill_enum()
	var encounter_skill_enum = SkillsEnum.COMBAT_DEFENSE_SKILL[member_skill_enum]
	print("[AdventureController] Member %d skill is attacking encounter %d skill" % [member_skill_enum, encounter_skill_enum])
	var member_result = member.calculate_skill_roll(member_skill_enum)
	var encounter_result = current_encounter.calculate_skill_roll(encounter_skill_enum)
	current_encounter.take_damage(Roller._attack_versus_defend(member_result, encounter_result))
	print("\t[AdventureController] Roll result: %d" % Roller._attack_versus_defend(member_result, encounter_result))
	print("\t[AdventureController] %s health after attack: %d" % [current_encounter.display_name, current_encounter.get_health()])
	

func current_encounter_attack_member(member : Character):
	var encounter_skill_enum = current_encounter.get_first_combat_skill_enum()
	var member_skill_enum = SkillsEnum.COMBAT_DEFENSE_SKILL[encounter_skill_enum]
	print("[AdventureController] %s %d skill is attacking %s %d skill" % [current_encounter.display_name, encounter_skill_enum, member.display_name, member_skill_enum])
	var encounter_result = current_encounter.calculate_skill_roll(encounter_skill_enum)
	var member_result = member.calculate_skill_roll(member_skill_enum)
	member.take_damage(Roller._attack_versus_defend(encounter_result, member_result))
	print("\t\t[AdventureController] Roll result: %d" % Roller._attack_versus_defend(encounter_result, member_result))
	print("\t\t[AdventureController] %s health after attack: %d" % [member.display_name, member.get_health()])
	Globals.update_character.emit(member)

func encounter_targets_entire_party():
	pass


func adventure_success():	
	print("[AdventureController] %s adventure success :)" %  current_arc.adventures[current_adventure_index].display_name)
	Globals.add_adventure_text.emit("Adventure was successful!")
	end_adventure()
	

func adventure_abandoned():
	print("[AdventureController] %s adventure abandoned :|" %  current_arc.adventures[current_adventure_index].display_name)
	Globals.add_adventure_text.emit("Adventure was abandoned!")
	end_adventure()


func adventure_fail():
	print("[AdventureController] %s adventure fail :(" %  current_arc.adventures[current_adventure_index].display_name)
	Globals.add_adventure_text.emit("Adventure was failed!")
	end_adventure()


func end_adventure():
	# Reset Member Status
	for member in party:
		if member is not Character: # If member slot not filled by character, go to next member
			continue
		
		member.reset()
	
	Globals.adventure_ended.emit()
	
	print("Members have returned and are reset")
	
	adventure_status = ADVENTURE_STATUS.READY # Set adventuring back to ready
	
	# Clear loot and member
	current_currencies_gained.clear()
	current_items_gained.clear()
	member_encounter = null
	
	print("[AdventureController] %s adventure ended and is ready to repeat" % current_arc.adventures[current_adventure_index].display_name)


func add_member_to_party(index, member):
	if party.has(member):
		var member_index = party.find(member) as int
		remove_member_from_party(member_index)
		party_panels[member_index].reset_panel()
		
	party[index] = member


func remove_member_from_party(member_index):
	party[member_index] = null


func fail_current_encounter() -> void:
	# Encounter failed
	current_encounter.fail()
	print("[AdventureController] %s encounter failed :(" % current_encounter.display_name)


func succeed_current_encounter() -> void:
	# Encounter succeeded
	current_encounter.success()
	
	# Generate Loot
	current_items_gained.append_array(current_encounter.generate_reward_items())
	current_currencies_gained.append_array(current_encounter.generate_reward_currencies())
	
	# If current encounter unlocks member, save for if adventure is success
	if current_encounter.check_if_unlocks_member():
		member_encounter = current_encounter
	print("[AdventureController] %s encounter success :)" % current_encounter.display_name)
