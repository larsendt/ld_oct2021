extends Node2D

export(float) var ROTATION_PER_CLICK = 0.1
const MIN_ROTATION = 0
const MAX_ROTATION = 1.0

signal wheel_change(amt)
var highlighted: bool
var rotation_frac = 0.0

func _ready():
    set_process_input(true)
    set_rotation(rotation_frac)
    $RotationTimer.connect("timeout", self, "_on_RotationTimer_timeout")
    $Area2D.connect("mouse_entered", self, "_on_mouse_entered")
    $Area2D.connect("mouse_exited", self, "_on_mouse_exited")

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and self.highlighted:
        if event.is_action_pressed("left_click"):
            increment_rotation(1)
        elif event.is_action_pressed("right_click"):
            increment_rotation(-1)

func increment_rotation(direction: float) -> void:
    set_rotation(self.rotation_frac + (direction * ROTATION_PER_CLICK))

func set_rotation(rot_frac: float) -> void:
    print(rot_frac)
    self.rotation_frac = clamp(rot_frac, MIN_ROTATION, MAX_ROTATION)
    $RotationContainer.rotation = self.rotation_frac * 3.14
    $SmallProgressBar.set_progress(self.rotation_frac)
    emit_signal("wheel_change", self.rotation_frac)

func _on_mouse_entered():
    get_node("RotationContainer/wheel_highlight").visible = true
    self.highlighted = true

func _on_mouse_exited():
    get_node("RotationContainer/wheel_highlight").visible = false
    self.highlighted = false
