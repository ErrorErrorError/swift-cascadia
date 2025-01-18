public struct BackgroundColor: Property, ColorValue {
  public static let identifier = "background-color"
  public var value: Value

  public init(_ rawValue: Value) {
    self.value = rawValue
  }
}