extends CanvasLayer

func set_damage(dmg: float) -> void:
    get_node("Control/DamageDisplay").text = "DAMAGE: %05d" % dmg

func set_victory() -> void:
    $Control/VictoryLabel.visible = true

func set_defeat() -> void:
    $Control/DefeatLabel.visible = true
