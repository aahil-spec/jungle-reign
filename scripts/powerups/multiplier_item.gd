extends Area3D

class_name MultiplierItemPickUp

@export var duration:float=12.0
@export var multiplier_amount:int=2

func _process(delta:float):
	rotate_y(4.0*delta)
	position.y=1.0+sin(Time.get_ticks_msec()/150.0)*0.3
	
func _on_body_entered(body:Node3D):
	if body is PlayerController:
		GameManager.activate_multiplier(duration,multiplier_amount)
		queue_free()
