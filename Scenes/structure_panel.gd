extends PanelContainer

@export var structure : Structure
var currency_view = preload("res://Scenes/currency_view.tscn")
var character_view = preload("res://Scenes/character_view.tscn")

@onready var structure_name: Label = %StructureName
@onready var structure_details: RichTextLabel = %StructureDetails
@onready var structure_texture: TextureRect = %StructureTexture
@onready var unlock_v_container: VBoxContainer = %UnlockVContainer
@onready var locked_label: Label = %LockedLabel
@onready var unlock_details_v_container: VBoxContainer = %UnlockDetailsVContainer

@export var currency_array = []

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
			var new_currency_view = currency_view.instantiate()
			new_currency_view.currency = requirement as Currency
			new_currency_view.count = structure.unlock_requirements[requirement]
			currency_array.append(new_currency_view)
			unlock_details_v_container.add_child(new_currency_view)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#for currency_view in currency_array:
		#if(!Wallet.validate_currency(currency_view.currency.display_name, currency_view.count)):
