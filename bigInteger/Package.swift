`import PackageDescription

let deps: [Package.Dependency]
#if os(Linux)
	deps = [.Package(url: "https://github.com/mdaxter/CBSD.git", majorVersion: 1)]
#else
	deps = [.Package(url: "https://github.com/mkrd/Swift-Big-Integer.git", majorVersion: 1)]
#endif

let package = Package(
    name: "BigInteger",
    dependencies: deps
)
