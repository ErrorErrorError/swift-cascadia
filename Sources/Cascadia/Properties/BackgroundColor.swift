public struct BackgroundColor: Property, ColorValue {
  public static let identifier = "background-color"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }
}