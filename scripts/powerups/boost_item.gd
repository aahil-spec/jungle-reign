extends Area3D
class_name BoostItemPickUp

@export var duration:float=8.0

func _process(delta:float):
	rotate_y(5.0*delta)
	
func _on_body_entered(body:Node3D):
	if body.has_method("activate_boost"):
		body.activate_boost(duration)
		queue_free()
