extends CanvasLayer


@onready var main_menu=$MainMenu
@onready var pause_menu=$PauseMenu
@onready var game_over_menu=$GameOverMenu
@onready var final_score_label=$GameOverMenu/FinalScoreLabel

func _process(_delta:float):
	if Input.is_action_just_pressed("ui_cancel") and GameManager.current_state==GameManager.GameState.RUNNING:
		pause_game()
		
func show_menu(menu_to_show:Control):
	main_menu.visible=false
	pause_menu.visible=false
	game_over_menu.visible=false
	menu_to_show.visible=true
	
	
func pause_game():
	get_tree().paused=false
	pause_menu.visible=false
	
func show_game_over(final_score:int):
	final_score_label.text="Distance: " + str(final_score) + "m"
	show_menu(game_over_menu)
	
	
func _on_play_button_pressed():
	main_menu.visible=false
	GameManager.change_state(GameManager.GameState.RUNNING)
func _on_resume_button_pressed():
	get_tree().paused=false
	pause_menu.visible=false
func _on_quit_button_pressed():
	get_tree().quit()

func _on_try_again_button_pressed():
	get_tree().paused=false
	GameManager.reset_run()
	get_tree().reload_current_scene()
