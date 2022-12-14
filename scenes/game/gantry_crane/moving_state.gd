@tool
extends State


#
# FUNCTIONS TO INHERIT IN YOUR STATES
#

# This function is called when the state enters
# XSM enters the root first, the the children
func _on_enter(_args) -> void:
	print("Moving")


# This function is called just after the state enters
# XSM after_enters the children first, then the parent
func _after_enter(_args) -> void:
	pass


# This function is called each frame if the state is ACTIVE
# XSM updates the root first, then the children
func _on_update(_delta: float) -> void:
	if Input.is_action_pressed("crane_down"):
		%Wheels.position.z -= 2 * _delta
	elif Input.is_action_pressed("crane_up"):
		%Wheels.position.z += 2 * _delta
	elif Input.is_action_pressed("container_action") || Input.is_action_just_pressed("arm_down") || Input.is_action_just_pressed("arm_up") || Input.is_action_just_pressed("arm_left") || Input.is_action_just_pressed("arm_right"):
		change_state("Manipulating")



# This function is called each frame after all the update calls
# XSM after_updates the children first, then the root
func _after_update(_delta: float) -> void:
	pass


# This function is called before the State exits
# XSM before_exits the root first, then the children
func _before_exit(_args) -> void:
	pass


# This function is called when the State exits
# XSM before_exits the children first, then the root
func _on_exit(_args) -> void:
	pass


# when StateAutomaticTimer timeout()
func _state_timeout() -> void:
	pass


# Called when any other Timer times out
func _on_timeout(_name) -> void:
	pass

