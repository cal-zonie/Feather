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
	$BCount.text = str(quota)
	$LCount.text = str(lives_remaining)
	request_ready()
	
func _process(_delta):
	if Input.is_action_just_pressed("Correct Box"):
		submit_box(5, 5)
	
	if Input.is_action_just_pressed("Fail Box"):
		submit_box(5, 7)
		
func submit_box(feathers: int, required: int):
	if feathers == required:
		#play something??
		boxes_complete += 1
		$BCount.text = str(quota - boxes_complete)
		if boxes_complete == quota:
			#play win sound
			Manager.end_level(lives_remaining)
	else:
		if feathers > required:
			#play too much down
			pass
		else:
			#play not enough down
			pass
		
		lives_remaining -= 1
		$LCount.text = str(lives_remaining)
		if lives_remaining == 0:
			#play lose sound
			Manager.end_level(lives_remaining)
