extends Area3D



func _on_body_entered(body: Node3D):
	if body is PlayerController:
		body.start_zipline()


func _on_body_exited(body: Node3D):
	if body is PlayerController:
		body.end_zipline()
