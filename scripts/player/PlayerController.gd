extends CharacterBody3D
class_name PlayerController

@export_group("Movemnet")
@export var forward_speed:float=10.0
@export var lane_switch_speed:float=15.0
@export var lane_width:float=2.0

@export_group("Jumping & Sliding")
@export var jump_force:float=8.0
@export var gravity:float=20.0
@export var slide_duration:float=0.8

var current_lame:int=1
var target_x:float=0.0
var is_sliding:bool=false
var slide_time:float=0.0

@onready var standing_collision:CollisionShape3D=$StandingCollision
@onready var sliding_collision:CollisionShape3D=$SlidingCollision
@onready var visuals:Node3D=$ModelVisuals

@onready var magnet_attractor:Area3D=$MagnetAttractor
@onready var power_up_timer:Timer=$PowerUpTimer

@onready var animation_player:AnimationPlayer=$ModelVisuals/Character/AnimationPlayer
@onready var animation_tree:AnimationTree=$ModelVisuals/Character/AnimationPlayer/AnimationTree
@onready var anim_state=animation_tree.get("parameters/playback")

var has_shield:bool=false
@onready var shield_bubble:MeshInstance3D=$ModelVisuals/ShieldBubble

func _ready():
	target_x=0.0
	position.x=0.0
	GameManager.change_state(GameManager.GameState.RUNNING)
	anim_state.travel("Running")
func _physics_process(delta: float):
	if GameManager.current_state!=GameManager.GameState.RUNNING:
		return
	_handle_vertical_movement(delta)
	_handle_lane_switching(delta)
	_handle_sliding(delta)
	
	var current_speed=forward_speed*GameManager.current_speed_multiplier
	velocity.z=-current_speed
	GameManager.distance_travelled+=current_speed*delta
	var was_in_air=not is_on_floor()
	move_and_slide()
	if was_in_air and is_on_floor() and not is_sliding:
		anim_state.travel("Running")
func _input(event:InputEvent):
	if GameManager.current_state!=GameManager.GameState.RUNNING:
		return
	if event.is_action_pressed("move_left") and current_lame>0:
		current_lame-=1
		_update_target_x()
	elif event.is_action_pressed("move_right") and current_lame<2:
		current_lame+=1
		_update_target_x()
	if event.is_action_pressed("jump") and is_on_floor() and not is_sliding:
		velocity.y=jump_force
		anim_state.travel("Jump")
		
	if event.is_action_pressed("slide") and is_on_floor() and not is_sliding:
		_start_slide()
		
func _update_target_x():
	target_x=(current_lame-1)*lane_width
	
func _handle_lane_switching(delta:float):
	var new_x=lerp(global_position.x,target_x,lane_switch_speed*delta)
	global_position.x=new_x
	
func _handle_vertical_movement(delta:float):
	if not is_on_floor():
		velocity.y-=gravity*delta
	elif velocity.y<0:
		velocity.y=0.0
		
func _start_slide():
	is_sliding=true
	slide_time=slide_duration
	standing_collision.disabled=true
	sliding_collision.disabled=false
	anim_state.travel("RunningSlide")
	visuals.position.y=-0.5
func _handle_sliding(delta:float):
	if is_sliding:
		slide_time-=delta
		if slide_time<=0.0:
			_end_slide()
			
func _end_slide():
	is_sliding=false
	standing_collision.disabled=false
	sliding_collision.disabled=true
	if is_on_floor():
		anim_state.travel("Running")
	visuals.position.y=0.0
func _on_magnet_attractor_area_entered(area: Area3D) -> void:
	if area is CollectibleCoin:
		area.attract_to(self)
func _on_power_up_timer_timeout():
	magnet_attractor.monitoring=false
	print("Magnet Deactivated.")
	
func activate_magnet(duration:float):
	magnet_attractor.monitoring=true
	power_up_timer.start(duration)
	print("Magnet Activated!")
func activate_shield():
	if not has_shield:
		has_shield=true
		shield_bubble.visible=true
		
func break_shield():
	has_shield=false
	shield_bubble.visible=false
	
