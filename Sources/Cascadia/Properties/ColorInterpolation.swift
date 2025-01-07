public struct ColorInterpolation: Property {
  public static let identifier = "color-interpolation"

  public var value: PropertyValue<Self>

  public init(_ value: Value) {
    self.value = value
  }
}

extension PropertyValue<ColorInterpolation> {
  public static var auto: Self { #function } 
  public static var sRGB: Self { #function }
  public static var linearRGB: Self { #function }
}
