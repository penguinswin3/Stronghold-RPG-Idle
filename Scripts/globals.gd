extends Node


const OptionsEnum = preload('res://Enums/options_enum.gd')
const Upgrade = preload('res://Scripts/upgrade.gd')
const CurrenciesEnum = preload('res://Enums/currencies_enum.gd')

var selected_options = {
	"background_image" : OptionsEnum.BackgroundImages.FARM_BACKGROUND,
	"number_format" : OptionsEnum.NumberFormat.MILLION_FORMAT
}

var upgrades = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	upgrades['ore_per_click'] = Upgrade.new(1, 'Ore Per Click', 20, CurrenciesEnum.Currencies.ORE, 1, 1, true, 1.3, [])
	upgrades['ore_per_second'] = Upgrade.new(1, 'Ore Per Second', 20, CurrenciesEnum.Currencies.ORE, 0, 1, true, 1.4, [])
	upgrades['herb_per_click'] = Upgrade.new(1, 'Herb Per Click', 20, CurrenciesEnum.Currencies.HERB, 1, 1, true, 1.3, [])
	upgrades['herb_per_second'] = Upgrade.new(1, 'Herb Per Second', 20, CurrenciesEnum.Currencies.HERB, 0, 1, true, 1.4, [])
	upgrades['enhanced_herbs'] = Upgrade.new(1, 'Enhanced Herbalism', 100, CurrenciesEnum.Currencies.HERB, 0, 2, true, 0, [])
	upgrades['perfected_herbalism'] = Upgrade.new(0, 'Perfect Herbalism', 500, CurrenciesEnum.Currencies.HERB, 0, 10, false, 0, ['enhanced_herbs'])

var owned_characters = ["Lord", "Fighter"]
