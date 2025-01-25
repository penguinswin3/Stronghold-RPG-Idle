extends Node
var CurrenciesEnum = preload('res://Enums/currencies_enum.gd')
var upgrade

@onready var member_list: GridContainer = %MemberList
var member_button = preload("res://Scenes/member_button.tscn")

var member_panel = preload("res://Scenes/member_panel.tscn")
var resource_generator_tile = preload("res://Scenes/resource_generator_tile.tscn")
var upgrade_tile = preload('res://Scenes/upgrade_tile.tscn')
var currency_view = preload("res://Scenes/currency_view.tscn")
var currency_static_view = preload("res://Scenes/currency_static_view.tscn")
@onready var resource_summary = %ResourceSummary
@onready var resource_activities = %ResourcesList

var roller = Roller.new()
@onready var structure_list: GridContainer = %StructureList


var ore_count_number_lable
var herb_count_number_lable
var shop_container
var shop_buttons = []
var resource_lables = {}
var resource_timer
var resource_container
var herb_label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file('res://Scenes/Main Menu/MainMenu.tscn')
	pass # Replace with function body.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	_populate_gathering_activities()
	# For each resource belonging to selected character...
		# Add that resource to the summary box 
	Globals.on_selected_character_changed.connect(_populate_resource_upgrade_panel)
	Globals.on_selected_character_changed.connect(_update_displayed_gathering_activities)
	Globals._set_selected_character(GlobalResourceLoader._get_all_characters()[3])
	

	
	var upgrade_scrollable_list = get_node("MainViewVContainer/MainViewPanel/OverviewViewPanel/VaultVContainer/ResourceUpgradeSection/MemberDetailsPanel/UpgradeManagementPanel/UpgradesList")
	upgrade_scrollable_list.add_child(upgrade_tile.instantiate())
	upgrade_scrollable_list.add_child(upgrade_tile.instantiate())
	upgrade_scrollable_list.add_child(upgrade_tile.instantiate())
	upgrade_scrollable_list.add_child(upgrade_tile.instantiate())
	upgrade_scrollable_list.add_child(upgrade_tile.instantiate())
	
	# For every character in owned_characters, instantiate a member_panel,load the class resource into the panel, and add panel as child to member_list

	for character in Globals.owned_characters:
		var new_member_button = member_button.instantiate()
		new_member_button.character = load("res://Scripts/Character/CharacterResources/Combat/" + character + ".tres")
		member_list.add_child(new_member_button)
		
	pass




func _populate_resource_upgrade_panel(selected_character):
	# clear existing stuff
	for child in resource_summary.get_children():
		resource_summary.remove_child(child)
		child.queue_free()

	# Populate all the stuff based on selected character
	## TODO only display unlocked currencies
	for associated_currency in Globals.selected_character.associated_resources:
		var tracked_resource = currency_view.instantiate()
		tracked_resource.currency = Wallet.get_currency(associated_currency)
		Wallet.currency_changed.connect(tracked_resource._update_text)
		resource_summary.add_child(tracked_resource)
	pass

func _update_displayed_gathering_activities(selected_character):
	for child in resource_activities.get_children():
		if child.resource_gathering_stats.gathering_activity_id in GlobalResourceLoader._get_all_characters()[selected_character.character_id].associated_gathering_activities:
			child.visible = true
		else:
			child.visible = false


func _populate_gathering_activities():
	#This should be iterating through the list of gathering skill available to the selected party member
	for gathering_activity in GlobalResourceLoader.gathering_skills:
		var tile = resource_generator_tile.instantiate()
		tile.resource_gathering_stats = GlobalResourceLoader.gathering_skills.get(gathering_activity)
		resource_activities.add_child(tile)

	pass # Replace with function body.
