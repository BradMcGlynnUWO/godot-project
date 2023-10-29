class_name BaseCharacter
extends CharacterBody2D

var health: int = 100
var movement_speed: float = 200.0
var weapon_slot = null # You can assign a weapon class instance here.

func _ready():
	pass

func take_damage(amount: int) -> void:
	health -= amount
	print(health)
	if health <= 0:
		die()


func die() -> void:
	queue_free() # Override this method to perform specific actions upon death.
	
func get_is_shield_active() -> bool:
	return false

func apply_knockback(direction: Vector2, magnitude: float):
	var start_position = global_position
	var end_position = start_position + direction * magnitude
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	#tween.tween_property(self, "global_position",start_position, 1).as_relative()
	tween.tween_property(self, "global_position",end_position, 1)
	await tween.finished
	

func swap_weapon(new_weapon_class: Script) -> bool:
	# add conditions for swapping
	if not Input.is_key_pressed(KEY_E):
		return false
	
	if new_weapon_class:
		# Remove the current weapon
		if weapon_slot:
			weapon_slot.queue_free()
		
		# Instantiate the new weapon and assign it to the weapon slot
		var new_weapon_instance = new_weapon_class.new()
		add_child(new_weapon_instance)
		weapon_slot = new_weapon_instance
	
	return true


