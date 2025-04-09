extends Resource
class_name ResourceGatheringStat

const ComplexCost = preload("res://Scripts/Currency/ComplexCost.gd")

const CharacterEnum = preload("res://Enums/character_enum.gd")


@export
var gathering_activity_id : GatheringActivityEnum.GATHERING_ACTIVITIES
@export
var name : String
@export
var verb : String
@export
var max_val : float = 100
@export
var min_val : float
@export
var step : float = 1
@export
var base_quantity : int
@export
var multiplier : float
@export
var description : String
@export
var modified_gathering : int
# This is a list of ComplexCosts?
@export
var inputs : Dictionary

# This is a dict of Currencies or Items + quantity
@export
var outputs : Dictionary

@export
var character : CharacterEnum.CHARACTERS

@export
var unlock_dependencies = []

@export
var upgrade_chain = [] #Type Upgrade, Upgrade has an _apply_upgrade


func _process_gathering():
	for step in upgrade_chain:
		if Globals.unlocks[step.unlock_flag] == true:
			step._apply_upgrade()


func _init():
	pass
