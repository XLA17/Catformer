extends CanvasLayer

var currentHeart = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Hearts.get_child(currentHeart).play("heart")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

#func setMaxHealth(maxHealth: int):
	#$VBoxContainer/HealthBar.max_value = maxHealth
	#$VBoxContainer/HealthBar.value = maxHealth

func updateHealth(hp):
	if(hp > 0):
		$Hearts.get_child(currentHeart).play("empty")
	else:
		$Hearts.get_child(currentHeart).stop()
	currentHeart -= hp
	if currentHeart >= 0:
		$Hearts.get_child(currentHeart).play("heart")

func setHealth(hp):
	currentHeart = hp
	var hearts = $Hearts.get_child_count()
	for i in range(hearts):
		var heart = $Hearts.get_child(i)
		if i < currentHeart:
			heart.play("heart")
			heart.stop()
		elif i == currentHeart:
			heart.play("heart")
		else:
			heart.play("empty")

func emptyHealth():
	for heart in $Hearts.get_children():
		heart.play("empty")
		
func heartsVisibility(visibility):
	$Hearts.visible = visibility
	
func winVisibility(visibility):
	$win_screen.visible = visibility
	
func deathVisibility(visibility):
	$DeathScreen.visible = visibility

func enableNextButton(value: bool):
	$win_screen.enableNextButton(value)
