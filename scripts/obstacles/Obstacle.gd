extends Node

class_name TrackObstacle

func _on_body_entered(body:Node3D):
	if body is PlayerController or body.name=="Player":
		if body.has_shield:
			body.break_shield()
			queue_free()
		else:
			GameManager.change_state(GameManager.GameState.GAME_OVER)
