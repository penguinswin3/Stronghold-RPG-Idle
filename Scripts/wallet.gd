extends Node

const CurrenciesEnum = preload('res://Enums/currencies_enum.gd')

var wallet = {}

signal currency_changed(currency_name, new_ammount)
signal currency_added(currency_name, amount_added, new_ammount)
signal currency_removed(currency_name, amount_removed, new_ammount)
# Called when the node enters the scene tree for the first time.
func _ready():
	# Adds each registered currency to wallet
	wallet = GlobalResourceLoader._get_all_currencies()
	return 
func add_currency(currency_id: CurrenciesEnum.CURRENCIES, amount: int) -> Currency:
	wallet[currency_id].count += amount
	Wallet.currency_changed.emit(currency_id, wallet[currency_id].count)
	Wallet.currency_added.emit(currency_id, amount, wallet[currency_id].count)
	return wallet[currency_id]
	
	
func remove_currency(currency_id: CurrenciesEnum.CURRENCIES, amount: int) -> Currency:
	if validate_currency(currency_id, amount):
		wallet[currency_id] -= amount
		Wallet.currency_changed.emit(currency_id, amount, wallet[currency_id])
		Wallet.currency_removed.emit(currency_id, amount, wallet[currency_id])
		return wallet[currency_id]
	return wallet[currency_id]


func get_currency_count(currency_id) -> int:
	return wallet[currency_id].count
	
func get_currency(currency_id) -> Currency:
	return wallet[currency_id]
	
func validate_currency(currency_id, amount) -> bool:
	# Equal is acceptable!
	if(wallet[currency_id] < amount):
		return false
	return true
	
func get_all_currencies() -> Array:
	var currencies = []
	for c in wallet:
		currencies.append(c)
	return currencies
	
