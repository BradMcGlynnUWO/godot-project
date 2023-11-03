extends Area2D

const AmmoType = preload("res://BaseClasses/Damage/AmmoType.gd").AmmoType

var ammo_type: int = AmmoType.STANDARD

@onready var ammo_label = $Label

func get_enum_size(enum_type) -> int:
	return enum_type.values().size()

func _ready():
	# Randomize ammo_type if you want
	ammo_type = AmmoType.values()[randi() % AmmoType.values().size()]
	
	# Update the label to reflect the ammo type
	ammo_label.text = AmmoType.keys()[ammo_type]

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.weapon_slot.ammo_type = ammo_type
		body.refill_weapon()
		body.update_ammo_display()
		queue_free()  # Remove the drop after it's picked up

