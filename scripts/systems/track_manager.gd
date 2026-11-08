extends Node3D

class_name TrackManager

@export var segment_scenes:Array[PackedScene]
@export var initial_segments:int=6
@export var segments_ahead_of_player:int=4
@export var despawn_distance:float=20.0


@export var player:PlayerController
var active_segments:Array[Node3D]=[]
var next_spawn_position:Vector3=Vector3.ZERO

@export var zipline_scene:PackedScene
@export var zipline_spawn_count:int=15

var total_segments_spawned:int=0
var has_zipline_spawned:bool=false


func _ready():
	if segment_scenes.is_empty():
		push_error("TrackManager: No segment scenes assigned!")
		return
	for i in range(initial_segments):
		_spawn_segment()
		
func _process(_delta:float):
	if GameManager.current_state!=GameManager.GameState.RUNNING:
		return
	if not player:
		return
	_manage_segments()
	
func _manage_segments():
	var player_z=player.global_position.z
	var segments_ahead=0
	for segment in active_segments:
		var exit_point=segment.get_node("ExitPoint")
		if exit_point.global_position.z<player_z:
			segments_ahead+=1
	while segments_ahead<segments_ahead_of_player:
		_spawn_segment()
		segments_ahead+=1
	if active_segments.size()>0:
		var oldest_segment=active_segments[0]
		var exit_point=oldest_segment.get_node("ExitPoint")
		if exit_point.global_position.z>player_z+despawn_distance:
			_remove_oldest_segment()
			
func _spawn_segment():
	var segment_instance=Node3D
	if not has_zipline_spawned and total_segments_spawned>=zipline_spawn_count and zipline_scene!=null:
		segment_instance=zipline_scene.instantiate()
		has_zipline_spawned=true
	else:
		if segment_scenes.is_empty():return
		var random_index=randi()%segment_scenes.size()
		var picked_scene=segment_scenes[random_index]
		if not picked_scene:
			push_error("TrackManager: Empty slot found at index ", random_index)
			return
		segment_instance=picked_scene.instantiate()
	add_child(segment_instance)
	
	segment_instance.global_position=next_spawn_position
	active_segments.append(segment_instance)
	var exit_point=segment_instance.get_node("ExitPoint")
	if exit_point:
		next_spawn_position=exit_point.global_position
	else:
		push_error("Track segment missing ExitPoint Marker3D!")
	total_segments_spawned+=1
func _remove_oldest_segment():
	var segment=active_segments.pop_front()
	segment.queue_free()


func _on_close_shop_btn_pressed() -> void:
	pass # Replace with function body.
