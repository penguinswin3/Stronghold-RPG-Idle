extends Node

var current_timers : Array[Timer]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func wait(seconds):
	await get_tree().create_timer(seconds).timeout
