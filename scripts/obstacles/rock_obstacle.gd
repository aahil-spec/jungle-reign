extends Area3D
class_name Obstacle

func _on_body_entered(body:Node3D):
	if body is PlayerController:
		GameManager.change_state(GameManager.GameState.GAME_OVER)
