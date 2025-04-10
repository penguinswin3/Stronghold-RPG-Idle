extends Node
class_name Roller

var rng = RandomNumberGenerator.new()

func _ready():
	return 


func _die_roll(quantity, magnitude):
	if quantity <= 0 or magnitude <= 0:
		return 0
	var sum = 0;
	for i in quantity:
		sum += rng.randi_range(1, magnitude)
	return sum
	
func _roll_attack_versus_defend(attack_quantity, attack_magnitude, defend_quantity, defend_magnitude):
	# This just wraps _attack_versus_defend if you want to specify roll parameters rather than a roll result
	return _attack_versus_defend(_die_roll(attack_quantity, attack_magnitude),
								 _die_roll(defend_quantity, defend_magnitude))
	
func _attack_versus_defend(attack_roll, defend_roll):
	# Returns the difference in value of the attack-defend roll. 
	# Anything less than or equal to 0 is set to 0 and considered a 'miss'.
	# The returned number can be used to calculate damage or degree of success
	return max(0, attack_roll - defend_roll)
	

# Takes in a list of WeightedOptions, as well as a quantity of options to pick, if provided
func _roll_weighted(options, quantity=1):
	var total_weight = 0
	var selected_options = {}
	# Sort by ascending weights
	options.sort_custom(func sort(a,b): if a.weight < b.weight: return true else: return false)
	for option in options:
		total_weight += option.weight
		selected_options[option.option] = 0	
	var rolled_values = []
	for i in quantity:
		rolled_values.append(rng.randi_range(0, total_weight))
	var consumed_weight = 0
	for option in options:
		selected_options[option.option] = rolled_values.filter(_is_less_than_equal.bind(option.weight+consumed_weight)).size()
		rolled_values = rolled_values.slice(selected_options[option.option], rolled_values.size())
		consumed_weight += option.weight
	return selected_options

func _is_less_than_equal(number, weight):
	return number <= weight
