/**
 * Polymorphism in swift:
 Polymorphic Operators
- is checks for protocol conformance or type
For protocol conformance or super-class
- as? conditionally downcasts
Like optional unwrapping
-as forces downcasts
You better know what you're doing
 */

@objc protocol MediaType {//prefix the protocol with @objc to make is asserting work
	var contentType: String { get }
}
class Movie {
	enum Resolution: String {
		case TenEightyProgressive = "1080p"
		case SevenTwentyProgressive - "720p"
		case TenEightylnterlaced = "1080i"
	}
	var resolution: Resolution
	init(resolution: Resolution) {
		self.resolution = resolution
	}
}
class MPEG4Movie: Movie, MediaType {
	var contentType: String { return "video/mp4" }
}
class 0uicktimeMovie: Movie, MediaType {
	var contentType: String { return "video/quicktime" }
}

class Audio {
	var bitRate: Int
	init(bitRate: Int) {
		self.bitRate = bitRate
	}
}
class MP3: Audio, MediaType { 
	var contentType: String {return "audio/mpeg" }
}
class Ogg: Audio, MediaType {
	var contentType: String {return "audio/ogg" }
}

let m1   = MPEG4Movie(resolution .TenEightyProgressive)
let m2   = 0uicktimeMovie(resolutin: .SevenTwentyProgressive)
let m3  = 0uicktimeMovie(resolutin: .TenEightylnterlaced)
let al  = MP3(bitRate: 128)
let a2  = 0gg(bitRate: 128)
let a3  = MP3(bitRate: 256)
let stuff = [m1, a3, m2, a2, m3, a1, "Foobar", 123, false]
for thing in stuff {
	if thing is MediaType {
		let media = thing as MediaType
		println("Media found:\(media.contentType)")
		print("     ")
		if let movie = thing as? Movie {
			println("Movie resolution is \(movie.resolution.toRaw())")
		}else if let sound = thing as? Audio {
			println("Audio bit rate is \(sound.bitRat) kbps")
		}
	}
	else {
		println("Unknown media: \(thing)")
	}
}
