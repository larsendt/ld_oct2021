extends Node2D

export(float) var MAX_DAMAGE = 10000
export(float) var CURRENT_DAMAGE = 0

func _ready() -> void:
    var red_pipe = get_node("YSort/RedPipe")
    red_pipe.connect("deal_damage", self, "deal_damage")
    set_damage(0)

func deal_damage(dmg_increment: float) -> void:
    set_damage(clamp(CURRENT_DAMAGE + dmg_increment, 0, MAX_DAMAGE))

func set_damage(dmg: float) -> void:
    CURRENT_DAMAGE = dmg
    $Interface.set_damage(CURRENT_DAMAGE)
