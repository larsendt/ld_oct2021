extends StaticBody2D

export(float) var MAX_DAMAGE = 100
var damage = 0

func _ready() -> void:
    update_damage()

func do_damage(damage_inc: float) -> void:
    self.damage = clamp(self.damage + damage_inc, 0, MAX_DAMAGE)
    update_damage()

func update_damage() -> void:
    if self.damage == 0:
        for steam in $Steams.get_children():
            steam.set_steam_amt(0)

        