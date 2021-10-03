extends Node2D


func _ready() -> void:
    set_process_input(true)

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.is_action_pressed("left_click"):
            LevelManager.go_to_game()