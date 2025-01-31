public struct Color: PrimitiveProperty {
  public static let identifier = "color"

  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }
}

extension Color {
  public struct Value: ColorValue {
    public let rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }
  }
}