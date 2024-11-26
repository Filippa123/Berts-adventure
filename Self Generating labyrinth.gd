extends Node2D

#main.gd 
const maze = preload("res://Constructs/labyrinth_self_gen_tile_map.tscn")

var hud_enabled = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("show_hud"):
		hud_enabled = not hud_enabled
		$"CanvasLayer".set_visible(hud_enabled)

	if Input.is_action_just_pressed("reset"):
		var new_maze = maze.instantiate()
		var existing_maze = get_children().filter(func(x):
			return "TileMap" in x.name)[0]
		existing_maze.queue_free()
		add_child(new_maze)
