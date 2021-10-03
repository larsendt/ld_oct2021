extends StaticBody2D

export(float) var MAX_DAMAGE = 10000
export var damage = 0.0 setget update_damage

func _ready() -> void:
    update_damage(0)

func is_destroyed():
    return damage_frac() >= 1.0

func do_damage(damage_inc: float) -> void:
    self.damage = clamp(self.damage + damage_inc, 0, MAX_DAMAGE)

func update_damage(new_damage) -> void:
    damage = new_damage

    var do_explode = false;
    if enable_alarms_after(0.05):
        do_explode = true
    enable_steams_after(0.1)

    if enable_crack_after("Cracks/ReactorCrack", 0.2):
        do_explode = true
    if enable_crack_after("Cracks/ReactorCrack2", 0.4):
        do_explode = true
    if enable_crack_after("Cracks/ReactorCrack3", 0.6):
        do_explode = true
    if enable_crack_after("Cracks/ReactorCrack4", 0.8):
        do_explode = true
    if enable_crack_after("Cracks/ReactorCrack5", 1.0):
        do_explode = true

    if do_explode and !$ExplosionSound.playing:
        $ExplosionSound.playing = true
        get_node("/root/Level1").do_shake()



func enable_alarms_after(value: float) -> bool:
    var enabled = false
    if damage_frac() >= value:
        if !$AlarmSound.playing:
            $AlarmSound.playing = true
            enabled = true
    elif $AlarmSound.playing:
        $AlarmSound.playing = false

    for light in $Lights.get_children():
        if damage_frac() >= value:
            if !light.playing:
                light.playing = true
                enabled = true
        elif light.playing:
            light.playing = false

    return enabled


func enable_crack_after(path: String, value: float) -> bool:
    var enabled = false
    var crack = get_node(path)
    if damage_frac() >= value:
        if !crack.enabled:
            crack.set_enabled(true)
            enabled = true
    elif crack.enabled:
        crack.set_enabled(false)
    return enabled

func enable_steams_after(value: float) -> void:
    for steam in $Steams.get_children():
        if damage_frac() >= value:
            steam.set_steam_amt(damage_frac())
        elif steam.STEAM_AMOUNT > 0:
            steam.set_steam_amt(0)

        
func damage_frac() -> float:
    return damage / MAX_DAMAGE

        
