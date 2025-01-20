extends HBoxContainer
class_name ResourceView

@onready var resource_count: Label = %ResourceCount
@onready var resource_texture: TextureRect = %ResourceTexture

@export var resource : ResourceType
@export var count : int

func _ready() -> void:
	resource_count.text = str(count)
	resource_texture.texture = resource.texture
