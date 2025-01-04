let background = Background.init

public struct Background: Property {
  public static let name = "background"

  public var value: PropertyValue<Self>

  public init(_ value: PropertyValue<Self>) {
    self.value = value
  }
}

public extension PropertyValue where P == Background {
  static func url(_ string: String) -> Self {
    self.init(string)
  }

  static func color(_ color: PropertyValue<Color>) -> Self {
    self.init(color.value)
  }
}
