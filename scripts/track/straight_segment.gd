extends Node3D


class_name TrackSegment

@export var obstacle_scenes:Array[PackedScene]
@export var obstacle_chance:float=0.7
@export var coin_scene:PackedScene
@export var coin_chance:float=0.5
@onready var spawn_points=$ObstacleSpawns.get_children()
@onready var coin_spawns=$CoinSpawns.get_children()
@export var powerup_chance:float=0.1
@onready var powerup_spawn=$PowerUpSpawn
@export var powerup_scenes:Array[PackedScene]
func _ready():
	if not obstacle_scenes.is_empty() and randf()>=obstacle_chance:
		_spawn_obstacle()
	if coin_scene and randf()<=coin_chance:
		_spawn_coin_line()
	if powerup_scenes and randf()<=powerup_chance:
		_spawn_powerup()
		
func _spawn_obstacle():
	var chosen_spawn=spawn_points.pick_random()
	var random_obstacle=obstacle_scenes.pick_random()
	var obstacle_instance=random_obstacle.instantiate()
	add_child(obstacle_instance)
	obstacle_instance.global_position=chosen_spawn.global_position
	
func _spawn_coin_line():
	var lanes=[-2.0,0.0,2.0]
	var chosen_lane_x=lanes.pick_random()
	for spawn_point in coin_spawns:
		var coin_instance=coin_scene.instantiate()
		add_child(coin_instance)
		var spawn_pos=spawn_point.global_position
		spawn_pos.x=global_position.x+chosen_lane_x
		coin_instance.global_position=spawn_pos
	
func _spawn_powerup():
	if powerup_scenes.is_empty():return
	var lanes=[-2.0,0.0,2.0]
	var chosen_lane_x=lanes.pick_random()
	var random_powerup=powerup_scenes.pick_random()
	var powerup_instance=random_powerup.instantiate()
	add_child(powerup_instance)
	var spawn_pos=powerup_spawn.global_position
	spawn_pos.x=global_position.x+chosen_lane_x
	powerup_instance.global_position=spawn_pos
