extends Node

@export var minutes: RichTextLabel
@export var seconds: RichTextLabel
@export var time : float = 30

signal time_low
signal time_elapsed

static var low_threshold = 10
var low_emitted : bool = false

func _ready():
	return
	
func _process(delta):
	if time > 0:
		time -= delta
		
		var minute_text = str(int(int(time) / 60))
		if len(minute_text) == 1:
			minute_text = "0" + minute_text
		minutes.text = minute_text
		
		var second_text = str(int(time) % 60)
		if len(second_text) == 1:
			second_text = "0" + second_text
		seconds.text = second_text
			
		
		if int(time) <= low_threshold and !low_emitted:
			time_low.emit()
			low_emitted = true
		
		if time < 0:
			time_elapsed.emit()
	
