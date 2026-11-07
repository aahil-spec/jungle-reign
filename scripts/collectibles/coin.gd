extends Area3D

class_name CollectibleCoin

@export var rotation_speed:float=3.0
var target_player:Node3D=null
var fly_speed:float=25.0

func _process(delta: float):
	rotate_y(rotation_speed*delta)
	
	if target_player:
		var target_pos=target_player.global_position+Vector3(0,0.5,0)
		global_position=global_position.move_toward(target_pos,fly_speed*delta)
		if global_position.distance_to(target_pos)<1.0:
			GameManager.add_coin()
			queue_free()
		
func attract_to(player_node:Node3D):
	target_player=player_node
func _on_body_entered(body:Node3D):
	if body is PlayerController:
		GameManager.add_coin()
		queue_free()
