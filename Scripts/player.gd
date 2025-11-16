extends CharacterBody2D


const SPEED = 200.0
const ACCELERATION = 1000.0
const FRICTION = 2000.0
const JUMP_VELOCITY = -300.0
const DASH_SPEED = 600.0
const MAX_HEALTH = 100
const DAMAGE_DEALT = 20

var floatingTime = 0.0
var isDashing = false
var isAttacking = false
var isDead = false
var isTakingDamage = false
var health

var deathSound = preload("res://Sound/Death_sound.mp3")
var attackSound = preload("res://Sound/Attack_sound.wav")

func _ready() -> void:
	health = MAX_HEALTH
	Ui.setMaxHealth(MAX_HEALTH)

func _physics_process(delta: float) -> void:

	if !isDead:
		_setGravity(delta)
		_dash()
		_jump()
		_move(delta)
		_attack()
		move_and_slide()
		_animation_played()
	

func _setGravity(delta: float):
	if not is_on_floor():
		floatingTime += delta
		velocity += get_gravity() * delta
	else:
		floatingTime = 0.0

func _move(delta: float):
	if isDashing:
		return
	
	var input = Input.get_axis("move_left", "move_right")
	if input:
		velocity = velocity.move_toward(Vector2(input * SPEED, velocity.y), delta * ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2(0, velocity.y), delta * FRICTION)

func _jump():
	if isDashing:
		return
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or floatingTime <= 0.1):
		velocity.y = JUMP_VELOCITY


func _dash():
	if Input.is_action_just_pressed("dash") and !isDashing:
		isDashing = true
		$DashTimer.start()
		if $Animation.flip_h:
			velocity.x = -DASH_SPEED
		else:
			velocity.x = DASH_SPEED


func _attack():
	if Input.is_action_just_pressed("attack") && !isAttacking:
		print("attack")
		isAttacking = true
		playSound(attackSound)
		if abs(velocity.x) > 0.01 || abs(velocity.y) > 0.01:
			$Animation.play("Jump_Attack")
		else:
			$Animation.play("Attack")
		$AttackTimer.start()
		var overlapping_bodies = $AttackZone.get_overlapping_bodies()
		if overlapping_bodies.size() > 0:
			for body in overlapping_bodies:
				if body.has_method("takeDamage"):
					body.takeDamage(DAMAGE_DEALT)

func takeDamage(damage: int):
	if health <= 0:
		return
	print("Player take damage")
	$Animation.play("Take_Damage")
	isTakingDamage = true
	health -= damage
	Ui.updateHealth(health)
	$InvulnerabilityTimer.start()
	if health <= 0:
		health = 0
		Ui.updateHealth(health)
		isDead = true
		playSound(deathSound)
		$Animation.play("Death")

func playSound(sound):
	$Audio.stream = sound
	$Audio.play()


func _animation_played():
	if isTakingDamage:
		$Animation.play("Take_Damage")
		return
	if isDashing:
		$Animation.play("Roll")
		return
	if isAttacking:
		return
	if velocity.x > 0.01:
		$Animation.play("Run")
		$Animation.flip_h = false
		$AttackZone/ColliderAttackZone.position.x = abs($AttackZone/ColliderAttackZone.position.x)
		return
	elif velocity.x < -0.01:
		$Animation.play("Run")
		$Animation.flip_h = true
		$AttackZone/ColliderAttackZone.position.x = -abs($AttackZone/ColliderAttackZone.position.x)
		return
	elif velocity.y < -0.01:
		$Animation.play("Jump")
		return
	elif velocity.y > 0.01:
		$Animation.play("Fall")
		return
	else:
		$Animation.play("Idle")
		return


func _on_dash_timer_timeout() -> void:
	velocity.x = 0.0
	isDashing = false


func _on_attack_timer_timeout() -> void:
	isAttacking = false


func _on_invulnerability_timer_timeout() -> void:
	isTakingDamage = false
