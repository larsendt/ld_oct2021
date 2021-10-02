extends Node2D

export(float) var DPS = 30
export(float) var DAMAGE_FREQUENCY = 0.1
var dps_multiplier = 1.0

signal deal_damage(dmg)

func _ready() -> void:
    $YellowWheel.connect("wheel_change", self, "_on_wheel_change")
    $DamageTimer.connect("timeout", self, "_on_damage_timeout")
    $DamageTimer.start(DAMAGE_FREQUENCY)
    damage_change(dps_multiplier)
    $YellowWheel.set_rotation(1.0 - dps_multiplier)

func _on_wheel_change(amt: float) -> void:
    damage_change(amt)

func _on_damage_timeout() -> void:
    var dmg = DPS * dps_multiplier * DAMAGE_FREQUENCY
    if dmg > 0:
        emit_signal("deal_damage", dmg)

func damage_change(dmg: float) -> void:
    dps_multiplier = 1.0 - dmg
    for node in $Steams.get_children():
        node.set_steam_amt(dps_multiplier)
