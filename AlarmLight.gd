extends AnimatedSprite

export var ALARMING = false

func _ready() -> void:
    set_alarming(ALARMING)

func set_alarming(alarming: bool) -> void:
    if alarming and !ALARMING:
        self.play("flashing")
        $AlarmSound.playing = true
    elif !alarming and ALARMING:
        self.play("ok")
        $AlarmSound.playing = false
    ALARMING = alarming