extends Node

var rotateable = true
var food_is_over = false
var scene_not_set = true
var screen = null
var tree = null
var total_points = 0
var game_over_points = 0

func _ready():
	print_debug(name, " is ready")
	screen = get_viewport().get_visible_rect()
	tree = get_tree()
	
func _process(delta):
	pass

func center_scene():
	return Vector2(screen.size.x/2, screen.size.y/2)
	
func update_ui(hp, pts):
	total_points = pts
	get_parent().get_node("Main/UI").update(hp, total_points)
	
func game_over():
	food_is_over = true
	print_debug("Game Over")
	game_over_points = total_points
	total_points = 0
	var game_over = load("scenes/GameOver.tscn")
	get_tree().change_scene_to(game_over)
