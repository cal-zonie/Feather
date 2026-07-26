extends Node

var level_progress = [0,0,0,0]
var current_level: int = 0

var in_level: bool = false
var seen_tutorial: bool = false

var quota = [5, 7, 10, 15]
var conveyor_speed = [30, 35, 40, 50]

func _ready():
	pass

func _process(_delta):
	pass

func get_conveyor_speed():
	return conveyor_speed[current_level - 1]

func start_level(level: int):
	current_level = level
	if not seen_tutorial:
		show_tutorial()
	
	get_tree().change_scene_to_file("res://scenes/Level.tscn")
	in_level = true

func show_tutorial():
	seen_tutorial = true
	
func end_level(lives_left: int):
	if lives_left > level_progress[current_level - 1]:
		level_progress[current_level - 1] = lives_left
	in_level = false
	current_level = 0
	get_tree().change_scene_to_file("res://scenes/menus/LevelSelect.tscn")
