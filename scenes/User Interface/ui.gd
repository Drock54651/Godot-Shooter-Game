extends CanvasLayer

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar
# Colors
var green: Color = Color("6bbfa3")
var red: Color = Color(.9, 0, 0, 1)

func _ready() -> void:
	Globals.connect("stat_change", update_stats)
	
	# So that the amounts persists after a scene change
	update_laser_text()
	update_grenade_text()
	update_health_text()
	
func update_stats():
	update_laser_text()
	update_grenade_text()
	update_health_text()
	
func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, $LaserCounter)

func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, $GrenadeCounter)
	
func update_health_text():
	health_bar.value = Globals.health
	
func update_color(amount: int, node: Control):
	if amount > 0:
		node.modulate = green
	else:
		node.modulate = red
	
	
