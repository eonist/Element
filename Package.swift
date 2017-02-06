import PackageDescription

let package = Package(
    name: "Element",
	dependencies: [
		.Package(url: "https://github.com/eonist/swift-utils.git", majorVersion: 1, minor:1)
    ],
	exclude: ["README.md"]
)