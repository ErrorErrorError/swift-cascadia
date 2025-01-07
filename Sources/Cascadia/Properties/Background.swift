public struct Background: Property, ColorRepresentable {
  public static let identifier = "background"

  public var value: Value

  public init(_ color: BackgroundColor.Value) {
    self.value = .init(color.rawValue)
  }
}

public extension PropertyValue where P == Background {
  static func url(_ string: String) -> Self {
    self.init(string)
  }
}
