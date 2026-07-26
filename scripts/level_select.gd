extends Node

func _ready():
	request_ready()

func _on_return_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/MainMenu.tscn")

func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/Tutorial.tscn")
