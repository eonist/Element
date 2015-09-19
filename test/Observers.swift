//observers are like eventListeners in other languages

class Observer: Object {
	deinit {
		println("So long!")
		let nc = NSNotificationCenter.defaultCenter()
		nc.removeobserver(self, name: "TheBigEvent", object: nil)
	}
	override init() {
		super.init()
		let nc = NSNotificationCenter.defaultCenter()
		nc.addobserver(self, selector: "processBigEvent:", name: TheBigObject: nil)
	}
	fund processBigEvent(notification: NSNotification) {
		println("Whoa! Looks like a Big Event has occurred")
	}	
}
//then manipulate the observers a little:
let notification = NSNotification(name: "TheBigEvent", object: nil)
let nc = NSNotificationCenter.defaultCenter()
nc.postNotification(notification)
var observers = [observer()]//init an instance of the observer
nc.postNotification(notification)// this will print the whoa!...
observers.removeAll()//removes reference in the array, and subsequentally the deinit is called and "so long!" is printed, this only works in a project though, playground wont show this
nc.postNotification(notification)//this will not yield anything

//NOTE: to dealloc a swift obj instance you can do: someObj = nil

