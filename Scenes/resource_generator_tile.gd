extends PanelContainer

var currency_static_view = preload('res://Scenes/currency_static_view.tscn')
const ResourceGatheringStat = preload('res://Scripts/Gathering/Scripts/resource_gathering_stat.gd')

@onready var product_container = %product_container
@onready var title_container = %title_container
@onready var input_container = %input_container


@onready var resource_timer = %resource_timer
@onready var progress_bar = %progress_bar

@export
var resource_gathering_stats : ResourceGatheringStat



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	_register_title()
	_register_time_input()
	_register_input()
	_register_product()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _toggle_resource_timer():
	if resource_timer.is_stopped(): resource_timer.start() 
	else:
		resource_timer.paused = !resource_timer.paused
	
	
# This will do the bulk of the resource generation determinations 
func _on_resource_timer_tick():
	
	progress_bar.value += progress_bar.step
	if progress_bar.value >= progress_bar.max_value:
		var base_return = resource_gathering_stats.base_quantity
		for upgrade in Globals.unlocked_upgrades:
			base_return = GlobalResourceLoader.upgrade_list.get(upgrade)._apply_upgrade(base_return)
		for key in resource_gathering_stats.outputs.keys():
			Wallet.add_currency(key, base_return)
		progress_bar.value = 0
		
		

func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		_toggle_resource_timer()
	pass # Replace with function body.
	
func _register_time_input():
	resource_timer.wait_time = Globals.wait_time
	resource_timer.timeout.connect(_on_resource_timer_tick)
	progress_bar.fill_mode = ProgressBar.FillMode.FILL_BEGIN_TO_END
	progress_bar.min_value = 0
	progress_bar.max_value = resource_gathering_stats.max_val
	# To change speed, we generally want to increment the step
	progress_bar.step = resource_gathering_stats.step
	
	input_container.get_node("time_input_container/timer_label").text = str(_calculate_display_time())
	
func _register_title():
	title_container.get_node('title_verb').text = resource_gathering_stats.verb
	title_container.get_node('title_currency').text = resource_gathering_stats.name
	
func _register_input():
	for input in resource_gathering_stats.inputs.keys():
		if input != 0:
			# Make the currency_static_view based off of the input.currency and input.quantity
			var csv = currency_static_view.instantiate()
			csv.currency = Wallet.get_currency(input)
			csv.sign = "-"
			csv.count = input
			input_container.add_child(csv)
	pass
	
func _register_product():
	for output in resource_gathering_stats.outputs.keys():
		if output != 0:
			var csv = currency_static_view.instantiate()
			csv.currency = Wallet.get_currency(output)
			csv.sign = "+"
			csv.count = resource_gathering_stats.outputs[output]
			product_container.add_child(csv)
			
	pass
	
func _calculate_display_time():
	return max(0.5, (resource_gathering_stats.max_val-resource_gathering_stats.min_val)/resource_gathering_stats.step*Globals.wait_time)
