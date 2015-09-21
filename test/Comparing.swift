//comparing 

var someDate = NsDateComponents()
var someOtherDate = NsDateComponents()
var thirdDate = someDate

someDate == someOtherDate//true
someDate === someOtherDate//false
someDate == thirdDate//true

//nil coalecing

//in other languages you could do:
var someVal : String = someURL != nil ? someURL : defaultURL

//in swift you would do:
//I Playground - Nil Coalescing speratur
var personalSite : String?
let defaultSite = "http:ffwww.lynda.com"
//If ... Later ...
var website : String
if persanalsite != nil {//unwrap the variable
	website = personalSite!
} else {
	website = defaultSite
}

//shorthand way of doing it, almost like to if else shorthand in other languages:
var website = personalSite ?? defaultSite

//shorthand in swift:
let x = 10, y = 20; 
let max = (x < y) ? y : x ; // So max = 20

//semi shorthand, you cant do if (true) //do something in swift,but you could do:
if num == 0 { temp = 0 }