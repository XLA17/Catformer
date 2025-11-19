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

func updateHealth():
	$Hearts.get_child(currentHeart).play("empty")
	currentHeart -= 1
	if currentHeart >= 0:
		$Hearts.get_child(currentHeart).play("heart")
