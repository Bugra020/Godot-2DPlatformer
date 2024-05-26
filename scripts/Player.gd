extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var on_floor
var landed
var jump_progress
var attacking = false
@onready var _animation = $AnimatedSprite2D

func _physics_process(delta):
	on_floor = is_on_floor()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_pressed("jump"):
		if on_floor:
			velocity.y = JUMP_VELOCITY
		elif (_animation.animation=="landing"):
			velocity.y = JUMP_VELOCITY
		elif (_animation.animation=="idle" or _animation.animation=="walking"):
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()

func _process(delta):
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")
	if left:
		_animation.flip_h = false
	elif right:
		_animation.flip_h = true
	
	if _animation.animation =="landing" and _animation.frame_progress == 1:
		landed = true
	if _animation.animation =="jumping" and _animation.frame_progress == 1 and not on_floor:
		_animation.frame = 10
	if _animation.animation == "melee_attack" and _animation.frame == 8:
		attacking = false
	if _animation.animation != "melee_attack":
		attacking = false
		
	if left and on_floor:
		_animation.play("walking")
	elif right and on_floor:
		_animation.play("walking")
	elif Input.is_action_pressed("jump") and not on_floor:
		_animation.play("jumping")
		landed = false
	elif not on_floor:
		_animation.play("jumping")
		landed = false
	elif on_floor and landed==false and not attacking:
		_animation.play("landing")
	elif on_floor and landed:
		if Input.is_action_pressed("melee_attack") and not attacking:
			_animation.play("melee_attack")
			attacking = true;
		elif not attacking:
			_animation.play("idle")
	elif right and left and not attacking:
		_animation.play("idle")








