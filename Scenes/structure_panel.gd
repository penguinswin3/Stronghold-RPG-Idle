extends PanelContainer

@export var structure : Structure

@onready var structure_name: Label = %StructureName
@onready var structure_details: RichTextLabel = %StructureDetails
@onready var structure_texture: TextureRect = %StructureTexture
@onready var to_unlock_details: Label = %ToUnlockDetails
@onready var unlock_v_container: VBoxContainer = %UnlockVContainer
@onready var locked_label: Label = %LockedLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	structure_name.text = structure.display_name
	structure_details.text = structure.description
	to_unlock_details.text = structure.unlocked_class.display_name
	
	if structure.locked:
		locked_label.show()
		unlock_v_container.show()
	
		for requirement in structure.unlock_requirements:
			to_unlock_details.text += requirement
			pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
