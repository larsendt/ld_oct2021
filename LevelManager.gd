extends Node

var levels = [
        "res://IntroScreen.tscn",
        "res://level1.tscn",
    ]
var current_level = levels[0]
var cur_level_idx = 0

func _ready() -> void:
    pass

func go_to_game() -> void:
    current_level = levels[1]
    get_tree().change_scene(current_level)

func go_to_splashscreen() -> void:
    current_level = levels[0]
    get_tree().change_scene(current_level)

func is_splashscreen():
    print("is spl ", current_level, levels[0])
    return current_level == levels[0]
