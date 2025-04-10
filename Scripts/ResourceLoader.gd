extends Node

var currencies = {} 
var structures = {}
var characters = {}
var gathering_skills = {}
var gathering_upgrades = {}
var upgrade_list = {}

func _ready():
	_load_currencies()
	_load_structures()
	_load_characters()
	_load_gathering_skills()
	_load_gathering_upgrades()
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
		print('Registered character key: ' + character.display_name)
	pass
	
func _load_gathering_skills():
	for file in DirAccess.get_files_at(Globals.gathering_activities_folder_path):
		var gathering = load(Globals.gathering_activities_folder_path + file)
		gathering_skills[gathering.gathering_activity_id] = gathering
		#Globals.unlocked_upgrades.get_or_add(gathering.gathering_activity_id)
		#Globals.unlocked_upgrades[gathering.gathering_activity_id] = []
		print("Registered gathering activity: " + gathering.verb + " " + gathering.name + " with ID: " + str(gathering.gathering_activity_id))
	print(Globals.unlocked_upgrades)
	pass
	
func _load_gathering_upgrades():
	for file in DirAccess.get_files_at(Globals.gathering_upgrades_folder_path):
		var upgrade = load(Globals.gathering_upgrades_folder_path + file)
		upgrade_list[upgrade.upgrade_id] = upgrade
		if gathering_upgrades.get(upgrade.associated_gathering_activity) == null:
			gathering_upgrades[upgrade.associated_gathering_activity] = []
		gathering_upgrades[upgrade.associated_gathering_activity].append(upgrade.upgrade_id)
		
	for upgrade_key in gathering_upgrades:
		#gathering_upgrades[upgrade_key].sort_custom(_sort_by_upgrade_order)
		gathering_upgrades[upgrade_key].sort()
		for upgrade in gathering_upgrades[upgrade_key]:
			print("Registered " + upgrade_list[upgrade].upgrade_name +" upgrade for resource: " + str(upgrade_key) + " with upgrade order: " + str(gathering_upgrades[upgrade_key]))
	pass
	

func _get_all_structures():
	return structures
	
func _get_all_currencies():
	return currencies
	
func _get_all_characters():
	return characters
	
func _get_all_gathering_skills():
	return gathering_skills
	
func _get_upgrade_detials_from_upgrade_id(upgrade_id):
	return upgrade_list.get(upgrade_id)
	
	
	
