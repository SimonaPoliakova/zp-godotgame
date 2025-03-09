extends Node

func _ready():
	# No need to add GameUI here, GameManager is handling it
	# Just call check_level_completion to monitor the level state
	GameManager.check_level_completion()
	
