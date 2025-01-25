extends Node
const WeightedOption = preload("res://Scripts/Rolling/WeightedOption.gd")

var LootTables = {
	"monsters" : {
		"monster_name" : "Gold Kobold",
		"drops" :
			 [
				WeightedOption.new("Combat - Red Kobold", 81),
				WeightedOption.new("Social - Treasure Chest", 12),
				WeightedOption.new("Exploration - Cave Moss", 45),
				#WeightedOption.new("Gold Coin", 2),
				#WeightedOption.new("Rare Signet Ring", 1),

			 ]
	}
	
}
