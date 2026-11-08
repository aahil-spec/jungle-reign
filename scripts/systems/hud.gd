extends CanvasLayer

class_name PremiumHUD

@onready var score_label:Label=$SafeArea/TopRightLayout/ScorePanel/ScoreLabel
@onready var coin_label:Label=$SafeArea/TopRightLayout/CoinPanel/CoinHBox/CoinLabel
@onready var distance_label:Label=$SafeArea/TopLeftLayout/DistancePanel/DistanceLabel
@onready var multiplier_label:Label=$SafeArea/TopRightLayout/CoinPanel/CoinHBox/MultiplierLabel
var last_coin_count:int=0

func _ready():
	coin_label.pivot_offset=coin_label.size/2.0
	
func _process(_delta:float):
	if GameManager.current_state==GameManager.GameState.RUNNING:
		_update_displays()
		
func _update_displays():
	score_label.text= "SCORE: %d" % GameManager.score
	distance_label.text= "%.1fm" % GameManager.distance_travelled
	multiplier_label.visible=GameManager.multiplier_timer>0.0
	var current_coins=GameManager.current_run_coins
	if current_coins!=last_coin_count:
		coin_label.text=str(current_coins)
		_animate_coin_pickup()
		last_coin_count=current_coins
func _animate_coin_pickup():
	var tween=create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(coin_label, "scale",Vector2(1.5,1.5),0.1)
	tween.tween_property(coin_label, "scale", Vector2(1.0,1.0),0.4)
