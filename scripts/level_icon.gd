extends Button

@export var index: int
var stars = []

func _ready():
	stars = [get_node("Margin/Info/Stars/1"),get_node("Margin/Info/Stars/2"),get_node("Margin/Info/Stars/3")]
	$Margin/Info/Number.text = str(index)
	for i in range(len(stars)):
		if i < Manager.level_progress[index-1]:
			stars[i].visible = true
		else:
			stars[i].visible = false

func _on_pressed():
	Manager.start_level(index)
