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

func _ready():

	pass
	


## SAVE GAME DETAILS
var selected_options = {
	"background_image" : OptionsEnum.BackgroundImages.FARM_BACKGROUND,
	"number_format" : OptionsEnum.NumberFormat.MILLION_FORMAT
}

var gathering_activities = []
# Called when the node enters the scene tree for the first time.

var members_in_party = {
	"FIRST" : Character,
	"SECOND" : Character,
	"THIRD" : Character,
	"FOURTH" : Character
}
var members_on_adventure : bool = false

signal on_selected_character_changed

var selected_character : Character : set = _set_selected_character

func _set_selected_character(new_character):
	selected_character = new_character
	on_selected_character_changed.emit(selected_character)
		


var owned_characters = ["Lord", "Fighter", "Quartermaster", "Forester", "Miner"]


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
