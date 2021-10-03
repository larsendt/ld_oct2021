extends AnimatedSprite

export var DAMAGE_PER_SECOND = 100
export var asdf_on = false setget set_on
var hovered = false

func _ready() -> void:
    $Area2D.connect("mouse_entered", self, "_on_mouse_entered")
    $Area2D.connect("mouse_exited", self, "_on_mouse_exited")
    set_process_input(true)
    set_on(false)

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and self.hovered:
        if event.is_action_pressed("left_click"):
            set_on(true)
        elif event.is_action_released("left_click"):
            set_on(false)

func _process(delta: float) -> void:
    if asdf_on:
        $DamageHandler.deal_damage(-1 * DAMAGE_PER_SECOND * delta)

func set_on(o: bool) -> void:
    asdf_on = o
    if asdf_on:
        self.set_animation("on")
    else:
        self.set_animation("off")

func _on_timer_timeout() -> void:
    self.on = false

func _on_mouse_entered():
    self.hovered = true

func _on_mouse_exited():
    self.hovered = false
    set_on(false)
