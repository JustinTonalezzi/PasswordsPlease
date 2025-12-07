extends MoveableDocument
class_name Passport

@export var character_data: CharacterResource

@onready var basic_details: RichTextLabel = $TabContainer/Page/PersonalDetail
@onready var top_serial: Label = $TabContainer/Page/TopSerial
@onready var face_photo: TextureRect = $TabContainer/Page/Photo

func _ready() -> void:
	super()
	populate_passport_data()

func populate_passport_data():
	if character_data == null:
		return
	
	var storage = ""
	
	if character_data.gender == EnumAutoload.Gender.OTHER:
		storage = "Other"
	
	if character_data.gender == EnumAutoload.Gender.MANAGER:
		storage = random_pwmanager(character_data.breached_manager, character_data.day3yes)
		
	# expiry date generation --> swap to password length
	var expired_date = random_generate_date(character_data.birthdate, character_data.passport_expired)
	
	basic_details.text = basic_details.text.format({"name": character_data.name, "dob": character_data.birthdate, "storage": storage, "expired_date": expired_date})
	top_serial.text = character_data.id_number
	face_photo.texture = character_data.face_photo

func random_generate_date(_birthdate: String, expired: bool) -> String:
	# Create a random number generator
	var rng = RandomNumberGenerator.new()

	var year = rng.randi_range(12, 28)
	if expired:
		year = rng.randi_range(6, 11)

	var date_str = str(year, " characters")

	return date_str
	
# Create random pw manager selection
func random_pwmanager(breached: bool, day3yes: bool) -> String:
	var my_strings = ["FirstPass", "BitWardened", "1Key",
	"KeeMaybe", "Safe-Ish", "TitanicPass"]
	var random_string = my_strings.pick_random()
	
	if breached:
			var breached_strings = ["KeeMaybe", "Safe-Ish", "TitanicPass"]
			random_string = breached_strings.pick_random()
	
	if day3yes:
			var safe_strings = ["FirstPass", "BitWardened", "1Key"]
			random_string = safe_strings.pick_random()
	
	return random_string
	
