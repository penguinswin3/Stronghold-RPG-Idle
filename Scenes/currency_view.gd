extends HBoxContainer
class_name CurrencyView

@onready var currency_count: Label = %CurrencyCount
@onready var currency_texture: TextureRect = %CurrencyTexture
@onready var currency_sign: Label = %CurrencySign

@export var currency : Currency
@export var count : int
@export_enum('+', '-', ' ') var sign : String


func _ready() -> void:
	currency_count.text = str(count)
	currency_texture.texture = currency.texture
	currency_sign.text = str(sign)
	
