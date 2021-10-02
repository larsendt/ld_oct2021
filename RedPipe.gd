extends Node2D

export(float, 0, 1, 0.1) var DAMAGE_AMOUNT = 1.0
export(float) var MAX_EXTERNAL_DAMAGE_VALUE = 25

signal update_damage(dmg)

func _ready() -> void:
    $YellowWheel.connect("wheel_change", self, "wheel_change")

func wheel_change(amt: float) -> void:
    damage_change(amt)

func damage_change(dmg: float) -> void:
    DAMAGE_AMOUNT = clamp(dmg, 0, 1)
    get_node("SteamEffect").set_steam_amt(DAMAGE_AMOUNT)
    get_node("SteamEffect2").set_steam_amt(DAMAGE_AMOUNT)
    get_node("SteamEffect3").set_steam_amt(DAMAGE_AMOUNT)
    get_node("SteamEffect4").set_steam_amt(DAMAGE_AMOUNT)
    emit_signal("update_damage", DAMAGE_AMOUNT * MAX_EXTERNAL_DAMAGE_VALUE)
