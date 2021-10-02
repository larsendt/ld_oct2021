extends KinematicBody2D

export(float) var PLAYER_SPEED = 200

func _ready() -> void:
    pass 

func _physics_process(_delta: float) -> void:
    var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    var y_input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    var input = Vector2(x_input, y_input)
    var velocity = input * PLAYER_SPEED;
    velocity = move_and_slide(velocity)