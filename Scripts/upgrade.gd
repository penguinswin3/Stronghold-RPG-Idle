extends Object

var name
var cost
var cost_currency
var count
var amplitude
var enabled
var scale_multiplier
var max_count

func _init(name, cost, cost_currency, count, amplitude, enabled, scale_multiplier, max_count=-1):
	self.name = name
	self.cost = cost
	self.cost_currency = cost_currency
	self.count = count
	self.amplitude = amplitude
	self.enabled = enabled
	self.scale_multiplier = scale_multiplier
	self.max_count = max_count
	return

func _purchase_upgrade(quantity):
	self.count+= 1
	self.cost += self.cost * self.scale_multiplier
	return true
