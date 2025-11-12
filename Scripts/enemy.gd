extends CharacterBody2D


const SPEED = 50.0
const MAX_HEALTH = 50
const DAMAGE_DEALT = 10

var _target: Node2D = null
var direction = 1
var health

func _ready() -> void:
	health = MAX_HEALTH
	velocity.x = SPEED
	
func _physics_process(delta: float) -> void:
	_setGravity(delta)
	_move()


func _setGravity(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta

func _move():
	velocity.x = SPEED * direction
	move_and_slide()
	if _target:
		if _target.position.x > position.x:
			direction = 1
		else:
			direction = -1
	else:
		if is_on_wall():
			direction *= -1
			$Animation.flip_h = !$Animation.flip_h

func takeDamage(damage: int):
	print("enemy take damage")
	health -= damage
	if health <= 0:
		queue_free()

func _attack(body: Node2D):
	if body.has_method("takeDamage") && !body.isTakingDamage:
		body.takeDamage(DAMAGE_DEALT)
		$AttackTimer.start()


func _on_detection_zone_body_entered(body: Node2D) -> void:
	print("enter")
	_target = body


func _on_detection_zone_body_exited(body: Node2D) -> void:
	print("exit")
	if _target == body:
		_target = null


func _on_attack_zone_body_entered(body: Node2D) -> void:
	_attack(body)


func _on_attack_timer_timeout() -> void:
	var overlapping_bodies = $AttackZone.get_overlapping_bodies()
	if overlapping_bodies.size() > 0:
		for body in overlapping_bodies:
			_attack(body)
