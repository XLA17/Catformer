extends CharacterBody2D


const SPEED = 50.0
const MAX_HEALTH = 5

var _target: Node2D = null
var direction = 1
var health

var isAttacking = false
var isDead = false
var isTakingDamage = false

var deathSound = preload("res://Sound/Enemy_death.mp3")
var attackSound = preload("res://Sound/Enemy_attack.mp3")
var hitSound = preload("res://Sound/Enemy_hit.mp3")

func _ready() -> void:
	health = MAX_HEALTH
	velocity.x = SPEED
	set_physics_process(false)
	$Animation.connect("animation_finished", Callable(self, "_on_animation_finished"))
	
func _physics_process(delta: float) -> void:
	_setGravity(delta)
	
	if !isDead:
		_move()
		#_detection()

func start():
	set_physics_process(true)
	pass

func _setGravity(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta

#func _detection(): # ne sert actuellement à rien 
	#var rc = $DetectionRayCast
	#if rc.is_colliding():
		#var collider = rc.get_collider()
		#if collider.get_parent().has_method("_dash"):
			#_target = collider.get_parent()
		#else:
			#_target = null
	#else:
		#_target = null

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
			changeDirection()

func changeDirection():
	direction *= -1
	$Animation.flip_h = !$Animation.flip_h
	$DetectionRayCast.target_position.x = -$DetectionRayCast.target_position.x

func takeDamage(damage: int):
	print("enemy take damage")
	isTakingDamage = true
	$HitTimer.start()
	health -= damage
	playSound(hitSound)
	if health <= 0:
		isDead = true
		playSound(deathSound)
		$Animation.play("death")
		$AttackZone/ColliderAttackZone.disabled = true
		$Collider.disabled = true
		$RightFootZone/CollisionShape2D.disabled = true
		$LeftFootZone/CollisionShape2D.disabled = true

func playSound(sound):
	$Audio.stream = sound
	$Audio.play()

func _attack(body: Node2D):
	if body.has_method("takeDamage") && !body.isTakingDamage && !isTakingDamage:
		body.takeDamage()
		isAttacking = true
		$AttackTimer.start()
		playSound(attackSound)

func enemyAnimation():
	if(isDead):
		return
	if(isTakingDamage):
		$Animation.play("take_damage")
	elif(isAttacking):
		$Animation.play("attack")
	else:
		$Animation.play("move") 

#func _on_detection_zone_body_entered(body: Node2D) -> void:
	#_target = body
#
#
#func _on_detection_zone_body_exited(body: Node2D) -> void:
	#if _target == body:
		#_target = null


func _on_attack_zone_body_entered(body: Node2D) -> void:
	_attack(body)


func _on_attack_timer_timeout() -> void:
	isAttacking = false
	var overlapping_bodies = $AttackZone.get_overlapping_bodies()
	if overlapping_bodies.size() > 0:
		for body in overlapping_bodies:
			_attack(body)


#func _on_death_timer_timeout() -> void:
	#queue_free()


func _on_hit_timer_timeout() -> void:
	isTakingDamage = false


func _on_foot_zone_body_exited(body: Node2D) -> void:
	changeDirection()

func _on_animation_finished():
	if $Animation.animation == "death":
		queue_free()
