extends HBoxContainer
class_name CurrencyView

@onready var currency_count: Label = %CurrencyCount
@onready var currency_texture: TextureRect = %CurrencyTexture

var currency : Currency
@export var count : int 

func _ready() -> void:
	currency_count.text = str(currency.count)
	currency_texture.texture = currency.texture

func _update_text(currency_id, count):
	if currency_id == currency.currency_id:
		currency_count.text = str(count)
