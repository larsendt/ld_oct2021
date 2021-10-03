extends Node2D

export(float) var DPS = 300
export(float) var DAMAGE_FREQUENCY = 0.1
export(float) var RANDOM_DAMAGE_INCREMENT = 0.1
export(float) var INITIAL_DAMAGE = 0.0
export var verbose = false
var dps_multiplier = 1.0
var cur_damage = 0.0

func _ready() -> void:
    randomize()
    $YellowWheel.connect("wheel_change", self, "_on_wheel_change")
    $DamageTimer.connect("timeout", self, "_on_damage_timeout")
    $DamageTimer.start(DAMAGE_FREQUENCY)
    $DamageHandler.connect("damage_request", self, "_on_damage_request")
    damage_change(INITIAL_DAMAGE)

func _on_wheel_change(amt: float) -> void:
    damage_change(amt)

func _on_damage_timeout() -> void:
    var dmg = DPS * dps_multiplier * DAMAGE_FREQUENCY
    if dmg > 0:
        $DamageHandler.deal_damage(dmg)

func damage_change(dmg: float) -> void:
    dmg = clamp(dmg, 0, 1)
    cur_damage = dmg
    dps_multiplier = dmg
    for node in $Steams.get_children():
        node.set_steam_amt(dps_multiplier)

    $AlarmLight.set_alarming(dmg > 0)
    $PipeFluidWindow.set_fluid_heat(dmg)

func _on_damage_request() -> void:
    if randf() < 0.2:
        damage_change(cur_damage + RANDOM_DAMAGE_INCREMENT)
        $YellowWheel.set_rotation(cur_damage + RANDOM_DAMAGE_INCREMENT)
