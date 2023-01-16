// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let application = Target.target(
    name: "Application",
    path: "components/private/Application/",
    sources: ["src"],
    publicHeadersPath: "src")

let availability = Target.target(
    name: "Availability",
    path: "components/Availability",
    publicHeadersPath: "src")

let color = Target.target(
    name: "Color",
    dependencies: [
        .target(name: availability.name)
    ],
    path: "components/private/Color/",
    sources: ["src"],
    publicHeadersPath: "src")

let math = Target.target(
    name: "Math",
    path: "components/private/Math/",
    sources: ["src"],
    publicHeadersPath: "src")

let elevation = Target.target(
    name: "Elevation",
    dependencies: [
        .target(name: availability.name),
        .target(name: color.name),
        .target(name: math.name)
    ],
    path: "components/Elevation/",
    sources: [
        "src"
    ],
    publicHeadersPath: "src")


let keyboardWatcher = Target.target(
    name: "KeyboardWatcher",
    dependencies: [
        .target(name: application.name),
    ],
    path: "components/private/KeyboardWatcher/",
    sources: ["src"],
    publicHeadersPath: "src")

let shadowElevations = Target.target(
    name: "ShadowElevations",
    path: "components/ShadowElevations/",
    sources: [
        "src",
    ],
    publicHeadersPath: "src")

let shadowLayer = Target.target(
    name: "ShadowLayer",
    dependencies: [
        .target(name: shadowElevations.name)
    ],
    path: "components/ShadowLayer/",
    sources: [
        "src"
    ],
    publicHeadersPath: "src")

let shapes = Target.target(
    name: "Shapes",
    dependencies:[
        .target(name: shadowLayer.name),
        .target(name: color.name),
        .target(name: math.name)
    ],
    path: "components/Shapes/",
    sources: [
        "src"
    ],
    publicHeadersPath: "src")

let shapeLibrary = Target.target(
    name: "ShapeLibrary",
    dependencies:[
        .target(name: shapes.name)
    ],
    path: "components/ShapeLibrary/",
    sources: [
        "src"
    ],
    publicHeadersPath: "src")


let package = Package(
    name: "Material Components iOS",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MaterialComponents",
            targets: [
                "BottomSheet"
            ]),
    ],
    targets: [
        availability,
        application,
        color,
        math,
        keyboardWatcher,
        shadowElevations,
        shadowLayer,
        shapes,
        shapeLibrary,
        elevation,
        .target(
            name: "BottomSheet",
            dependencies:[
                .target(name: elevation.name),
                .target(name: shapeLibrary.name),
                .target(name: shapes.name),
                .target(name: shadowElevations.name),
                .target(name: shadowLayer.name),
                .target(name: keyboardWatcher.name),
                .target(name: math.name),
            ],
            path: "components/BottomSheet/",
            sources: [
                "src"
            ],
            publicHeadersPath: "src"),
    ])
