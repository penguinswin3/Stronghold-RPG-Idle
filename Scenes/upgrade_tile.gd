extends PanelContainer

@onready var currency_view = %CurrencyGrid
@onready var upgrade_name_label = %UpgradeNameLabel
var currency_static_view = preload('res://Scenes/currency_static_view.tscn')

var buy_button
var buy_x_button
var upgrade_name

var cost_panel

var cost : Array[ComplexCost] = []

var associated_upgrade_id : int

var associated_gathering_activity : int

signal update_upgrade_cost



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for complex_cost in cost:
		var csv = currency_static_view.instantiate()
		csv.currency = Wallet.get_currency(complex_cost.currency_id)
		csv.count = complex_cost.amount
		csv.sign = '-'
		upgrade_name_label.text = upgrade_name
		currency_view.add_child(csv)
		
	SignalBus.on_upgrade_cost_changed.connect(_update_displayed_cost)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_buy_button_pressed() -> bool:
	# validate all currencies
	for currency in cost:
		if Wallet.validate_currency(currency.currency_id, currency.amount) == false:
			return false
		Wallet.remove_currency(currency.currency_id, currency.amount)

	if associated_upgrade_id not in Globals.unlocked_upgrades[associated_gathering_activity]:
		Globals.unlocked_upgrades[associated_gathering_activity].append(associated_upgrade_id)
	GlobalResourceLoader.upgrade_list[associated_upgrade_id].quantity += 1
	SignalBus.on_upgrade_purchased.emit(associated_upgrade_id)
	return true # Replace with function body.

func _update_displayed_cost(associated_upgrade_id):
	pass
