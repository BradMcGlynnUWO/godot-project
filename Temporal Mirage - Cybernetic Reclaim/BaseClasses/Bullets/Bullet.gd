extends Area2D

const AmmoType = preload("res://BaseClasses/Damage/AmmoType.gd").AmmoType

var speed: float = 700.0
var damage: int = 10
var direction: Vector2 = Vector2.ZERO
var weapon_range: float = 100.0
var ammo_type: AmmoType = AmmoType.STANDARD

var initial_position: Vector2


func _ready():
	initial_position = global_position

func _process(delta):
	global_position += direction * speed * delta
	if initial_position.distance_to(global_position) > weapon_range:
		queue_free()

func setup(dir: Vector2, spd: float, dmg: int, new_weapon_range: float, ammo_type: AmmoType) -> void:
	self.direction = dir
	self.speed = spd
	self.damage = dmg
	self.weapon_range = new_weapon_range
	self.ammo_type = ammo_type
	

func _on_body_entered(hitbox):
	print("Bullet collided with something")
	if hitbox.is_in_group("enemies") or hitbox.is_in_group("player"):
		if hitbox.get_is_shield_active(): # Check if the character has an active shield
			reset_bullet() # Reverse the bullet's direction
		else:
			print("Ammo type in Bullet: ", ammo_type)
			hitbox.take_damage(damage, ammo_type)
			queue_free()

func reset_bullet():
	#global_position = initial_position
	direction = -1 * direction

