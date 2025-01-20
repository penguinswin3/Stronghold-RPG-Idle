extends HBoxContainer
class_name CurrencyView

@onready var currency_count: Label = %CurrencyCount
@onready var currency_texture: TextureRect = %CurrencyTexture

@export var currency : Currency
@export var count : int

func _ready() -> void:
	currency_count.text = str(count)
	currency_texture.texture = currency.texture
