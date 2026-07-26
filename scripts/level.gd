extends Node

var lives_remaining: int = 0
var boxes_complete: int = 0
var quota: int
var conveyor_speed: float

func _ready():
	boxes_complete = 0
	lives_remaining = 3
	quota = Manager.quota[Manager.current_level - 1]
	conveyor_speed = Manager.conveyor_speed[Manager.current_level - 1]
	update_quota()
	update_lives()
	$Alarm.play()
	request_ready()
	
		
func submit_box(feathers: int, required: int):
	if feathers == required:
		$Correct.play()
		boxes_complete += 1
		update_quota()
		if boxes_complete == quota:
			#fade to win screen
			#play win sound
			Manager.end_level(lives_remaining)
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
			#fade to lose screen (big x's?)
			#play lose sound
			Manager.end_level(lives_remaining)

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
	
