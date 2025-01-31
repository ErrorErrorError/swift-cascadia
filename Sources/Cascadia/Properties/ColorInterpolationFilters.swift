public struct ColorInterpolationFilters: PrimitiveProperty {
  public static let identifier = "color-interpolation-filter"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }

  public struct Value: Sendable, RawValue {
    public var rawValue: String

    public init(_ value: String) {
      rawValue = value
    }
  }
}
