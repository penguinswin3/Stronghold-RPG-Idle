extends Node
var CurrenciesEnum = preload('res://Enums/currencies_enum.gd')

var ore_count_number_lable
var herb_count_number_lable
var shop_container
var shop_buttons = []
var resource_timer

func _purchase_upgrade(upgrade_name):
	if(Wallet.remove_currency(Globals.upgrades[upgrade_name].cost_currency, Globals.upgrades[upgrade_name].cost)):
		Globals.upgrades[upgrade_name].cost = ceil(Globals.upgrades[upgrade_name].cost * Globals.upgrades[upgrade_name].scale_multiplier)
		Globals.upgrades[upgrade_name].count += 1
	return
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shop_buttons[0].set_text(Globals.upgrades['ore_per_click'].name + '\n' + str(Globals.upgrades['ore_per_click'].cost) + ' ' + Globals.upgrades['ore_per_click'].cost_currency + ' | +' + str(Globals.upgrades['ore_per_click'].amplitude))
	shop_buttons[1].set_text(Globals.upgrades['ore_per_second'].name + '\n' + str(Globals.upgrades['ore_per_second'].cost) + ' ' + Globals.upgrades['ore_per_second'].cost_currency + ' | +' + str(Globals.upgrades['ore_per_second'].amplitude))
	ore_count_number_lable.set_text(str(Wallet.get_currency_count(CurrenciesEnum.Currencies.ORE)))
	herb_count_number_lable.set_text(str(Wallet.get_currency_count(CurrenciesEnum.Currencies.HERB)))

	pass


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file('res://Scenes/Main Menu/MainMenu.tscn')
	pass # Replace with function body.


func _on_mine_button_pressed() -> void:
	Wallet.add_currency(CurrenciesEnum.Currencies.ORE, ceil(Globals.upgrades['ore_per_click'].amplitude*Globals.upgrades['ore_per_click'].count))
	#Wallet.currency_changed.emit()
	pass # Replace with function body.
	
func _on_herb_button_pressed() -> void:
	Wallet.add_currency(CurrenciesEnum.Currencies.HERB, ceil(Globals.upgrades['herb_per_click'].amplitude*Globals.upgrades['ore_per_click'].count))
	pass # Replace with function body.



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node('BackgroundImage').set_texture(load(Globals.selected_options.background_image))
	resource_timer = get_node('ResourceTimer')
	ore_count_number_lable = get_node('ResourceContainer/OreCountLable/OreCountNumber')
	herb_count_number_lable = get_node('ResourceContainer/HerbCountLable/HerbCountNumber')
	shop_container = get_node('ScrollContainer/Shop Container')
	Wallet.currency_changed.connect(_on_currency_change)
	print(Wallet.currency_changed.get_connections())
	for upgrade in Globals.upgrades:
		var button = Button.new()
		button.connect('pressed', _purchase_upgrade.bind(upgrade))
		button.set_text(Globals.upgrades[upgrade].name + '\n' + str(Globals.upgrades[upgrade].cost) + ' ' + Globals.upgrades[upgrade].cost_currency + ' | +' + str(Globals.upgrades[upgrade].amplitude))
		shop_container.add_child(button)
		shop_buttons.insert(len(shop_buttons), button)
	pass # Replace with function body.

func _on_currency_change():
	print('Obamna')

func _on_resource_timer_timeout() -> void:
	Wallet.add_currency(CurrenciesEnum.Currencies.ORE, Globals.upgrades['ore_per_second'].count * Globals.upgrades['ore_per_second'].amplitude)
	Wallet.add_currency(CurrenciesEnum.Currencies.HERB, Globals.upgrades['herb_per_second'].count * Globals.upgrades['herb_per_second'].amplitude)

	pass # Replace with function body.
