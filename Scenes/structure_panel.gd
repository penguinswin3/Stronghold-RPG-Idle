extends PanelContainer

@export var structure : Structure
var resource_view = preload("res://Scenes/resource_view.tscn") 
var character_view = preload("res://Scenes/character_view.tscn")

@onready var structure_name: Label = %StructureName
@onready var structure_details: RichTextLabel = %StructureDetails
@onready var structure_texture: TextureRect = %StructureTexture
@onready var unlock_v_container: VBoxContainer = %UnlockVContainer
@onready var locked_label: Label = %LockedLabel
@onready var unlock_details_v_container: VBoxContainer = %UnlockDetailsVContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	structure_name.text = structure.display_name
	structure_details.text = structure.description
	
	if structure.locked:
		locked_label.show()
		unlock_v_container.show()
		
		var new_character_view = character_view.instantiate()
		new_character_view.character = structure.unlocked_class
		unlock_details_v_container.add_child(new_character_view)
	
		for requirement in structure.unlock_requirements:
			var new_resource_view = resource_view.instantiate()
			new_resource_view.resource = load(Globals.resource_resources_folder_path + requirement + ".tres")
			new_resource_view.count = structure.unlock_requirements[requirement]
			unlock_details_v_container.add_child(new_resource_view)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
