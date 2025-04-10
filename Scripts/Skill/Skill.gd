extends Resource
class_name Skill

@export var skill_id : SkillsEnum.SKILLS
@export var quantity : int
@export var magnitude : int

func construct(skill_id: SkillsEnum.SKILLS, quantity: int, magnitude: int) -> void:
	self.skill_id = skill_id
	self.quantity = quantity
	self.magnitude = magnitude

func get_display_name():
	return SkillDetails.skills[str(skill_id)]["display_name"]

func get_description():
	return SkillDetails.skills[str(skill_id)]["description"]

func get_skill_id():
	return skill_id

func get_quantity():
	return quantity

func get_magnitude():
	return magnitude
	
func calculate_roll_result(upgrades: Array = []) -> int:
	var roll = Roller._die_roll(quantity, magnitude)
	for upgrade in upgrades:
		# Add upgrade results to roll
		pass
	
	print("\t\t[skill.gd] Rolled %dd%d" % [quantity, magnitude])
	return roll
