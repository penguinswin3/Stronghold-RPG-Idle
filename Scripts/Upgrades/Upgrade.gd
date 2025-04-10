extends Resource
class_name Upgrade

const UpgradeExecutionOrderEnum = preload("res://Enums/upgrade_execution_order_enum.gd")
const GatheringActivitiesEnum = preload("res://Enums/gathering_activity_enum.gd")

@export var upgrade_id : int
@export var upgrade_name : String
@export var quantity : int

@export var order_type: UpgradeExecutionOrderEnum.UPGRADE_EXECUTION_ORDER

@export var associated_gathering_activity : GatheringActivitiesEnum.GATHERING_ACTIVITIES
var base_cost : Array[ComplexCost]

func _apply_upgrade(initial_value):
	return initial_value

func _calculate_cost():
	return base_cost
