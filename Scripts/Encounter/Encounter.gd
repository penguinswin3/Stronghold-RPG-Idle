extends Resource
class_name Encounter

@export_category("Details")
@export var display_name : String
@export var description : String
@export var general_type : EncounterEnums.ENCOUNTER_TYPE
@export var specific_type : EncounterEnums.ENCOUNTER_SPECIFIC_TYPE
@export var skill_check_type : EncounterEnums.ENCOUNTER_SKILL_CHECK_TYPE
@export var max_health : int
@export var health : int:
	set(value):
		health = maxi(0, value)

@export_category("Status")
@export var blocker : bool = false
@export var encounter_time_in_seconds : int = 2
@export var success_count : int = 0

@export_category("Rewards")
@export var reward_items = {}
@export var reward_currencies = {}
@export var reward_member : Character

@export_category("Skills")
@export var skills : Array[Skill]


func get_first_combat_skill_enum() -> SkillsEnum.SKILLS:
	for skill in skills:
		match skill.get_skill_id():
			SkillsEnum.SKILLS.MELEE:
				return SkillsEnum.SKILLS.MELEE
			
			SkillsEnum.SKILLS.ARCANE:
				return SkillsEnum.SKILLS.MELEE
			
			SkillsEnum.SKILLS.DIVINE:
				return SkillsEnum.SKILLS.MELEE
				
			SkillsEnum.SKILLS.PRIMAL:
				return SkillsEnum.SKILLS.MELEE
				
			SkillsEnum.SKILLS.RANGED:
				return SkillsEnum.SKILLS.MELEE
				
			SkillsEnum.SKILLS.OCCULT:
				return SkillsEnum.SKILLS.MELEE
	
	return SkillsEnum.SKILLS.MELEE


func check_blocking() -> bool:
	return blocker


func check_valid() -> bool:
	# If encounter unlocks member
	if check_if_unlocks_member() == true:
		# If member is already unlocked, return invalid
		if reward_member.check_unlocked() == true:
			return false
		
		# If member is not unlocked, return valid
		return true
	
	# If no member, return valid
	return true


func get_display_name():
	return display_name
	

func get_skill_quantity(skill):
	return skills[skill]["quantity"]


func get_skill_magnitude(skill):
	return skills[skill]["magnitude"]
	

func get_skills() -> Array[Skill]:
	return skills


func get_skill_check_type() -> EncounterEnums.ENCOUNTER_SKILL_CHECK_TYPE:
	return skill_check_type


func get_time_in_seconds():
	return encounter_time_in_seconds


func calculate_skill_roll(skill_id : SkillsEnum.SKILLS) -> int:
	print("\t[encounter.gd] %s rolled %s check" % [display_name, skill_id])
	var encounter_skill : Skill = Skill.new()
	encounter_skill.construct(skill_id, 1, 4)
	
	for skill in skills:
		if skill.get_skill_id() == skill_id:
			encounter_skill = skill
	
	return encounter_skill.calculate_roll_result()


func check_if_unlocks_member() -> bool:
	return reward_member != null


func success():
	success_count += 1
	reset()
	print("[Encounter.gd] %s encounter succeeded %d times" % [display_name, success_count])


func fail():
	reset()


func reset():
	health = max_health


func take_damage(damage):
	health -= damage

func get_health():
	return health


######################################### Handle Rewards #########################################
func generate_reward_items():
	print("[Encounter.gd] %s's loot rewards generated" % display_name)
	return []


func generate_reward_currencies():
	print("[Encounter.gd] %s's currency rewards generated" % display_name)
	return []


func unlock_member():
	reward_member.unlock_member()
