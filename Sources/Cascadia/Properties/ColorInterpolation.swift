public struct ColorInterpolation: Property {
  public static let identifier = "color-interpolation"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }
}

public extension PropertyValue<ColorInterpolation> {
  static var auto: Self { #function }
  static var sRGB: Self { #function }
  static var linearRGB: Self { #function }
}
