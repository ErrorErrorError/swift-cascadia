public struct BackgroundColor: Property, ColorRepresentable {
  public var value: Value
  public static let identifier = "background-color"

  public init(_ value: Value) {
    self.value = value
  }
}