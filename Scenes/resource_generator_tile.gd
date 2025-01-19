extends PanelContainer

var resource_pannel_timer
var resource_timer
var progress_bar
var resource_gane_label
var tile_titel
var timer_label

@export
var resource_stats : ResourceGatheringStat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource_timer = get_node('Control/resource_timer')
	progress_bar = get_node('Control/progress_bar')

	resource_timer.wait_time = resource_stats.wait_time
	resource_timer.timeout.connect(_on_resource_timer_tick)
	progress_bar.fill_mode = ProgressBar.FillMode.FILL_BEGIN_TO_END
	##resource_timer.indeterminate = true
	progress_bar.min_value = 0
	progress_bar.max_value = 500
	progress_bar.step = 1

	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _toggle_resource_timer():
	if resource_timer.is_stopped(): resource_timer.start() 
	else:
		resource_timer.paused = !resource_timer.paused
	
func _on_resource_timer_tick():
	progress_bar.value += progress_bar.step
	if progress_bar.value >= progress_bar.max_value:
		Wallet.add_currency(CurrenciesEnum.Currencies.HERB, 1)
		progress_bar.value = 0


func _on_control_gui_input(event: InputEvent) -> void:
	print(event)
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		_toggle_resource_timer()
	pass # Replace with function body.
