extends HBoxContainer
class_name ClassView

@export var character : Character

@onready var character_display_name: Label = %DisplayName
@onready var class_texture: TextureRect = %Texture

func _ready() -> void:
	character_display_name.text = character.get_display_name()
	class_texture.texture = character.icon
