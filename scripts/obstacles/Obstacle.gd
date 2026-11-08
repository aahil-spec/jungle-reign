extends Node

class_name TrackObstacle

func _on_body_entered(body:Node3D):
	if body is PlayerController or body.name=="Player":
		if body.is_boosting:
			queue_free()
		elif body.has_shield:
			body.break_shield()
			queue_free()
		else:
			GameManager.change_state(GameManager.GameState.GAME_OVER)
			var ui=get_tree().root.get_node("Game/UIManager")
			if ui:
				ui.show_game_over(GameManager.current_score)
			get_tree().paused=true
