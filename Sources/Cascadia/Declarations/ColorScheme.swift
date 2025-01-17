public struct ColorScheme: Declaration {
  public static let identifier = "color-scheme"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }
}

extension PropertyValue<ColorScheme> {
  public static var normal: Self { #function }
  public static var dark: Self { #function }
  public static var light: Self { #function }
}