extends Area3D

class_name CollectibleCoin

@export var rotation_speed:float=3.0

func _process(delta: float):
	rotate_y(rotation_speed*delta)
	
func _on_body_entered(body:Node3D):
	if body is PlayerController:
		GameManager.add_coin()
		queue_free()
