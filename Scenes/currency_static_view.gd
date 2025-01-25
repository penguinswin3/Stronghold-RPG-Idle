extends HBoxContainer
class_name CurrencyStaticView 

const Currency = preload('res://Scripts/Currency/Currency.gd')

@onready var currency_count: Label = %CurrencyCount
@onready var currency_texture: TextureRect = %CurrencyTexture
@onready var currency_sign: Label = %CurrencySign

var currency : Currency
@export var count : int = 5
@export_enum('+', '-', ' ') var sign : String



func _ready() -> void:
	currency_count.text = str(count)
	currency_texture.texture = currency.texture
	currency_sign.text = sign
	
	
func _update_text(count):
	currency_count.text = str(count)
