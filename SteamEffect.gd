extends Particles2D

export(float, 0.0, 1.0, .1) var STEAM_AMOUNT = 1.0
export(float) var MAX_SCALE = 4.0

func set_steam_amt(steam_amt: float) -> void:
    self.process_material.set("scale", steam_amt*MAX_SCALE)
    self.lifetime = steam_amt
