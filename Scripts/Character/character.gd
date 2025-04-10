extends Resource
class_name Character

const ResourceGatheringStat = preload("res://Scripts/Gathering/Scripts/resource_gathering_stat.gd")

@export_category("Details")
@export var character_id : CharacterEnum.CHARACTERS
@export_enum(
	# Combat
	"Fighter", 
	"Mage",
	"Cleric", 
	"Druid", 
	"Barbarian", 
	"Archer", 
	"Occultist",
	
	# Exploration
	"Hunter", 
	"Bard", 
	"Archeologist", 
	"Pyromancer", 
	"Miner", 
	"Forester", 
	"Diviner",
	
	# Social
	"Lord", 
	"Quartermaster", 
	"Thief", 
	"Artificer", 
	"Merchant", 
	"Blacksmith", 
	"Entrepreneur", 
	"Socialite"
) var display_name : String
@export_multiline var description : String
@export var icon : Texture
@export var picture : SpriteFrames

@export var skills : Array[Skill]
@export var skills_order : Array[SkillsEnum.SKILLS]
@export var upgrades : Array

@export_category("Status")
@export var unlocked : bool = false
@export var unlock_roll_weight : int = 0
@export var on_adventure : bool = false
@export var level : int = 1
@export var xp : int = 0

@export_category("Health")
@export var max_health : int
@export var health : int:
	set(value):
		health = maxi(0, value)

@export_category("Resources & Gathering")
@export var current_gather_activity : ResourceGatheringStat
@export var associated_resources = []
@export var associated_gathering_activities = []


func get_display_name():
	return display_name

func calculate_skill_roll(skill_id : SkillsEnum.SKILLS) -> int:
	var member_skill : Skill = Skill.new()
	member_skill.construct(skill_id, 1, 4)
	
	for skill in skills:
		if skill.get_skill_id() == skill_id:
			member_skill = skill
	
	print("\t[character.gd] %s rolled %s check" % [display_name, skill_id])
	return member_skill.calculate_roll_result(upgrades)


func take_damage(damage):
	health -= damage
	
	
func roll_skill(roll_skill_id: SkillsEnum.SKILLS):
	var quantity : int = 1
	var magnitude : int = 4
	
	print(skills)
	for skill in skills:
		print(skill)
		if skill.get_skill_id() == roll_skill_id:
			quantity = skill.get_quantity()
			magnitude = skill.get_magnitude()
			break
	
	return Roller._die_roll(quantity, magnitude)


func calculate_upgrades():
	return 0
	
	
func set_skills_order(order : Array[SkillsEnum.SKILLS]):
	skills_order.clear()
	skills_order.append_array(order)


func get_skills_order() -> Array:
	return CharacterDetails.skill_orders[character_id]
	
	
func unlock_member():
	print("[Character.gd] %s was unlocked!" % display_name)
	Globals.add_adventure_text.emit("%s was unlocked!" % display_name)
	unlocked = true
	Globals.unlock_character.emit()


func check_unlocked():
	return unlocked


func gained_xp(amount):
	xp += amount


func get_health():
	return health


func get_first_combat_skill_enum() -> SkillsEnum.SKILLS:
	for skill in get_skills_order():
		match skill:
			SkillsEnum.SKILLS.MELEE:
				return SkillsEnum.SKILLS.MELEE
			
			SkillsEnum.SKILLS.ARCANE:
				return SkillsEnum.SKILLS.ARCANE
			
			SkillsEnum.SKILLS.DIVINE:
				return SkillsEnum.SKILLS.DIVINE
				
			SkillsEnum.SKILLS.PRIMAL:
				return SkillsEnum.SKILLS.PRIMAL
				
			SkillsEnum.SKILLS.RANGED:
				return SkillsEnum.SKILLS.RANGED
				
			SkillsEnum.SKILLS.OCCULT:
				return SkillsEnum.SKILLS.OCCULT
	
	return SkillsEnum.SKILLS.MELEE

func reset():
	health = max_health
		
