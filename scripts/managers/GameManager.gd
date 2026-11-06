extends Node


enum GameState{MAIN_MENU, READY, RUNNING, PAUSED, GAME_OVER}
var current_state:GameState=GameState.MAIN_MENU
var current_run_coins:int=0

@warning_ignore("unused_signal")
signal state_changed(new_state:GameState)

func change_state(new_state:GameState):
	current_state=new_state
	emit_signal("state_changed",current_state)
	
func _input(event:InputEvent):
	if event.is_action_pressed("pause") and current_state==GameState.RUNNING:
		change_state(GameState.PAUSED)
	elif event.is_action_pressed("pause") and current_state==GameState.PAUSED:
		change_state(GameState.RUNNING)
		
func add_coin():
	current_run_coins+=1
	print("Coins: ", current_run_coins)
