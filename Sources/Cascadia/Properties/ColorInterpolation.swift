public struct ColorInterpolation: Property {
  public static let identifier = "color-interpolation"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }

  static var auto: Self { Self(#function) }
  static var sRGB: Self { Self(#function) }
  static var linearRGB: Self { Self(#function) }
}
