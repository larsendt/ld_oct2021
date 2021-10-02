extends Node2D

export(float) var ROTATION_PER_CLICK = 0.25
export(float) var ROTATION_SPEED = 0.1
const MIN_ROTATION = 0
const MAX_ROTATION = 1.0

signal wheel_change(amt)
var highlighted: bool
var desired_rotation_frac = 0.0

func _ready():
    set_process_input(true)
    set_rotation(0)
    $RotationTimer.connect("timeout", self, "_on_RotationTimer_timeout")
    $Area2D.connect("mouse_entered", self, "_on_mouse_entered")
    $Area2D.connect("mouse_exited", self, "_on_mouse_exited")

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and self.highlighted:
        if event.is_action_pressed("left_click"):
            increment_rotation(1)
        elif event.is_action_pressed("right_click"):
            increment_rotation(-1)

func _process(delta: float) -> void:
    if abs(cur_rot_frac() - self.desired_rotation_frac) < 0.05:
        return
    
    var direction
    if cur_rot_frac() > self.desired_rotation_frac:
        direction = -1
    else:
        direction = 1

    var inc = ROTATION_SPEED * delta * direction
    $RotationContainer.rotation += inc * TAU
    $SmallProgressBar.set_progress(cur_rot_frac())
    emit_signal("wheel_change", cur_rot_frac())

func increment_rotation(direction: float) -> void:
    var r = self.cur_rot_frac() + (direction * ROTATION_PER_CLICK)
    set_rotation(r)

func set_rotation(rot_frac: float) -> void:
    self.desired_rotation_frac = clamp(rot_frac, MIN_ROTATION, MAX_ROTATION)

func cur_rot_frac() -> float:
    return $RotationContainer.rotation / TAU

func _on_mouse_entered():
    get_node("RotationContainer/wheel_highlight").visible = true
    self.highlighted = true

func _on_mouse_exited():
    get_node("RotationContainer/wheel_highlight").visible = false
    self.highlighted = false
