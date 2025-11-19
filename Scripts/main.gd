extends Node2D

const OFFSET_CAMERA_PLAYER = 30

var currentLevel: int = 1
var level: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = Levels.loadScene(currentLevel)
	transitionLevel(level.name)
	level.connect("nextLevel", Callable(self, "nextLevel"))
	$Player.position = level.get_node("PlayerStartPos").position
	add_child(level)
	
	$Transition.connect("anim_transition_finished", Callable(self, "_on_transition_finished"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	cameraMovement()


func _on_transition_finished():
	level.startLevel()
	pass

func cameraMovement():
	var camX = $Camera2D.position.x
	var playerX = $Player.position.x
	var camY = $Camera2D.position.y
	var playerY = $Player.position.y
	
	if abs(camX - playerX) > OFFSET_CAMERA_PLAYER:
		if camX > playerX:
			$Camera2D.position.x = playerX + OFFSET_CAMERA_PLAYER
		elif camX < playerX:
			$Camera2D.position.x = playerX - OFFSET_CAMERA_PLAYER
	if abs(camY - playerY) > OFFSET_CAMERA_PLAYER:
		if camY > playerY:
			$Camera2D.position.y = playerY + OFFSET_CAMERA_PLAYER
		elif camY < playerY:
			$Camera2D.position.y = playerY - OFFSET_CAMERA_PLAYER
			

func transitionLevel(levelName):
	#get_tree().paused = true
	$Transition.get_child(0).get_child(1).text = levelName
	$Transition.get_child(0).play("Level_Fade_In")

func nextLevel():
	currentLevel += 1

	print(level)
	level.queue_free()
	level = Levels.loadScene(currentLevel)
	transitionLevel(level.name)
	$Player.position = level.get_node("PlayerStartPos").position
	call_deferred("add_child", level)
