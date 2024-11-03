extends StaticBody2D
class_name ItemContainer
signal open(pos, direction)

# All objects face down initially, if the object is rotated, the current direction will be saved
@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
var opened: bool = false
