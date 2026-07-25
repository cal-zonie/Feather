extends Control

func _ready():
	$Elements/Split/Menu/OptionsButtons/SFXVolume/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	$Elements/Split/Menu/OptionsButtons/MusicVolume/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))

func _on_play_pressed():
	get_tree().change_scene_to_file(str("res://scenes/Main.tscn"))
	
func _on_options_pressed():
	$Elements/Split/Menu/MainButtons.visible = false
	$Elements/Split/Menu/OptionsButtons.visible = true
	
func _on_return_pressed():
	$Elements/Split/Menu/OptionsButtons.visible = false
	$Elements/Split/Menu/MainButtons.visible = true

func _on_quit_pressed():
	get_tree().quit()

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)
