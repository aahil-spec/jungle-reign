extends CanvasLayer


@onready var main_menu=$MainMenu
@onready var pause_menu=$PauseMenu
@onready var game_over_menu=$GameOverMenu
@onready var final_score_label=$GameOverMenu/VBoxContainer/FinalScoreLabel
@onready var shop_menu=$ShopMenu
@onready var shop_coin_label=$ShopMenu/ShopCoinLabel
@onready var magnet_btn=$ShopMenu/VBoxContainer/UpgradeMagnetBtn
@onready var shield_btn=$ShopMenu/VBoxContainer/UpgradeShieldBtn
@onready var boost_btn=$ShopMenu/VBoxContainer/UpgradeBoostBtn
@onready var multiplier_btn=$ShopMenu/VBoxContainer/UpgradeMultiplierBtn
func _process(_delta:float):
	if Input.is_action_just_pressed("ui_cancel") and GameManager.current_state==GameManager.GameState.RUNNING:
		pause_game()
		
func show_menu(menu_to_show:Control):
	main_menu.visible=false
	pause_menu.visible=false
	game_over_menu.visible=false
	shop_menu.visible=false
	menu_to_show.visible=true
	
	
func pause_game():
	get_tree().paused=false
	pause_menu.visible=false
	show_menu(pause_menu)
func show_game_over(final_score:int):
	final_score_label.text="Distance: " + str(final_score) + "m\n"
	final_score_label.text+="Best Score: " + str(SaveManager.best_score)+ "m\n"
	final_score_label.text += "Coins Banked: " + str(SaveManager.permanent_coins)
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


func _on_upgrade_magnet_btn_pressed():
	_process_purchase("magnet_level")


func _on_upgrade_shield_btn_pressed():
	_process_purchase("shield_level")


func _on_upgrade_boost_btn_pressed():
	_process_purchase("boost_level")


func _on_upgrade_multiplier_btn_pressed():
	_process_purchase("multiplier_level")

func _on_close_shop_btn_pressed():
	show_menu(main_menu)


func _on_open_shop_btn_pressed():
	update_shop_display()
	show_menu(shop_menu)
func update_shop_display():
	shop_coin_label.text="Bank:" +str(SaveManager.permanent_coins)
	var magnet_lvl=SaveManager.upgrades["magnet_level"]
	magnet_btn.text="Magnet Lvl " + str(magnet_lvl)+" (Cost:" +str(magnet_lvl*50)+")"
	var shield_lvl=SaveManager.upgrades["shield_level"]
	shield_btn.text="Shield Lvl " + str(shield_lvl) + " (Cost: " + str(shield_lvl*50)+")"
	var boost_lvl=SaveManager.upgrades["boost_level"]
	boost_btn.text="Boost Lvl " + str(boost_lvl) + "(Cost:" + str(boost_lvl*50)+")"
	var multi_lvl=SaveManager.upgrades["multiplier_level"]
	multiplier_btn.text="Multiplier Lvl " + str(multi_lvl) + "(Cost: " + str(multi_lvl*50)+")"
func _process_purchase(upgrade_key:String):
	var current_level=SaveManager.upgrades[upgrade_key]
	var cost=current_level*50
	if SaveManager.permanent_coins>=cost:
		SaveManager.permanent_coins-=cost
		SaveManager.upgrades[upgrade_key]+=1
		SaveManager.save_game()
		update_shop_display()
	else:
		print("Not enough coins!")
