extends Resource
class_name Adventure

@export_category("Information")
@export var adventure_id : AdventureEnum.ADVENTURE
@export var display_name : String
@export var description : String
@export var type : AdventureEnum.ADVENTURE_TYPE
@export var unlocked : bool = false

@export_category("Generation/Weights")
@export var base_number_of_encounters : int = 0
@export var variance_number_of_encounters = {
	"quantity" = 1,
	"magnitude" = 4
}
@export var encounters = {}

@export_category("Stats")
@export var completed : bool = false
@export var completed_count : int = 0
@export var next_adventure_id : AdventureEnum.ADVENTURE

func get_display_name() -> String:
	return display_name

func get_description():
	return description

func get_type() -> AdventureEnum.ADVENTURE_TYPE:
	return type

func get_unlocked() -> bool:
	return unlocked
	
func get_next_adventure_id() -> int:
	return next_adventure_id

func get_variance_number_of_encounters():
	return variance_number_of_encounters

func get_base_number_of_encounters():
	return base_number_of_encounters

func unlock():
	print("%s Adventure Unlocked!" % display_name)
	unlocked = true
	Globals.refresh_adventure_panels.emit()

func calculate_number_of_encounters():
	return base_number_of_encounters + Roller._die_roll(variance_number_of_encounters["quantity"], variance_number_of_encounters["magnitude"])

func generate_encounter() -> Encounter:
	var weighted_encounters : Array[WeightedOption]
	
	for encounter in encounters:
		if encounter.check_valid() == false:
			continue
		
		var weighted_encounter = WeightedOption.new(encounter, encounters[encounter])
		weighted_encounters.append(weighted_encounter)
	
	var encounter_frequencies = Roller._roll_weighted(weighted_encounters, 1)
	
	var selected_encounter : Encounter
	for encounter in encounter_frequencies:
		if encounter_frequencies[encounter] == 1:
			selected_encounter = encounter
			break
		
	print("[Adventure.gd] %s encounter generated" % selected_encounter.get_display_name())
	
	return selected_encounter


func adventure_succeeded():
	# Set completed flag to true if false
	if completed == false:
		completed = true
	
	# Increment completed amount
	completed_count += 1
