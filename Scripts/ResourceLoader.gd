extends Node

var currencies = {} 
var structures = {}
var characters = {}
var gathering_skills = {}
var gathering_skill_timers = {}
var gathering_upgrades = {}
var arcs = {}

func _ready():
	_load_currencies()
	_load_structures()
	_load_characters()
	_load_gathering_skills()
	_load_gathering_upgrades()
	_load_arcs()
	
	_configure_character_skill_order()
	return true

func _load_currencies():
	for file in DirAccess.get_files_at(Globals.currency_resources_folder_path):
		var currency = load(Globals.currency_resources_folder_path + file)
		currencies[currency.currency_id] = currency
		print('Registered currency key: ' + currency.display_name + " ID: " + str(currency.currency_id)) 
	return
	
func _load_structures():
	for file in DirAccess.get_files_at(Globals.structure_resources_folder_path):
		var structure = load(Globals.structure_resources_folder_path + file)
		structures[structure.structure_id] = structure
		print("Registered structure: " + structure.display_name + " with ID: " + str(structure.structure_id))
	pass
	
func _load_characters():
	for file in DirAccess.get_files_at(Globals.character_resources_folder_path):
		var character = load(Globals.character_resources_folder_path + file)
		characters[character.character_id] = character
		print('Registered character key: ' + character.get_display_name())
	pass
	
func _load_gathering_skills():
	for file in DirAccess.get_files_at(Globals.gathering_activities_folder_path):
		var gathering = load(Globals.gathering_activities_folder_path + file)
		gathering_skills[gathering.gathering_activity_id] = gathering
		print("Registered gathering activity: " + gathering.verb + " " + gathering.name + " with ID: " + str(gathering.gathering_activity_id))

	pass

func _load_arcs():
	for file in DirAccess.get_files_at(Globals.arc_folder_path):
		var arc = load(Globals.arc_folder_path + file)
		arcs[arc.arc_id] = arc
	
	print(arcs)
	
func _load_gathering_upgrades():
	pass

func _get_all_structures():
	return structures
	
func _get_all_currencies():
	return currencies
	
func _get_all_characters():
	return characters
	
func _get_all_gathering_skills():
	return gathering_skills

func _get_arcs():
	return arcs
	
func _configure_character_skill_order():
	print("\nCharacter Skill Orders")
	for character in characters:
		var character_resource = characters[character] as Character
		var skill_order : Array[SkillsEnum.SKILLS] 
		skill_order.append_array(CharacterDetails.skill_orders[character_resource.character_id] as Array[SkillsEnum.SKILLS])
		characters[character].set_skills_order(skill_order)
		print("\tInitialized %-15s Skill Order: %s" % [character_resource.get_display_name(), str(skill_order)])
