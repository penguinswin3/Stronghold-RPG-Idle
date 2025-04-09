class_name ComplexCost

var currency_id : CurrenciesEnum.CURRENCIES
var amount : int

func _init(amount, currency_id):
	self.amount = amount
	self.currency_id = currency_id
