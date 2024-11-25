extends CharacterBody2D

@export var move_speed : float = 90

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@export var starting_direction : Vector2 = Vector2(0, 1)

func _ready():
	update_animation_parameters(starting_direction) #Bert should face down when starting

func _physics_process(_delta):
	# Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	) #down is positive, negative value means going up
	#print(input_direction)
	#update the animations
	update_animation_parameters(input_direction)
	# update velocity
	velocity = input_direction * move_speed
	#pick walk or idle
	pick_new_state()
	# Move and slide 
	move_and_slide()

func update_animation_parameters(move_input : Vector2): #Chooses animation direction
	#animation paramets are not changed when there is no move input -> idles correctly
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		

func pick_new_state(): #Changes between walking and Idling animation
	if(velocity == Vector2.ZERO):
		state_machine.travel("Idle")
	else:
		state_machine.travel("Walk")
