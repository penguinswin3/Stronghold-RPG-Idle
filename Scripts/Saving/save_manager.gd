extends Node


func save_character():
	var saved_character : Character = GlobalResourceLoader._get_all_characters()[CharacterEnum.CHARACTERS.FIGHTER]
	ResourceSaver.save(saved_character, "user://save_game.tres")

func load_character():
	var loaded_character : Character = load("user://save_game.tres") as Character
	print(loaded_character.skills)
