extends Camera2D

export var FALLOFF = 0.7
export var MAX_SHAKE = 50.0
export var current_shake = 0.0 setget set_shake

func _ready():
    randomize()

func _process(delta: float):
    current_shake = clamp(current_shake - (FALLOFF * delta), 0, 1)
    offset.x = MAX_SHAKE * current_shake * rand_range(-1, 1)
    offset.y = MAX_SHAKE * current_shake * rand_range(-1, 1)

func set_shake(new_shake: float) -> void:
    current_shake = new_shake