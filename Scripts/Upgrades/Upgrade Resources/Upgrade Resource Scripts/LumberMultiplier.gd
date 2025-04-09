class_name LumberMultiplier
extends Upgrade

func _apply_upgrade(initial_value : int):
	return initial_value*quantity

func _calculate_cost():
	return ComplexCost.new(0,1)
