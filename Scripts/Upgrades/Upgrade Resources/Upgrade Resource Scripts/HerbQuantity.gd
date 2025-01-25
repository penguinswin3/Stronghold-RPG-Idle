class_name HerbQuantity
extends Upgrade

@export var quantity : int

@export var base_cost : int 

func _apply_upgrade(initial_value, quantity):
	return initial_value+quantity

func _calculate_cost():
	return floor(base_cost*(quantity*1.3))
