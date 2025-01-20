extends Resource
class_name Currency

@export_enum(
	"Ore",
	"Herb",
	"Treasure",
	"Platinum Coin",
	"Gold Coin",
	"Silver Coin",
	"Copper Coin"
) var display_name : String

@export var count : int
@export var texture : Texture
