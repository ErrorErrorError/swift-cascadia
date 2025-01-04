
let color = Color.init

public struct Color: Property, ColorRepresentable {
  public static let name = "color"
  public var value: PropertyValue<Self>

  public init(_ value: PropertyValue<Self>) {
    self.value = value
  }
}

/// Represets a property as a type of color.
public protocol ColorRepresentable {}

public extension PropertyValue where P: ColorRepresentable {

  // MARK: - HEX function

  static func hex(unsafe value: String) -> Self {
    Self(value)
  }

  // MARK: - Color functions

  static func rgba(r: Int, g: Int, b: Int, a: Int? = nil) -> Self {
    if let a {
      Self("rgba(\(r),\(g),\(b),\(a))")
    } else {
      Self("rgb(\(r),\(g),\(b))")
    }
  }

  static func hsla(h: Int, s: Int, l: Int, a: Int? = nil) -> Self {
    if let a {
      Self("hsla(\(h),\(s),\(l),\(a))")
    } else {
      Self("hsl(\(h),\(s),\(l))")
    }
  }

  // public struct Colorspace {
  //   public enum PredefinedRGB: String {
  //     case sRGB = "srgb"
  //     case sRGBLinear = "srgb-linear"
  //     case displayP3 = "display-p3"
  //     case a98RGB = "a98-rgb"
  //     case prophotoRGB = "prophoto-rgb"
  //     case rec20 = "rec20"
  //   }
  // }

  // public static func color(_ colorspace: Colorspace, alpha: Int? = nil) -> Self {
  //   Self("color(\(colorspace.rawValue))")
  // }

  static var currentColor: Self { #function }

  // MARK: - Named colors

  static var red: Self { #function }

  // MARK: - transparent

  static var transparent: Self { #function }
}
