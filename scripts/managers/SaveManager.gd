extends Node

class_name SaveData

const SAVE_PATH= "user://jungle_reign_save.json"

var permanent_coins:int=0
var best_score:int=0
var upgrades:Dictionary={
	"magnet_level":1,
	"shield_level":1,
	"boost_level":1,
	"multiplier_level":1
}
func _ready():
	load_game()
	
func save_game():
	var save_dict={
		"permanent_coins":permanent_coins,
		"best_score":best_score,
		"upgrades":upgrades
	}
	var file=FileAccess.open(SAVE_PATH,FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_dict))
		file.close()
		print("Game Saved! Coins: ", permanent_coins, " | Best Score: ", best_score)
		
func load_game():
	if FileAccess.file_exists(SAVE_PATH):
		var file=FileAccess.open(SAVE_PATH,FileAccess.READ)
		if file:
			var json_string=file.get_as_text()
			file.close()
			var json=JSON.new()
			var error=json.parse(json_string)
			if error==OK:
				var data=json.data
				if data.has("permanent_coins"):
					permanent_coins=data["permanent_coins"]
				if data.has("best_score"):
					best_score=data["best_score"]
				if data.has("upgrades"):
					upgrades=data["upgrades"]
			print("Save Loaded! Coins: ", permanent_coins, " | Best Score: ", best_score)
	else:
		print("No save found. Starting fresh.")
