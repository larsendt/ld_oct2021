extends CanvasLayer

func set_damage(dmg: float) -> void:
    get_node("Control/DamageDisplay").text = "DAMAGE: %05d" % dmg