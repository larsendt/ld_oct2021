extends Particles2D

export var verbose = false;
export(float, 0.0, 1.0, .1) var STEAM_AMOUNT = 1.0
export(float) var MAX_SCALE = 8.0
const MIN_VOL = -30
const MAX_VOL = 0
const MIN_PITCH = 1.0
const MAX_PITCH = 1.3
const MIN_VELOCITY = 100
const MAX_VELOCITY = 500

func _ready() -> void:
    MAX_SCALE = self.process_material.scale
    set_steam_amt(STEAM_AMOUNT)

func set_steam_amt(steam_amt: float) -> void:
    STEAM_AMOUNT = clamp(steam_amt, 0, 1)
    self.visible = STEAM_AMOUNT > 0
    if $SteamSound.playing != (STEAM_AMOUNT > 0):
        $SteamSound.playing = STEAM_AMOUNT > 0
    $SteamSound.pitch_scale = (STEAM_AMOUNT * (MAX_PITCH - MIN_PITCH)) + MIN_PITCH
    $SteamSound.volume_db = (STEAM_AMOUNT * (MAX_VOL - MIN_VOL)) + MIN_VOL
    self.process_material.set("scale", STEAM_AMOUNT*MAX_SCALE)

    var velocity = (STEAM_AMOUNT * (MAX_VELOCITY - MIN_VELOCITY)) + MIN_VELOCITY
    self.process_material.set("initial_velocity", velocity)
    #self.lifetime = STEAM_AMOUNT
