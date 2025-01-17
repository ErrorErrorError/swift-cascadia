public struct BackgroundColor: Property, ColorRepresentable {
  public static let identifier = "background-color"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }
}