extends Node
var CurrenciesEnum = preload('res://Enums/currencies_enum.gd')
var upgrade

@onready var member_list: GridContainer = %MemberList
var member_button = preload("res://Scenes/member_button.tscn")
var resource_tile = preload("res://Scenes/resource_generator_tile.tscn")
var roller = Roller.new()
@onready var structure_list: GridContainer = %StructureList


var ore_count_number_lable
var herb_count_number_lable
var shop_container
var shop_buttons = []
var resource_lables = {}
var resource_bar
var resource_container
var resource_timer

var herb_label

func _purchase_upgrade(upgrade_name):
	if(Wallet.remove_currency(Globals.upgrades[upgrade_name].cost[0].currency, Globals.upgrades[upgrade_name].cost[0].amount)):
		Globals.upgrades[upgrade_name].cost[0].amount = ceil(Globals.upgrades[upgrade_name].cost[0].amount * Globals.upgrades[upgrade_name].scale_multiplier)
		Globals.upgrades[upgrade_name].count += 1
		#Remove dependency from all other upgrades if they exist
		for upgrade in Globals.upgrades.values():
			upgrade.dependencies.erase(upgrade_name)
			if upgrade.dependencies.size() == 0:
				upgrade.enabled = true
	return
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file('res://Scenes/Main Menu/MainMenu.tscn')
	pass # Replace with function body.


func _on_mine_button_pressed() -> void:
	Wallet.add_currency(CurrenciesEnum.Currencies.ORE, ceil(Globals.upgrades['ore_per_click'].amplitude*Globals.upgrades['ore_per_click'].count))
	#Wallet.currency_changed.emit()
	pass # Replace with function body.
	
func _on_herb_button_pressed() -> void:
	Wallet.add_currency(CurrenciesEnum.Currencies.HERB, ceil(Globals.upgrades['herb_per_click'].amplitude*Globals.upgrades['herb_per_click'].count))
	pass # Replace with function body.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Wallet.currency_changed.connect(_on_currency_change)

	
	# Register characters
	for character in Globals.owned_characters:
		var new_member_button = member_button.instantiate()
		new_member_button.character = load("res://Scripts/Character/CharacterResources/Combat/" + character + ".tres")
		member_list.add_child(new_member_button)
	# Needs to be dynamic
	var resource_summary = get_node("MainViewVContainer/MainViewPanel/OverviewViewPanel/VaultVContainer/ResourceUpgradeSection/MemberDetailsPanel/ResourcesSummaryVContainer/SummaryVContainer/SummaryPanel")
	herb_label = Label.new()
	herb_label.text = "Herbs: {amount}".format({"amount" : str(Wallet.get_currency_count(CurrenciesEnum.Currencies.HERB))})
	resource_summary.add_child(herb_label)

	# Needs to be dynamic
	var resource_scrollable_list = get_node("MainViewVContainer/MainViewPanel/OverviewViewPanel/VaultVContainer/ResourceUpgradeSection/MemberDetailsPanel/ResourcesSummaryVContainer/ResourcesScrollableContainer/ResourcesList")
	resource_scrollable_list.add_child(resource_tile.instantiate())
	resource_scrollable_list.add_child(resource_tile.instantiate())
	resource_scrollable_list.add_child(resource_tile.instantiate())
	resource_scrollable_list.add_child(resource_tile.instantiate())
	resource_scrollable_list.add_child(resource_tile.instantiate())
	#resource_timer = Timer.new()
	#resource_timer.wait_time = 0.01
	#resource_timer.timeout.connect(_on_resource_timer_tick)
	#resource_timer.autostart = true
	#resource_bar = ProgressBar.new()
	#resource_bar.fill_mode = ProgressBar.FillMode.FILL_BEGIN_TO_END
	##resource_timer.indeterminate = true
	#resource_bar.min_value = 0
	#resource_bar.max_value = 500
	#resource_bar.step = 1
	#resource_bar.gui_input.connect(_toggle_resource_timer)
	#resource_pannel_0.add_child(resource_bar)
	#resource_pannel_0.add_child(resource_timer)
	#
	
	
	pass

	for currency in CurrenciesEnum.Currencies.values():
		if not currency.ends_with('Coin'):
			var word_label = Label.new()
			word_label.text = "{1}: {2}".format({"1" : currency, "2" : str(Wallet.get_currency_count(currency))})
			resource_container.add_child(word_label)
			resource_lables[currency] = word_label
			
	for upgrade in Globals.upgrades.keys():
		var button = Button.new()
		Globals.upgrades[upgrade].property_changed.connect(_on_upgrade_property_change)
		if not Globals.upgrades[upgrade].enabled or Globals.upgrades[upgrade].dependencies.size() > 0:
				button.hide()
		button.connect('pressed', _purchase_upgrade.bind(upgrade))
		button.set_text(Globals.upgrades[upgrade].name + '\n' + str(Globals.upgrades[upgrade].cost[0].amount) + ' ' + Globals.upgrades[upgrade].cost[0].currency + ' | +' + str(Globals.upgrades[upgrade].amplitude))
		shop_container.add_child(button)
		shop_buttons.insert(len(shop_buttons), button)

	# For every character in owned_characters, instantiate a member_panel,load the class resource into the panel, and add panel as child to member_list
	for character in Globals.owned_characters:
		var new_member_panel = Globals.member_panel_scene.instantiate()
		new_member_panel.character = load(Globals.character_resources_folder_path + character + ".tres")
		member_list.add_child(new_member_panel)
	
	# For every structure, instantiate a structure_panel, set properties of panel, and add panel as child to structure_list
	for structure in Globals.structures:
		var new_structure_panel = Globals.sturcture_panel_scene.instantiate()
		new_structure_panel.structure = load(Globals.structure_resources_folder_path + structure + ".tres")
		structure_list.add_child(new_structure_panel)






func _on_currency_change(currency_name, new_ammount):
		herb_label.text = "Herbs: {amount}".format({"amount" : str(Wallet.get_currency_count(CurrenciesEnum.Currencies.HERB))})


func _on_upgrade_property_change(upgrade_name):
	pass


func _on_resource_timer_timeout() -> void:
	Wallet.add_currency(CurrenciesEnum.Currencies.ORE, Globals.upgrades['ore_per_second'].count * Globals.upgrades['ore_per_second'].amplitude)
	Wallet.add_currency(CurrenciesEnum.Currencies.HERB, Globals.upgrades['herb_per_second'].count * Globals.upgrades['herb_per_second'].amplitude)

	pass # Replace with function body.


func _on_go_button_pressed() -> void:
	Globals.members_on_adventure = true
