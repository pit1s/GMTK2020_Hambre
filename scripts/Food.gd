class_name Food
extends KinematicBody2D

var kill_em = false
const GRAVITY = 500
const TIME_TO_DIE = 5

var coll = null
var player = null
var raycast = null
var dir = Vector2.ZERO

onready var prog_bar = get_node("ProgressBar")

enum TYPE {
	HEALTHY,
	SWEETS
}


func _ready():
#	print_debug(name, " is ready")
	dir = global_position.direction_to(get_parent().global_position)
#	print_debug("direction to player is ", dir)

#	if kill_em:
#		print_debug("wait ", TIME_TO_DIE, " then delete")
#		yield(get_tree().create_timer(TIME_TO_DIE, true), "timeout")
#		print_debug("delete that shit")
#		print_debug(position)
#		queue_free()
	
func _process(delta):
	dir = global_position.direction_to(get_parent().global_position).round()

func _physics_process(delta):
	coll = move_and_collide(dir * GRAVITY * delta)
	
func deal_damage(bite, bites_left, health):
	prog_bar.visible = true
#	print_debug(name, " has ", bites_left, " bites left")
	prog_bar.value = bites_left
	if bites_left <= 0:
#		print_debug(name, " eaten, has health value ", health)
		queue_free()
		return health
	return 0
	
func init_prog_bar(bts):
	prog_bar.visible = false
	prog_bar.max_value = bts
	prog_bar.value = bts
