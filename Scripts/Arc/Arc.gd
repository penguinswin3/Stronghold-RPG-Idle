extends Resource
class_name Arc

@export_category("Information")
@export var arc_id : ArcEnum.ARC
@export var display_name : String
@export var description : String
@export var adventures : Array[Adventure] = []
@export var next_arc : ArcEnum.ARC

func get_display_name():
	return display_name

func get_adventures():
	return adventures

func get_arc_id():
	return arc_id
	
func get_next_arc_id():
	return next_arc
	
func unlock():
	print("%s Arc Unlocked!" % display_name)
	Globals.arc_unlocked.emit(arc_id)
