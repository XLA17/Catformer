extends CanvasLayer

var currentHeart = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#for heart in $Hearts.get_children():
		#heart.play("heart")
	$Hearts.get_child(currentHeart).play("heart")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setMaxHealth(maxHealth: int):
	$VBoxContainer/HealthBar.max_value = maxHealth
	$VBoxContainer/HealthBar.value = maxHealth

func updateHealth(health: int):
	#$VBoxContainer/HealthBar.value = health
	#$VBoxContainer/HealthBar/Health.text = str(health)
	$Hearts.get_child(currentHeart).play("empty")
	currentHeart -= 1
	if currentHeart > 0:
		$Hearts.get_child(currentHeart).play("heart")
