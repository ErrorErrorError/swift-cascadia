/// Represets a property value as a type of color.
public protocol ColorValue {}

/// All property values where ColorRepresentable is set.
public extension PropertyValue where ID: ColorValue {

  // MARK: - <hex-color>

  static func hex(_ value: String) -> Self {
    Self(value)
  }

  // MARK: - <color-function>

  static func rgb(r: Int, g: Int, b: Int) -> Self {
    Self("rgb(\(r) \(g) \(b))")
  }

  static func rgba(r: Int, g: Int, b: Int, a: Int) -> Self {
    Self("rgba(\(r) \(g) \(b) \(a))")
  }

  enum Hue: ExpressibleByIntegerLiteral {
    case number(Double)
    case angle(Angle)

    public enum Angle {
      case deg(Double)
      case rad(Double)
      case grad(Double)
      case turn(Double)

      var rawValue: String {
        switch self {
        case .deg(let deg): "\(deg)deg"
        case .rad(let rad): "\(rad)rad"
        case .grad(let grad): "\(grad)grad"
        case .turn(let turn): "\(turn)turn"
        }
      }
    }

    public init(integerLiteral value: Double) {
      self = .number(value)
    }

    var rawValue: String {
      switch self {
        case .number(let num): String(num)
        case .angle(let angle): angle.rawValue
      }
    }
  }

  static func hsl(h: Hue, s: Int, l: Int) -> Self {
    Self("hsl(\(h.rawValue) \(s) \(l))")
  }

  static func hsla(h: Hue, s: Int, l: Int, a: Int) -> Self {
    Self("hsla(\(h.rawValue) \(s) \(l) \(a))")
  }

  static func hwb(h: Hue, w: Int, b: Int, alpha: Int? = nil) -> Self {
    Self("hwb(\([h.rawValue, String(w), String(b), alpha.flatMap(String.init)].compactMap { $0 }.joined(separator: " ")))")
  }

  static func lab(L: Int, a: Int, b: Int, alpha: Int? = nil) -> Self {
    Self("lab(\([L, a, b, a].compactMap { String($0) }.joined(separator: " ")))")
  }

  static func lab<C: ColorValue>(
    from color: PropertyValue<C>, 
    L: Int, 
    a: Int, 
    b: Int, 
    alpha: Int? = nil
  ) -> Self {
    Self(stringLiteral: "lab(from \(color.rawValue) \([L, a, b])\(alpha.flatMap { " / \($0)" } ?? ""))")
  }

  static func lch() -> Self {
    Self(stringLiteral: "lch()")
  }

  static func oklab() -> Self {
    Self(stringLiteral: "oklab()")
  }

  static func oklch() -> Self {
    Self(stringLiteral: "oklch()")
  }

  struct ColorSpace: ExpressibleByStringLiteral {
    public let rawValue: String

    public init(stringLiteral value: StringLiteralType) {
      self.rawValue = value
    }

    public init(rgb: PredefinedRGB, r: Double, g: Double, b: Double) {
      self.rawValue = "\(rgb.rawValue) \(r) \(g) \(b)"
    }

    public init(jzczhz value: Double, chroma: Double, hue: Hue) {
      self.rawValue = "jzczhz \(value) \(chroma) \(hue.rawValue)"
    }

    public init(rectangular: PredefinedRectangular, values: (Double, Double, Double)) {
      self.rawValue = "\(rectangular.rawValue) \(values.0) \(values.1) \(values.2)"
    }

    public init(xyz: XYZ, x: Double, y: Double, z: Double) {
      self.rawValue = "\(xyz.rawValue) \(x) \(y) \(z)"
    }

    public enum PredefinedRGB: String {
      case sRGB = "srgb"
      case sRGBLinear = "srgb-linear"
      case displayP3 = "display-p3"
      case a98RGB = "a98-rgb"
      case prophotoRGB = "prophoto-rgb"
      case rec2020 = "rec2020"
      case rec2100PQ = "rec2100-pq"
      case rec2100HLG = "rec2100-hlg"
      case rec2100Linear = "rec2100-linear"
    }

    public enum PredefinedRectangular: String {
      case jzazbz
      case ictcp
    }

    public enum XYZ: String {
      case xyz = "xyz"
      case xyzD50 = "xyz-d50"
      case xyzD65 = "xyz-d65"
    }
  }

  static func color<C: ColorValue>(
    from color: PropertyValue<C>? = nil, 
    _ colorspace: ColorSpace, 
    alpha: Int? = nil
  ) -> Self {
    Self("color(\(color.flatMap { "from \($0.rawValue) " } ?? "")\(colorspace.rawValue)\(alpha.flatMap { " / \($0)" } ?? ""))")
  }

  // MARK: - <named-color>

  static var transparent: Self { #function }

  static var currentColor: Self { "currentcolor" }

  // CSS Colors Level 1

  static var black: Self { #function }

  static var silver: Self { #function }

  static var gray: Self { #function }

  static var white: Self { #function }

  static var maroon: Self { #function }

  static var red: Self { #function }

  static var purple: Self { #function }

  static var fuchsia: Self { #function }

  static var green: Self { #function }

  static var lime: Self { #function }

  static var olive: Self { #function }

  static var yellow: Self { #function }

  static var navy: Self { #function }

  static var blue: Self { #function }

  static var teal: Self { #function }

  static var aqua: Self { #function }

  // CSS Colors Level 2

  static var orange: Self { #function }

  // CSS Colors Level 3

  static var aliceblue: Self { #function }

  static var antiquewhite: Self { #function }

  static var aquamarine: Self { #function }

  static var azure: Self { #function }

  static var beige: Self { #function }

  static var bisque: Self { #function }

  static var blanchedalmond: Self { #function }

  static var blueviolet: Self { #function }

  static var brown: Self { #function }

  static var burlywood: Self { #function }

  static var cadetblue: Self { #function }

  static var chartreuse: Self { #function }

  static var chocolate: Self { #function }

  static var coral: Self { #function }

  static var cornflowerblue: Self { #function }

  static var cornsilk: Self { #function }

  static var crimson: Self { #function }

  static var cyan: Self { #function }

  static var darkblue: Self { #function }

  static var darkcyan: Self { #function }

  static var darkgoldenrod: Self { #function }

  static var darkgray: Self { #function }

  static var darkgreen: Self { #function }

  static var darkgrey: Self { #function }

  static var darkkhaki: Self { #function }

  static var darkmagenta: Self { #function }

  static var darkolivegreen: Self { #function }

  static var darkorange: Self { #function }

  static var darkorchid: Self { #function }

  static var darkred: Self { #function }

  static var darksalmon: Self { #function }

  static var darkseagreen: Self { #function }

  static var darkslateblue: Self { #function }

  static var darkslategray: Self { #function }

  static var darkslategrey: Self { #function }

  static var darkturquoise: Self { #function }

  static var darkviolet: Self { #function }

  static var deeppink: Self { #function }

  static var deepskyblue: Self { #function }

  static var dimgray: Self { #function }

  static var dimgrey: Self { #function }

  static var dodgerblue: Self { #function }

  static var firebrick: Self { #function }

  static var floralwhite: Self { #function }

  static var forestgreen: Self { #function }

  static var gainsboro: Self { #function }

  static var ghostwhite: Self { #function }

  static var gold: Self { #function }

  static var goldenrod: Self { #function }

  static var greenyellow: Self { #function }

  static var grey: Self { #function }

  static var honeydew: Self { #function }

  static var hotpink: Self { #function }

  static var indianred: Self { #function }

  static var indigo: Self { #function }

  static var ivory: Self { #function }

  static var khaki: Self { #function }

  static var lavender: Self { #function }

  static var lavenderblush: Self { #function }

  static var lawngreen: Self { #function }

  static var lemonchiffon: Self { #function }

  static var lightblue: Self { #function }

  static var lightcoral: Self { #function }

  static var lightcyan: Self { #function }

  static var lightgoldenrodyellow: Self { #function }

  static var lightgray: Self { #function }

  static var lightgreen: Self { #function }

  static var lightgrey: Self { #function }

  static var lightpink: Self { #function }

  static var lightsalmon: Self { #function }

  static var lightseagreen: Self { #function }

  static var lightskyblue: Self { #function }

  static var lightslategray: Self { #function }

  static var lightslategrey: Self { #function }

  static var lightsteelblue: Self { #function }

  static var lightyellow: Self { #function }

  static var limegreen: Self { #function }

  static var linen: Self { #function }

  static var magenta: Self { #function }

  static var mediumaquamarine: Self { #function }

  static var mediumblue: Self { #function }

  static var mediumorchid: Self { #function }

  static var mediumpurple: Self { #function }

  static var mediumseagreen: Self { #function }

  static var mediumslateblue: Self { #function }

  static var mediumspringgreen: Self { #function }

  static var mediumturquoise: Self { #function }

  static var mediumvioletred: Self { #function }

  static var midnightblue: Self { #function }

  static var mintcream: Self { #function }

  static var mistyrose: Self { #function }

  static var moccasin: Self { #function }

  static var navajowhite: Self { #function }

  static var oldlace: Self { #function }

  static var olivedrab: Self { #function }

  static var orangered: Self { #function }

  static var orchid: Self { #function }

  static var palegoldenrod: Self { #function }

  static var palegreen: Self { #function }

  static var paleturquoise: Self { #function }

  static var palevioletred: Self { #function }

  static var papayawhip: Self { #function }

  static var peachpuff: Self { #function }

  static var peru: Self { #function }

  static var pink: Self { #function }

  static var plum: Self { #function }

  static var powderblue: Self { #function }

  static var rebeccapurple: Self { #function }

  static var rosybrown: Self { #function }

  static var royalblue: Self { #function }

  static var saddlebrown: Self { #function }

  static var salmon: Self { #function }

  static var sandybrown: Self { #function }

  static var seagreen: Self { #function }

  static var seashell: Self { #function }

  static var sienna: Self { #function }

  static var skyblue: Self { #function }

  static var slateblue: Self { #function }

  static var slategray: Self { #function }

  static var slategrey: Self { #function }

  static var snow: Self { #function }

  static var springgreen: Self { #function }

  static var steelblue: Self { #function }

  static var tan: Self { #function }

  static var thistle: Self { #function }

  static var tomato: Self { #function }

  static var turquoise: Self { #function }

  static var violet: Self { #function }

  static var wheat: Self { #function }

  static var whitesmoke: Self { #function }

  static var yellowgreen: Self { #function }

  // MARK: - <system-color>

  static var accentColor: Self { "AccentColor" }

  static var accentColorText: Self { "AccentColorText" }

  static var activeText: Self { "ActiveText" }

  static var buttonBorder: Self { "ButtonBorder" }

  static var buttonFace: Self { "ButtonFace" }

  static var buttonText: Self { "ButtonText" }

  static var canvas: Self { "Canvas" }

  static var canvasText: Self { "CanvasText" }

  static var field: Self { "Field" }

  static var fieldText: Self { "FieldText" }

  static var grayText: Self { "GrayText" }

  static var highlight: Self { "Highlight" }

  static var highlightText: Self { "HighlightText" }

  static var linkText: Self { "LinkText" }

  static var mark: Self { "Mark" }

  static var markText: Self { "MarkText" }

  static var selectedText: Self { "SelectedText" }

  static var selectedItemText: Self { "SelectedItemText" }

  static var visitedText: Self { "VisitedText" }
}