public struct ColorInterpolation: PrimitiveProperty {
  public static let identifier = "color-interpolation"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }

  public struct Value: Sendable, RawValue {
    public let rawValue: String

    public static let auto: Self = #function
    public static let sRGB: Self = #function
    public static let linearRGB: Self = #function

    public init(_ value: String) {
      self.rawValue = value
    }
  }
}
