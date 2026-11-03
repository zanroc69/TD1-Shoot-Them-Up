class_name Player
extends Area2D

@export var speed: float = 600.0
@export var x_limit: float = 360.0
@export var acceleration: float = 600.0

var velocity: Vector2 = Vector2.ZERO
@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var target_velocity: Vector2 = read_direction() * speed
	velocity = velocity.move_toward(target_velocity, acceleration * delta)
	position += velocity * delta
	position.x = clamp(position.x, -x_limit, x_limit)
	sprite.rotation = deg_to_rad(15) * (velocity.x / speed)

func read_direction() -> Vector2:
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	if Input.is_action_pressed("touch"):
		var xDestination: float = get_global_mouse_position().x
		var distance_to_finger: float = xDestination - position.x
		direction.x = clamp(distance_to_finger / 60, -1, 1)
	return direction
