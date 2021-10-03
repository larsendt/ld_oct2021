extends AnimatedSprite

export(float, 0, 1) var FLUID_HEAT = 0
const MIN_SPEED = 0.3
const MAX_SPEED = 1.5

func _ready() -> void:
    set_fluid_heat(FLUID_HEAT)

func set_fluid_heat(heat: float) -> void:
    self.material.set_shader_param("fluid_heat", clamp(heat, 0, 1))
    self.speed_scale = (heat * (MAX_SPEED - MIN_SPEED)) + MIN_SPEED 