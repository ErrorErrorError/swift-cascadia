extension CSSProperty {
  public enum ColorScheme: Property {
    public static let identifier = "color-scheme"
  }
}

public typealias ColorScheme = CSSProperty.ColorScheme.Value

extension Declaration<ColorScheme.ID> {
  public static var normal: Self { #function }
  public static var dark: Self { #function }
  public static var light: Self { #function }
}