extends Node2D

export(float, 0, 1, 0.01) var PROGRESS = 0.0

func _ready() -> void:
    set_progress(PROGRESS)

func set_progress(amt: float) -> void:
    PROGRESS = clamp(amt, 0, 1)
    $Inner.region_rect.size.x = PROGRESS * 128
