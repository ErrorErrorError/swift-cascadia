public struct ColorScheme: Property {
  public static let identifier = "color-scheme"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }

  public static var normal: Self { Self(#function) }
  public static var dark: Self { Self(#function) }
  public static var light: Self { Self(#function) }
}