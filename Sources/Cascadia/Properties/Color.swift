public struct Color: Property, ColorValue {
  public static let identifier = "color"
  public var value: Value

  public init(_ rawValue: Value) {
    self.value = rawValue
  }
}
