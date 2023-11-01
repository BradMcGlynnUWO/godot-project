extends Area2D

const GrenadeType = preload("res://BaseClasses/Damage/GrenadeType.gd").GrenadeType
const AmmoType = preload("res://BaseClasses/Damage/AmmoType.gd").AmmoType

var grenade_type: GrenadeType = GrenadeType.STANDARD
var ammo_type: AmmoType = AmmoType.STANDARD

const GrenadeTypesArray = [
	GrenadeType.STANDARD,
	GrenadeType.FLASHBANG,
	GrenadeType.EMP,  # Electric Flashbang
	GrenadeType.FRAG,
	GrenadeType.GAS,
	GrenadeType.BLACKHOLE,
	# ... Add other grenade types as needed
]

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

@onready var grenade_label = $Label
#@onready var ammo_label = $Label  # Assuming you have a separate label for ammo type

func _ready():
	# Randomize grenade_type and ammo_type
	grenade_type = GrenadeTypesArray[randi() % GrenadeTypesArray.size()]
	ammo_type = AmmoTypesArray[randi() % AmmoTypesArray.size()]
	
	# Update the labels to reflect the grenade and ammo types
	grenade_label.text = "%s (%s)" % [grenade_type_to_string(grenade_type), ammo_type_to_string(ammo_type)]
	#ammo_label.text = ammo_type_to_string(ammo_type)

func _on_body_entered(body):
	if body.is_in_group("player"):
		#body.set_grenade_type(grenade_type, ammo_type)
		# hardcoding to Blackhole rn as other grenade types aren't made yet
		body.set_grenade_type(GrenadeType.BLACKHOLE, ammo_type)
		body.grenades = body.max_grenades
		body.update_grenade_display()
		queue_free()  # Remove the drop after it's picked up

func grenade_type_to_string(type: GrenadeType) -> String:
	match type:
		GrenadeType.STANDARD: return "Standard"
		GrenadeType.FLASHBANG: return "Flashbang"
		GrenadeType.EMP: return "EMP"
		GrenadeType.FRAG: return "Frag"
		GrenadeType.GAS: return "Gas"
		GrenadeType.BLACKHOLE: return "Blackhole"
		# ... Add other grenade types as needed
		_: return "Unknown Grenade Type"

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
