extends Area3D

class_name ShieldItemPickUp

func _process(delta:float):
	rotate_y(3.0*delta)
	position.y=1.0+sin(Time.get_ticks_msec()/200.0)*0.2
	
func _on_body_entered(body:Node3D):
	if body.has_method("activate_shield"):
		body.activate_shield()
		queue_free()
