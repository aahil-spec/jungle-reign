extends Node


enum GameState{MAIN_MENU, READY, RUNNING, PAUSED, GAME_OVER}
var current_state:GameState=GameState.MAIN_MENU
var current_run_coins:int=0
var distance_travelled:float=0.0
var score:int=0
var current_speed_multiplier:float=1.0
var max_speed_multiplier:float=2.5
var speed_increase_rate:float=0.01

@warning_ignore("unused_signal")
signal state_changed(new_state:GameState)

func change_state(new_state:GameState):
	current_state=new_state
	emit_signal("state_changed",current_state)
	
func _process(delta: float):
	if current_state==GameState.RUNNING:
		_handle_difficulty_scaling(delta)
		_calculate_score()
func _input(event:InputEvent):
	if event.is_action_pressed("pause") and current_state==GameState.RUNNING:
		change_state(GameState.PAUSED)
	elif event.is_action_pressed("pause") and current_state==GameState.PAUSED:
		change_state(GameState.RUNNING)
		
func add_coin():
	current_run_coins+=1
	print("Coins: ", current_run_coins, " | Speed Mult: ", snapped(current_speed_multiplier, 0.01))
func _handle_difficulty_scaling(delta:float):
	if current_speed_multiplier<max_speed_multiplier:
		current_speed_multiplier+=speed_increase_rate*delta
		
func _calculate_score():
	score=int(distance_travelled*10) +(current_run_coins*50)
	
func reset_run():
	current_run_coins=0
	distance_travelled=0.0
	score=0
	current_speed_multiplier=1.0
