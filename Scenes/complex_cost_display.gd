extends Node

@onready var grid_container = %GridContainer
var currency_static_view = preload('res://Scenes/currency_static_view.tscn')

var complex_costs = []


func _ready():
	for cost in complex_costs:
		var cview = currency_static_view.instantiate()
		cview.currency=Wallet.get_currency(cost.currency_id)
		cview.count = cost.amount
		cview.sign = '-'
		grid_container.add_child
	pass
