extends Resource
class_name Character


@export var character_id : CharacterEnum.CHARACTERS
@export_enum(
	# Combat
	"Fighter", 
	"Mage",
	"Cleric", 
	"Druid", 
	"Barbarian", 
	"Archer", 
	"Occultist",
	
	# Exploration
	"Hunter", 
	"Bard", 
	"Archeologist", 
	"Pyromancer", 
	"Miner", 
	"Forester", 
	"Diviner",
	
	# Social
	"Lord", 
	"Quartermaster", 
	"Thief", 
	"Artificer", 
	"Merchant", 
	"Blacksmith", 
	"Entrepreneur", 
	"Socialite"
) var display_name : String

@export_multiline var description : String
@export var icon : Texture
@export var picture : Texture

@export_enum(
	# Combat
	"Melee",
	"Arcane",
	"Divine",
	"Primal",
	"Constitution",
	"Ranged",
	"Occult",
	
	# Exploration
	"Hunting",
	"Charming",
	"Archeology",
	"Firemaking",
	"Mining",
	"Woodcutting",
	"Scrying",
	
	# Social
	"Construction",
	"Organization",
	"Thievery",
	"Enchantment",
	"Trading",
	"Crafting",
	"Networking",
	"Charisma"
) var primary_skill : String

@export var level : int = 1
@export var xp : int = 0

@export var current_gather_activity : ResourceGatheringStat
@export var associated_resources = []
@export var associated_gathering_activities = []
