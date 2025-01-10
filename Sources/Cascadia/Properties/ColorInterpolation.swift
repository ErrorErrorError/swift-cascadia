extension CSSProperty {
  public enum ColorInterpolation: Property {
    public static let identifier = "color-interpolation"
  }
}

public typealias ColorInterpolation = CSSProperty.ColorInterpolation.Value

extension Declaration<ColorInterpolation.ID> {
  public static var auto: Self { #function } 
  public static var sRGB: Self { #function }
  public static var linearRGB: Self { #function }
}