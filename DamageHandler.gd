extends Node2D

signal damage_request()

func deal_damage(amt: float) -> void:
    get_node("/root/Level1").deal_damage(amt)

func request_more_damage() -> void:
    emit_signal("damage_request")