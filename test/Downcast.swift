let myButton    = UIButton()
let myS1ider    = UISlider()
let myTextFie1d = UITextFie1d()
let myDatePicker = UIDatePicker()
let controls = [myButton, mySlider, myTextField, myDatePicker]

//type casting
for item in controls {
	// option 1: check type with "is"
	if item is UIDatePicker {
		println("We have a UIDatePicker")
	}
	// downcast with "as"
	let picker = item as UIDatePicker
		picker.datePickerMode = UIDatePickerMode.CountDownTimer
	}
	// option 2: try to downcast with as?
	let picker = item as? UIDatePicker
	// then check if it worked, and unwrap the optional
	if picker != nil {
		picker!.datePickerMode = UIDatePickerMode.CountDownTimer
	}
	// option 3 - combine
	if let picker = item as? UIDatePicker {//this is like doing: var picker = picker is UIDatePicker ? picker as UIDatePicker : picker; in another language
		picker.datePickerMode = UIDatePickerMode.CountDownTimer
	}                                      I
}