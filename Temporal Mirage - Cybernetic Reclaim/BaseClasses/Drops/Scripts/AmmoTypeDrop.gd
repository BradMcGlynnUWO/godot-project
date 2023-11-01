extends Area2D

const AmmoType = preload("res://BaseClasses/Damage/AmmoType.gd").AmmoType

var ammo_type: AmmoType = AmmoType.STANDARD

const AmmoTypesArray = [
	AmmoType.STANDARD,
	AmmoType.ACIDIC,
	AmmoType.ELECTRIC,
	AmmoType.FIRE,
	AmmoType.EXPLOSIVE,
	AmmoType.ENERGY,
	AmmoType.PIERCING,
	AmmoType.BLUDGEONING,
	AmmoType.SLASHING
]
	

@onready var ammo_label = $Label

func get_enum_size(enum_type) -> int:
	return enum_type.values().size()

func _ready():
	# Randomize ammo_type if you want
	ammo_type = AmmoTypesArray[randi() % AmmoTypesArray.size()]
	
	# Update the label to reflect the ammo type
	ammo_label.text = ammo_type_to_string(ammo_type)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.weapon_slot.ammo_type = ammo_type
		body.refill_weapon()
		body.update_ammo_display()
		queue_free()  # Remove the drop after it's picked up

func ammo_type_to_string(type: AmmoType) -> String:
	match type:
		AmmoType.STANDARD: return "Standard"
		AmmoType.ACIDIC: return "Acidic"
		AmmoType.ELECTRIC: return "Electric"
		AmmoType.FIRE: return "Fire"
		AmmoType.EXPLOSIVE: return "Explosive"
		AmmoType.ENERGY: return "Energy"
		AmmoType.PIERCING: return "Piercing"
		AmmoType.BLUDGEONING: return "Bludgeoning"
		AmmoType.SLASHING: return "Slashing"
		_: return "Unknown Ammo Type"
