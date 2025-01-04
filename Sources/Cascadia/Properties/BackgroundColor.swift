let backgroundColor = BackgroundColor.init

public struct BackgroundColor: Property, ColorRepresentable {
  public static let name = "background-color"
  public var value: PropertyValue<Self>

  public init(_ value: Value) {
    self.value = value
  }
}
