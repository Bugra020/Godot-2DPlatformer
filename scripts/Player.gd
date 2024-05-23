extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var on_floor

@onready var _animaiton = $AnimatedSprite2D

func _physics_process(delta):
	on_floor = is_on_floor()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
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
	if Input.is_action_pressed("move_left") and on_floor:
		_animaiton.flip_h = false
		_animaiton.play("walking")
	elif Input.is_action_pressed("move_right") and on_floor:
		_animaiton.flip_h = true
		_animaiton.play("walking")
	elif Input.is_action_pressed("jump") and not on_floor:
		_animaiton.play("jumping")
	else:
		_animaiton.stop()










