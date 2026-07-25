extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area is Feather and not area.dragging and area.falling:
		area.on_box = true
		area.falling = false
		area.call_deferred("reparent", self)


func _on_area_exited(area):
	if area is Feather:
		area.on_box = false
