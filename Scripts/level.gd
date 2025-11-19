extends Node2D

signal nextLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_next_level_zone_body_entered(_body: Node2D) -> void:
	emit_signal("nextLevel")

func startLevel():
	for enemy in $Enemies.get_children():
		enemy.start()
	pass
