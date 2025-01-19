extends Node

@export var character : Character
@onready var character_name: Label = %CharacterName


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character_name.text = character.display_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
