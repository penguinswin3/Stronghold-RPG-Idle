extends Control
class_name MemberPartyView

@onready var character: Character
@onready var member_sprite: AnimatedSprite2D = %MemberSprite
@onready var health_bar: ProgressBar = %HealthBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.max_value = character.max_health
	health_bar.value = character.health
	member_sprite.sprite_frames = character.picture
	member_sprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func update_view():
	health_bar.value = character.health
	
	# If character died
	if character.get_health() <= 0:
		# Hide health bar
		health_bar.visible = false
		
		# Change animation to resting?
		pass
