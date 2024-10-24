extends CharacterBody2D

@export var move_speed : float = 90


func _physics_process(_delta):
	# Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	) #down is positive, negative value means going up
	#print(input_direction)
	# update velocity
	velocity = input_direction * move_speed
	
	# Move and slide 
	move_and_slide()
