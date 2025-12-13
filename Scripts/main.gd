extends Node2D

const OFFSET_CAMERA_PLAYER = 30

var level: Node2D
var lateLevel: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = Levels.loadScene(Globals.levelNumber)
	$Transition.get_child(0).get_child(1).text = level.name
	$Transition.get_child(0).play("New_Level_Fade")
	level.connect("nextLevel", Callable(self, "nextLevel"))
	$Player.position = level.get_node("PlayerStartPos").position
	add_child(level)
	Ui.heartsVisibility(true)
	$Transition.connect("anim_transition_finished", Callable(self, "_on_transition_finished"))
	#print(Ui.has_node("DeathScreen"))
	Ui.get_node("DeathScreen").connect("restartLevel", Callable(self,"restartLevel"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	cameraMovement()


func _on_transition_finished():
	level.startLevel()
	$Player.start()
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
	$Transition.get_child(0).get_child(1).text = levelName
	$Transition.get_child(0).play("Next_Level_Fade")

func nextLevel():
	Globals.levelNumber += 1
	lateLevel = level
	print(level)
	level = Levels.loadScene(Globals.levelNumber)
	level.connect("nextLevel", Callable(self, "nextLevel"))
	transitionLevel(level.name)
	$LoadingTimer.start()
	$Player.pause()


func _on_loading_timer_timeout() -> void:
	lateLevel.queue_free()
	$Player.position = level.get_node("PlayerStartPos").position
	call_deferred("add_child", level)
	#$Player.get_node("Collider").disabled = false


func restartLevel() -> void:
	lateLevel = level
	print(level)
	level = Levels.loadScene(Globals.levelNumber)
	level.connect("nextLevel", Callable(self, "nextLevel"))
	transitionLevel(level.name)
	$LoadingTimer.start()
	$Player.pause()
	
