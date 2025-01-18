extends Node

const CurrenciesEnum = preload('res://Enums/currencies_enum.gd')

var wallet = {}

signal currency_changed
# Called when the node enters the scene tree for the first time.
func _ready():
	for currency in CurrenciesEnum.Currencies.values():
		print('adding currency key: ' + currency)
		wallet[currency] = 0;
	pass # Replace with function body.
	
func add_currency(currency_name, count):
	wallet[currency_name] += count
	Wallet.currency_changed.emit()
	return wallet[currency_name]
	
	
	
func remove_currency(currency_name, count):
	if validate_currency(currency_name, count):
		wallet[currency_name] -= count
		Wallet.currency_changed.emit()
		return true
	return false

func get_currency_count(currency_name):
	return wallet[currency_name]
	
func validate_currency(currency_name, count):
	if(wallet[currency_name] <  count):
		return false
	return true
	
func upgrade_coins():
	
	return true
	
