extends Node
const WeightedOption = preload("res://Scripts/Rolling/WeightedOption.gd")

var LootTables = {
	"monsters" : {
		"monster_name" : "Gold Kobold",
		"drops" :
			 [WeightedOption.new("Red Kobold Scale", 500),
			WeightedOption.new("Rusty Dagger", 15),
			WeightedOption.new("Gold Coin", 10),
			WeightedOption.new("Rare Signet Ring", 1)
			 ]
	}
	
}
