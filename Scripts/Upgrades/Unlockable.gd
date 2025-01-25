extends Node

var unlockable_id : int
var unlocked : bool = false

signal _on_unlock

func _unlock():
	unlocked = true
	return
