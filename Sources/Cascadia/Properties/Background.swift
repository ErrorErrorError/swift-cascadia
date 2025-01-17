public struct Background: Property, ColorRepresentable {
  public static let identifier = "background"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }
}

extension PropertyValue<Background> {
  public static func url(_ url: String) -> Self {
    Self(stringLiteral: "url(\"\(url)\")")
  }
}
