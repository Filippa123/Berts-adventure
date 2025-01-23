extends TileMap

class_name MazeGen

#maze_gen.gd

#Global variabels (från Globals.gd)
@export var grid_size = 5
@export var step_delay = 0.5
@export var allow_loops = false
@export var letters_to_show = []
@export var show_labels = false #bokstäver när den genererar, har int med det koden finns i MazeGen projectet i dfs

signal fringe_changed

#signal fringe_changed # vet int va den här är får vara i comment än så länge iaf (end Globals.gd)

##################################################################################################################################################################
#egna variabler test


##################################################################################################################################################################

var starting_pos = Vector2i()
const main_layer = 0
const normal_wall_atlas_coords = Vector2i(0, 0)
const walkable_atlas_coords = Vector2i(1, 1)
const SOURCE_ID = 1
var spot_to_letter = {}
var spot_to_label = {}
var current_letter_num = 65
#const label = preload()

@export var y_dim = 35
@export var x_dim = 35
@export var starting_coords = Vector2i(0, 0)

var adj4 = [
	Vector2i(-1, 0),
	Vector2i(1, 0),
	Vector2i(0, 1),
	Vector2i(0, -1),
]

func _ready() -> void: #setting size
	y_dim = grid_size
	x_dim = grid_size
	#Globals.letters_to_show.clear()
	place_border()
	#dfs(starting_coords)
	
func place_border():
	for y in range(-1, y_dim):
		place_wall(Vector2(-1, y))
	for x in range(-1, x_dim):
		place_wall(Vector2(x, -1))
	for y in range(-1, y_dim + 1):
		place_wall(Vector2(x_dim, y))
	for x in range(-1, x_dim + 1):
		place_wall(Vector2(x, y_dim))

func place_path(pos: Vector2):
	print("placed path at" + str(pos))
	#walls_array.append(pos)
	set_cell(main_layer, pos, SOURCE_ID, walkable_atlas_coords)
		
func delete_cell_at(pos: Vector2):
	
	set_cell(main_layer, pos)
	
var walls_array: Array[Vector2] 
	
func place_wall(pos: Vector2):
	print("placed wall at" + str(pos))
	walls_array.append(pos)
	set_cell(main_layer, pos, SOURCE_ID, normal_wall_atlas_coords)

func place_wall_2(pos: Vector2):
	print("placed wall at" + str(pos))
	#walls_array.append(pos)
	set_cell(main_layer, pos, SOURCE_ID, normal_wall_atlas_coords)
	
func will_be_converted_to_wall(spot: Vector2i):
	return (spot.x % 2 == 1 and spot.y % 2 == 1)
	
func is_wall(pos):
	return get_cell_atlas_coords(main_layer, pos) in [
		normal_wall_atlas_coords
	]
	
func can_move_to(current: Vector2i):
	return (
			current.x >= 0 and current.y >= 0 and\
			current.x < x_dim and current.y < y_dim and\
			not is_wall(current)
	)


func prim():
	#
	

func dfs(start: Vector2i):
	var fringe: Array[Vector2i] = [start]
	var seen = {}
	while fringe.size() > 0:
		
		var current: Vector2i 
		current = fringe.pop_back() as Vector2
		letters_to_show.pop_front()
		if current in seen or not can_move_to(current):
			if show_labels and step_delay > 0:
				await get_tree().create_timer(step_delay).timeout
			continue
			
		seen[current] = true
		if current in spot_to_label:
			for node in spot_to_label[current]:
				node.queue_free()
##			var existing_letter = find_child(spot_to_letter[current])
#			if existing_letter != null:
#				existing_letter.queue_free()
		if current.x % 2 == 1 and current.y % 2 == 1:
			place_wall(current)
			continue
			
		set_cell(main_layer, current, SOURCE_ID, walkable_atlas_coords)
		if step_delay > 0:
			await get_tree().create_timer(step_delay).timeout
		
		
		var found_new_path = false
		adj4.shuffle()
		for pos in adj4:
			var new_pos = current + pos
			if new_pos not in seen and can_move_to(new_pos):
				var chance_of_no_loop = randi_range(1, 1)
				if allow_loops:
					chance_of_no_loop = randi_range(1, 5)
				if will_be_converted_to_wall(new_pos) and chance_of_no_loop == 1:
					place_wall(new_pos)
				else:
					found_new_path = true
					fringe.append(new_pos)
					if show_labels:
						if new_pos not in spot_to_letter:
							spot_to_letter[new_pos] = char(current_letter_num)
							current_letter_num += 1
						letters_to_show.push_front(spot_to_letter[new_pos])	
						#place_label(new_pos, spot_to_letter[new_pos])
					
		#if we hit a dead end or are at a cross section
		if not found_new_path:
			place_wall(current)

	# to correct it kind of a placeholder, i hopp om att sluta få labyrinter som int funkar
	for y in range (-1, y_dim):
		for x in range (-1, x_dim):
			place_path(Vector2i(x,y))
	print("walls should be " + str(walls_array))
	for pos in walls_array:
		place_wall_2(pos)
		
	
