extends Area2D

const GrenadeType = preload("res://BaseClasses/Damage/GrenadeType.gd").GrenadeType
const AmmoType = preload("res://BaseClasses/Damage/AmmoType.gd").AmmoType

var grenade_type: int = GrenadeType.STANDARD
var ammo_type: int = AmmoType.STANDARD

@onready var grenade_label = $Label

func _ready():
	# Randomize grenade_type and ammo_type
	grenade_type = GrenadeType.values()[randi() % GrenadeType.values().size()]
	ammo_type = AmmoType.values()[randi() % AmmoType.values().size()]
	
	# Update the labels to reflect the grenade and ammo types
	grenade_label.text = "%s (%s)" % [GrenadeType.keys()[grenade_type], AmmoType.keys()[ammo_type]]

func _on_body_entered(body):
	if body.is_in_group("player"):
		#body.set_grenade_type(grenade_type, ammo_type)
		# hardcoding to Blackhole rn as other grenade types aren't made yet
		body.set_grenade_type(GrenadeType.BLACKHOLE, ammo_type)
		body.grenades = body.max_grenades
		body.update_grenade_display()
		queue_free()  # Remove the drop after it's picked up
