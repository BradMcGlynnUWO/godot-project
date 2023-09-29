extends Node2D

# Exported variables
@export var speed: float = 200.0
@export var detection_radius: float = 300.0

# Onready variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var detection_area: Area2D = $Area2D

# Private variables
var target: Node2D = null
var velocity: Vector2 = Vector2.ZERO

func _ready():
	detection_area.connect("body_entered", Callable(self, "_on_body_entered"))
	detection_area.connect("body_exited", Callable(self, "_on_body_exited"))
	var detection_shape: CircleShape2D = CircleShape2D.new()
	detection_shape.radius = detection_radius
	($Area2D/CollisionShape2D).shape = detection_shape

func _physics_process(delta):
	if target:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed
		animated_sprite.play("run")
	else:
		velocity = Vector2.ZERO
		animated_sprite.play("idle")
	global_transform.origin += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = body

func _on_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
