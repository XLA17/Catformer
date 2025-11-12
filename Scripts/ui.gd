extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func setMaxHealth(maxHealth: int):
	$VBoxContainer/HealthBar.max_value = maxHealth
	$VBoxContainer/HealthBar.value = maxHealth

func updateHealth(health: int):
	$VBoxContainer/HealthBar.value = health
	$VBoxContainer/HealthBar/Health.text = str(health)
