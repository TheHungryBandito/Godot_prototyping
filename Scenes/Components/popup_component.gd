class_name PopupComponent
extends Control


@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var timer: Timer = $Timer
@onready var popup_time: float = 1.0

func _ready():
	rich_text_label.clear()
	timer.timeout.connect(clear_text)
	
func popout_text(text: String, color: Color, time: float = popup_time):
	timer.stop()
	clear_text()
	rich_text_label.push_bgcolor(Color.LIGHT_SLATE_GRAY)
	rich_text_label.push_bold()
	rich_text_label.push_color(color)
	rich_text_label.append_text(text)
	rich_text_label.pop()
	rich_text_label.pop()
	rich_text_label.pop()
	timer.start(time)

func clear_text():
	rich_text_label.clear()

