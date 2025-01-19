extends Object
const complex_cost = preload('res://Scripts/Currency/ComplexCost.gd')

var unlocked
var name
var cost = []
var count
var amplitude
var enabled:
	set(value):
		enabled = value
		property_changed.emit()
var scale_multiplier
var dependencies = []
var max_count

signal property_changed

func _init(unlocked, name, cost, cost_currency, count, amplitude, enabled, scale_multiplier, dependencies, max_count=-1, ):
	self.unlocked = unlocked
	self.name = name
	self.cost.append(complex_cost.new(cost, cost_currency)) 
	self.count = count
	self.amplitude = amplitude
	self.enabled = enabled
	self.scale_multiplier = scale_multiplier
	self.dependencies = dependencies
	self.max_count = max_count
	return

func _purchase_upgrade(quantity):
	self.count+= 1
	self.cost += self.cost * self.scale_multiplier
	return true
