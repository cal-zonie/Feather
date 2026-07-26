extends Node

var lives_remaining: int = 0
var boxes_complete: int = 0
var quota: int
var conveyor_speed: float

func _ready():
	$Pause/Margin/Stuff/OptionsButtons/SFXVolume/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	$Pause/Margin/Stuff/OptionsButtons/MusicVolume/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	
	boxes_complete = 0
	lives_remaining = 3
	quota = Manager.quota[Manager.current_level - 1]
	conveyor_speed = Manager.conveyor_speed[Manager.current_level - 1]
	update_quota()
	update_lives()
	$Alarm.play()
	request_ready()
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _process(_delta):
	if Input.is_action_just_pressed("pause") and not $Win.visible and not $Lose.visible:
		toggle_pause()
		
func submit_box(feathers: int, required: int):
	if feathers == required:
		$Correct.play()
		boxes_complete += 1
		update_quota()
		if boxes_complete == quota:
			get_tree().paused = true
			$Win.visible = true
			#todo add fade
			$Winner.play()
			pass
	else:
		if feathers > required:
			$TooMuch.play()
			pass
		else:
			$NotEnough.play()
			pass
		
		lives_remaining -= 1
		update_lives()
		await get_tree().create_timer(2.0).timeout
		if lives_remaining == 0:
			get_tree().paused = true
			$Lose.visible = true
			#todo add fade
			$Loser.play()

func update_lives():
	for i in range(3):
		get_node("Lives/Xs/H/" + str(i + 1) + "_off").visible = true
	var strikes = 3 - lives_remaining
	for i in range(strikes):
		get_node("Lives/Xs/H/" + str(i + 1) + "_on").visible = true
		get_node("Lives/Xs/H/" + str(i + 1) + "_off").visible = false

func update_quota():
	get_node("Quota/Numbers/H/Tens_Back/Tens").text = str(int((quota - boxes_complete) / 10))
	get_node("Quota/Numbers/H/Ones_Back/Ones").text = str((quota - boxes_complete) % 10)

func toggle_pause():
	if $Pause.visible:
		$Pause.visible = false
		get_tree().paused = false
	else:
		get_tree().paused = true
		$Pause.visible = true
	
func _on_resume_pressed():
	toggle_pause()

func _on_options_pressed():
	$Pause/Margin/Stuff/PauseButtons.visible = false
	$Pause/Margin/Stuff/OptionsButtons.visible = true

func _on_level_select_pressed():
	get_tree().paused = false
	Manager.quit_level()

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)

func _on_return_pressed():
	$Pause/Margin/Stuff/OptionsButtons.visible = false
	$Pause/Margin/Stuff/PauseButtons.visible = true

func _on_end_pressed():
	get_tree().paused = false
	Manager.end_level(lives_remaining)
