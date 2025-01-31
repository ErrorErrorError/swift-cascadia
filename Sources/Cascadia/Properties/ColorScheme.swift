public struct ColorScheme: PrimitiveProperty {
  public static let identifier = "color-scheme"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }

  public struct Value: Sendable, RawValue {
    public let rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }

    public static let normal: Self = #function
    public static let dark: Self = #function
    public static let light: Self = #function
  }
}