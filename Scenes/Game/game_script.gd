extends Node
var CurrenciesEnum = preload('res://Enums/currencies_enum.gd')
var upgrade
var roller = Roller.new()


@onready var member_list: GridContainer = %MemberList
var member_panel = preload("res://Scenes/member_panel.tscn")
var resource_tile = preload("res://Scenes/resource_generator_tile.tscn")
var currency_view = preload("res://Scenes/currency_view.tscn")
@onready var structure_list: GridContainer = %StructureList
var complex_cost_display = preload('res://Scenes/ComplexCostDisplay.tscn')

var resource_generator_tile = preload("res://Scenes/resource_generator_tile.tscn")
var upgrade_tile = preload('res://Scenes/upgrade_tile.tscn')
var currency_static_view = preload("res://Scenes/currency_static_view.tscn")
@onready var resource_summary = %ResourceSummary
@onready var resource_activities = %ResourcesList
@onready var upgrades_list = %UpgradesList

@onready var gold_summary_tab = %CurrencyTab

var ore_count_number_lable
var herb_count_number_lable
var shop_container
var shop_buttons = []
var resource_lables = {}
var resource_bar
var resource_container

var resource_timer

var herb_currency_view


var herb_label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file('res://Scenes/Main Menu/MainMenu.tscn')
	pass # Replace with function body.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_populate_character_panel()
	_populate_gathering_activities()
	_populate_structures_panel()
	_populate_upgrades_panel()
	_populate_top_bar_currency()

	SignalBus.on_selected_character_changed.connect(_populate_resource_summary)
	SignalBus.on_selected_character_changed.connect(_update_displayed_gathering_activities)
	SignalBus.on_selected_character_changed.connect(_update_displayed_upgrades)
	# This can later load from the saved state 
	Globals._set_selected_character(GlobalResourceLoader._get_all_characters().get(0))
	
	
	
func _populate_character_panel():
	# For every character in owned_characters, instantiate a member_panel,load the class resource into the panel, and add panel as child to member_list
	for character_id in GlobalResourceLoader._get_all_characters():
		var new_member_panel = Globals.member_panel_scene.instantiate()
		new_member_panel.character = GlobalResourceLoader._get_all_characters()[character_id]
		if character_id not in Globals.owned_characters:
			new_member_panel.visible = false
		member_list.add_child(new_member_panel)
	
func  _populate_structures_panel():
	# For every structure, instantiate a structure_panel, set properties of panel, and add panel as child to structure_list
	for structure_id in GlobalResourceLoader._get_all_structures():
		var new_structure_panel = Globals.sturcture_panel_scene.instantiate()
		new_structure_panel.structure = GlobalResourceLoader._get_all_structures()[structure_id]
		structure_list.add_child(new_structure_panel)

func _populate_resource_summary(selected_character):
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

func _populate_upgrades_panel():
	for upgrade in GlobalResourceLoader.upgrade_list:
		var tile = upgrade_tile.instantiate()
		#var complex_cost_display = complex_cost_display.instantiate()
		tile.associated_gathering_activity = GlobalResourceLoader.upgrade_list[upgrade].associated_gathering_activity
		tile.cost.append_array([ComplexCost.new(1,CurrenciesEnum.CURRENCIES.GOLD_COIN), ComplexCost.new(1,CurrenciesEnum.CURRENCIES.LUMBER)])
		tile.upgrade_name = GlobalResourceLoader.upgrade_list.get(upgrade).upgrade_name
		upgrades_list.add_child(tile)
	pass
	
func _update_displayed_upgrades(selected_character):
	pass

func _populate_top_bar_currency():
	var cview = currency_view.instantiate()
	cview.currency=Wallet.get_currency(CurrenciesEnum.CURRENCIES.GOLD_COIN)
	Wallet.currency_changed.connect(cview._update_text)
	gold_summary_tab.add_child(cview)

func _on_go_button_pressed() -> void:
	Globals.members_on_adventure = true
