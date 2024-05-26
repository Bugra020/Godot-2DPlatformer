extends CharacterBody2D


const SPEED = 0.5
var rng = RandomNumberGenerator.new()
var direction
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animation = $AnimatedSprite2D

func _ready():
	while direction != 0:
		direction = rng.randf_range(-1, 1)
		
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
	
func _process(delta):
	position.x += direction * SPEED
	
	if(rng.randi_range(0, 30) == 1):
		if direction == 1:
			direction = -1
			_animation.flip_h = true
		else: 
			direction = 1
			_animation.flip_h = false
	
	_animation.play("idle_walking")
