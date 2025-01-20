extends Resource
class_name Structure

@export_enum(
	"Stronghold",
	"Warehouse",
	"Den",
	"Tower",
	"Store",
	"Foundry",
	"Tavern",
	"Manor"
) var display_name : String

@export_multiline var description : String
@export var icon : Texture
@export var picture : Texture

@export var locked : bool = true
@export var unlocked_class : Character
@export var unlock_requirements = {
}
