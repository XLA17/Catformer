extends Node2D

@export var levels: Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("from levels", levels)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func loadScene(level: int) -> Node2D:
	var index = level - 1
	
	if index >= 0 && index < levels.size():
		var levelInstance = levels[level-1].instantiate()
		print(levelInstance)
		return levelInstance
	return
