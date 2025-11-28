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

func emptyHealth():
	for heart in $Hearts.get_children():
		heart.play("empty")
