extends Node

# Preloaded Scripts
const OptionsEnum = preload('res://Enums/options_enum.gd')
const Upgrade = preload('res://Scripts/Upgrades/Upgrade.gd')
const CurrenciesEnum = preload('res://Enums/currencies_enum.gd')

# Preloaded Scenes
const member_panel_scene = preload("res://Scenes/member_panel.tscn")
const sturcture_panel_scene = preload("res://Scenes/structure_panel.tscn")

# Path Strings
const member_panel_scene_path = "res://Scenes/member_panel.tscn"
const character_resources_folder_path = "res://Scripts/Character/CharacterResources/"
const structure_resources_folder_path = "res://Scripts/Structure/StructureResources/"
const currency_resources_folder_path = "res://Scripts/Currency/CurrencyResources/"
const gathering_activities_folder_path = "res://Scripts/Gathering/Gathering Activities/"

# Game Tick Speed
const wait_time = 0.01

# Global Signals
signal on_selected_character_changed

# Global Game State
var selected_character : Character = GlobalResourceLoader._get_all_characters().get(0) : set = _set_selected_character 

## SAVE GAME DETAILS
var selected_options = {
	"background_image" : OptionsEnum.BackgroundImages.FARM_BACKGROUND,
	"number_format" : OptionsEnum.NumberFormat.MILLION_FORMAT
}

var members_in_party = {
	"FIRST" : Character,
	"SECOND" : Character,
	"THIRD" : Character,
	"FOURTH" : Character
}
var members_on_adventure : bool = false


var owned_characters = [0,1,3,6]


var owned_sturctures = [
	"Stronghold"
]

var structures = [
	"Stronghold",
	"Warehouse",
	"Den",
	"Tower",
	"Store",
	"Foundry",
	"Tavern",
	"Manor"
]

var unlocks = {}


func _ready():
	pass
	

func _set_selected_character(new_character):
	selected_character = new_character
	on_selected_character_changed.emit(selected_character)
		
