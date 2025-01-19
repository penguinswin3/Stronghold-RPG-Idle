extends Character
class_name SocialCharacter

@export_enum(
	# Combat
	
	# Exploration
	"Trap Kit/Bait",
	"Instrument",
	"Trowel",
	"Flint/Tinder",
	"Pickaxe",
	"Felling Axe",
	"Chalks",
	
	#Social
	"Scepter",
	"Clipboard",
	"Lockpicks",
	"Codex",
	"Money Pouch",
	"Hammer",
	"Quill",
	"Goblet"
) var tool_type : String

@export_enum(
	"Stronghold",
	"Warehouse",
	"Den",
	"Tower",
	"Store",
	"Foundry",
	"Tavern",
	"Manor"
) var structure_type : String
