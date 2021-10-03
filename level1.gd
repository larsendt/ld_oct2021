extends Node2D

export var INITIAL_DAMAGE = 100
var damage_fixed = false

func _ready() -> void:
    set_process_input(true)
    $DamageTimer.connect("timeout", self, "_on_DamageTimer_timeout")
    var red_pipe = get_node("YSort/RedPipe")
    red_pipe.connect("deal_damage", self, "deal_damage")
    set_damage(INITIAL_DAMAGE)

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and (damage_fixed or $YSort/Reactor.is_destroyed()):
        if event.is_action_pressed("left_click"):
            LevelManager.go_to_splashscreen()

func deal_damage(dmg_increment: float) -> void:
    $YSort/Reactor.do_damage(dmg_increment)
    $Interface.set_damage($YSort/Reactor.damage)

    if $YSort/Reactor.damage == 0:
        damage_fixed = true
        $Interface.set_victory()
    elif $YSort/Reactor.is_destroyed():
        $Interface.set_defeat()


func set_damage(dmg: float) -> void:
    $YSort/Reactor.update_damage(dmg)
    $Interface.set_damage($YSort/Reactor.damage)

func _on_DamageTimer_timeout() -> void:
    if !damage_fixed:
        get_tree().call_group("DamageHandlers", "request_more_damage")

func do_shake():
    $Camera2D.set_shake(1.0)
