extends Node

var level_progress = [0,0,0,0]
var current_level: int = 0

var in_level: bool = false
var seen_tutorial: bool = false

var quota = [5, 7, 10]
var conveyor_speed = [25, 35, 40]
var box_rate = [15,10,10]

var wind = false
var wind_speed = 70
var wind_timer = 10
var wind_max_timer = 10
var wind_wait_timer = 15

func _process(delta):
	if in_level and current_level == 3:
		wind_timer -= delta
		if wind_timer < 0:
			wind = !wind
			wind_timer = wind_max_timer if wind else wind_wait_timer
			wind_speed *= -1 if wind else 1
			print(wind)
			print(wind_timer)
			print(wind_speed)

func get_conveyor_speed():
	return conveyor_speed[current_level - 1]

func get_box_rate():
	return box_rate[current_level - 1]

func start_level(level: int):
	current_level = level
	if not seen_tutorial:
		show_tutorial()
	
	Fade.get_node("AnimationPlayer").play("fade_out")
	await Fade.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file("res://scenes/Level.tscn")
	in_level = true

func show_tutorial():
	seen_tutorial = true
	
func end_level(lives_left: int):
	if lives_left > level_progress[current_level - 1]:
		level_progress[current_level - 1] = lives_left
	in_level = false
	current_level = 0
	Fade.get_node("AnimationPlayer").play("fade_out")
	await Fade.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file("res://scenes/menus/LevelSelect.tscn")
	Fade.get_node("AnimationPlayer").play("fade_in")
	await Fade.get_node("AnimationPlayer").animation_finished

func quit_level():
	in_level = false
	current_level = 0
	Fade.get_node("AnimationPlayer").play("fade_out")
	await Fade.get_node("AnimationPlayer").animation_finished
	get_tree().change_scene_to_file("res://scenes/menus/LevelSelect.tscn")
	Fade.get_node("AnimationPlayer").play("fade_in")
	await Fade.get_node("AnimationPlayer").animation_finished
