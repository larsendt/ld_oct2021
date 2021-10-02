extends Node2D

export(float) var ROTATION_SPEED = 0.5
const MIN_ROTATION = 0
const MAX_ROTATION = 3.14 * 2

signal wheel_change(amt)
var rotation_dir: float = 0
var highlighted: bool

func _ready():
    set_process_input(true)
    $RotationTimer.connect("timeout", self, "_on_RotationTimer_timeout")
    $Area2D.connect("mouse_entered", self, "_on_mouse_entered")
    $Area2D.connect("mouse_exited", self, "_on_mouse_exited")

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and self.highlighted:
        if event.is_action_pressed("left_click"):
            self.rotation_dir = 1
        else:
            self.rotation_dir = -1

func _process(delta: float) -> void:
    self.rotation = clamp(self.rotation + (rotation_dir * delta * ROTATION_SPEED), MIN_ROTATION, MAX_ROTATION)
    if rotation_dir != 0:
        var rot_amt = 1.0 - (self.rotation / MAX_ROTATION)
        emit_signal("wheel_change", rot_amt)

func _on_mouse_entered():
    $wheel_highlight.visible = true
    self.highlighted = true

func _on_mouse_exited():
    $wheel_highlight.visible = false
    self.highlighted = false

func _on_RotationTimer_timeout():
    self.rotation_dir = 0
