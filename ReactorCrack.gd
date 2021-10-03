extends Node2D

enum VARIANT { ONE, TWO, THREE, FOUR, FIVE }
export(VARIANT) var variant = VARIANT.ONE setget display_variant
export var enabled = false setget set_enabled

func _ready() -> void:
    display_variant(self.variant)
    set_enabled(false)

func set_enabled(new_enabled: bool) -> void:
    enabled = new_enabled
    if enabled:
        display_variant(self.variant)
        if !LevelManager.is_splashscreen():
            $AudioStreamPlayer2D.playing = true
    else:
        for v in self.get_children():
            v.visible = false
        $AudioStreamPlayer2D.playing = false

func display_variant(new_variant) -> void:
    variant = new_variant
    for v in self.get_children():
        v.visible = false

    match self.variant:
        VARIANT.ONE: 
            $Variant1.visible = true
        VARIANT.TWO:
            $Variant2.visible = true
        VARIANT.THREE: 
            $Variant3.visible = true
        VARIANT.FOUR:
            $Variant4.visible = true
        VARIANT.FIVE: 
            $Variant5.visible = true
