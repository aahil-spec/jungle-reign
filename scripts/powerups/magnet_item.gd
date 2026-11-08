extends Area3D


class_name PowerUpItem

@export var magnet_duration:float=10.0
var base_duration:float=5.0
var upgraded_duration=base_duration+(SaveManager.upgrades["magnet_level"]*2.0)

func _process(delta: float):
	rotate_x(2.0*delta)
	rotate_y(3.0*delta)
	
func _on_body_entered(body:Node3D):
	if body is PlayerController:
		body.activate_magnet(magnet_duration)
		queue_free()
