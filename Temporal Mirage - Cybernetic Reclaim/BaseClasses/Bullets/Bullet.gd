extends Area2D

var speed: float = 700.0
var damage: int = 10
var direction: Vector2 = Vector2.ZERO
var weapon_range: float = 100.0

var initial_position: Vector2


func _ready():
	collision_layer = 1 << 2 # This sets the third bit, representing layer 3
	collision_mask = (1 << 0) | (1 << 1)  # This sets the first and second bits, representing layers 1 (Player) and 2 (Enemy)
	initial_position = global_position

func _process(delta):
	global_position += direction * speed * delta
	if initial_position.distance_to(global_position) > weapon_range:
		print(initial_position.distance_to(global_position), global_position, weapon_range)
		queue_free()

func setup(dir: Vector2, spd: float, dmg: int, weapon_range: float) -> void:
	self.direction = dir
	self.speed = spd
	self.damage = dmg
	self.weapon_range = weapon_range

func _on_body_entered(hitbox):
	print("Bullet collided with character")
	if hitbox.is_in_group("enemies") or hitbox.is_in_group("player"):
		if hitbox.get_is_shield_active(): # Check if the character has an active shield
			reset_bullet() # Reverse the bullet's direction
		else:
			hitbox.take_damage(damage)
			queue_free()
		
func reset_bullet():
	#global_position = initial_position
	direction = -1 * direction

