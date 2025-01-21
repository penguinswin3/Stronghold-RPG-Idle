extends Node

const CurrenciesEnum = preload('res://Enums/currencies_enum.gd')

var wallet = {}

signal currency_changed(currency_name, new_ammount)
signal currency_added(currency_name, amount_added, new_ammount)
signal currency_removed(currency_name, amount_removed, new_ammount)
# Called when the node enters the scene tree for the first time.
func _ready():
	#Registers enumerated currencies globally
	for currency in CurrenciesEnum.Currencies.values():
		wallet[currency] = load(Globals.currency_resources_folder_path + currency + ".tres");
		print('Added currency key: ' + currency)
	return 
	
	
func add_currency(currency_name, amount):
	wallet[currency_name].count += amount
	Wallet.currency_changed.emit(currency_name, wallet[currency_name].count)
	Wallet.currency_added.emit(currency_name, amount, wallet[currency_name].count)
	return wallet[currency_name]
	
	
func remove_currency(currency_name, count):
	if validate_currency(currency_name, count):
		wallet[currency_name] -= count
		Wallet.currency_changed.emit(currency_name, count, wallet[currency_name])
		Wallet.currency_removed.emit(currency_name, count, wallet[currency_name])
		return true
	return false


func get_currency_count(currency_name):
	return wallet[currency_name].count
	
func get_currency(currency_name) -> Currency:
	return wallet[currency_name]
	
func validate_currency(currency_name, count):
	if(wallet[currency_name] < count):
		return false
	return true
	
