import ProjectDescription

let config = Config(
    plugins: [
        .local(path: .relativeToRoot("Plugins/EnvironmentPlugin")),
        .local(path: .relativeToRoot("Plugins/DependencyPlugin"))
    ]
)
