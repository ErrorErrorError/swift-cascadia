/// Represets a property value as a type of color.
public protocol ColorValue: RawValue {}

// All color functions
public extension PrimitiveProperty where Value: ColorValue {
  init(hex value: String) {
    self.init(.hex(value))
  }

  // MARK: - <color-function>

  init(r: Int, g: Int, b: Int) {
    self.init(.rgb(r: r, g: g, b: b))
  }

  init(r: Int, g: Int, b: Int, a: Int) {
    self.init(.rgba(r: r, g: g, b: b, a: a))
  }

  init(h: Hue, s: Int, l: Int) {
    self.init(.hsl(h: h, s: s, l: l))
  }

  init(h: Hue, s: Int, l: Int, a: Int) {
    self.init(.hsla(h: h, s: s, l: l, a: a))
  }

  init(h: Hue, w: Int, b: Int, alpha: Int? = nil) {
    self.init(.hwb(h: h, w: w, b: b, alpha: alpha))
  }

  init(L: Int, a: Int, b: Int, alpha: Int? = nil) {
    self.init(.lab(L: L, a: a, b: b, alpha: alpha))
  }

  init(
    from color: Color.Value,
    L: Double,
    a: Double,
    b: Double,
    alpha: Double? = nil
  ) {
    self.init(.lab(from: color, L: L, a: a, b: b, alpha: alpha))
  }

  init(L: Double, C: Double, H: Hue, alpha: Double? = nil) {
    self.init(.lch(L: L, C: C, H: H, alpha: alpha))
  }

  init(oklab L: Double, a: Double, b: Double, alpha: Double? = nil) {
    self.init(.oklab(L: L, a: a, b: b, alpha: alpha))
  }

  init(oklch L: Double, C: Double, H: Hue, alpha: Double? = nil) {
    self.init(.oklch(L: L, C: C, H: H))
  }

  init(
    from color: Color.Value? = nil,
    _ colorspace: ColorSpace,
    alpha: Int? = nil
  ) {
    self.init(.color(from: color, colorspace, alpha: alpha))
  }
}

public enum Hue: Sendable, ExpressibleByIntegerLiteral {
  case number(Double)
  case angle(Angle)

  public enum Angle: Sendable {
    case deg(Double)
    case rad(Double)
    case grad(Double)
    case turn(Double)

    var rawValue: String {
      switch self {
      case let .deg(deg): "\(deg)deg"
      case let .rad(rad): "\(rad)rad"
      case let .grad(grad): "\(grad)grad"
      case let .turn(turn): "\(turn)turn"
      }
    }
  }

  public init(integerLiteral value: Double) {
    self = .number(value)
  }

  var rawValue: String {
    switch self {
    case let .number(num): String(num)
    case let .angle(angle): angle.rawValue
    }
  }
}

public struct ColorSpace: Sendable, ExpressibleByStringLiteral {
  public let rawValue: String

  public init(stringLiteral value: StringLiteralType) {
    rawValue = value
  }

  public init(rgb: PredefinedRGB, r: Double, g: Double, b: Double) {
    rawValue = "\(rgb.rawValue) \(r) \(g) \(b)"
  }

  public init(jzczhz value: Double, chroma: Double, hue: Hue) {
    rawValue = "jzczhz \(value) \(chroma) \(hue.rawValue)"
  }

  public init(rectangular: PredefinedRectangular, values: (Double, Double, Double)) {
    rawValue = "\(rectangular.rawValue) \(values.0) \(values.1) \(values.2)"
  }

  public init(xyz: XYZ, x: Double, y: Double, z: Double) {
    rawValue = "\(xyz.rawValue) \(x) \(y) \(z)"
  }

  public enum PredefinedRGB: String {
    case sRGB = "srgb"
    case sRGBLinear = "srgb-linear"
    case displayP3 = "display-p3"
    case a98RGB = "a98-rgb"
    case prophotoRGB = "prophoto-rgb"
    case rec2020
    case rec2100PQ = "rec2100-pq"
    case rec2100HLG = "rec2100-hlg"
    case rec2100Linear = "rec2100-linear"
  }

  public enum PredefinedRectangular: String {
    case jzazbz
    case ictcp
  }

  public enum XYZ: String {
    case xyz
    case xyzD50 = "xyz-d50"
    case xyzD65 = "xyz-d65"
  }
}

// /// All property values where ColorValue.
public extension ColorValue {

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

  static func hsl(h: Hue, s: Int, l: Int) -> Self {
    Self("hsl(\(h.rawValue) \(s) \(l))")
  }

  static func hsla(h: Hue, s: Int, l: Int, a: Int) -> Self {
    Self("hsla(\(h.rawValue) \(s) \(l) \(a))")
  }

  static func hwb(h: Hue, w: Int, b: Int, alpha: Int? = nil) -> Self {
    Self("hwb(\([h.rawValue, String(w), String(b), alpha.flatMap(String.init)].joined(separator: " ")))")
  }

  /// absolute lab()
  static func lab(L: Int, a: Int, b: Int, alpha: Int? = nil) -> Self {
    Self("lab(\([String(L), String(a), String(b), alpha.flatMap(String.init)].joined(separator: " ")))")
  }

  /// relative lab()
  static func lab(
    from color: Color.Value,
    L: Double,
    a: Double,
    b: Double,
    alpha: Double? = nil
  ) -> Self {
    Self("lab(from \(color.rawValue) \([L, a, b])\(alpha.flatMap { " / \($0)" } ?? ""))")
  }

  static func lch(L: Double, C: Double, H: Hue, alpha: Double? = nil) -> Self {
    Self("lch(\(L) \(C) \(H.rawValue)\(alpha.flatMap { " / \($0)" } ?? ""))")
  }

  static func oklab(L: Double, a: Double, b: Double, alpha: Double? = nil) -> Self {
    Self("oklab(\(L) \(a) \(b)\(alpha.flatMap { " / \($0)" } ?? ""))")
  }

  static func oklch(L: Double, C: Double, H: Hue, alpha: Double? = nil) -> Self {
    Self("oklch(\(L) \(C) \(H)\(alpha.flatMap { " / \($0)" } ?? ""))")
  }

  static func color(
    from color: Color.Value? = nil,
    _ colorspace: ColorSpace,
    alpha: Int? = nil
  ) -> Self {
    Self("color(\(color.flatMap { "from \($0.rawValue) " } ?? "")\(colorspace.rawValue)\(alpha.flatMap { " / \($0)" } ?? ""))")
  }

  // MARK: - <named-color>

  static var transparent: Self { Self(#function) }

  static var currentColor: Self { Self("currentcolor") }

  // CSS Colors Level 1

  static var black: Self { Self(#function) }

  static var silver: Self { Self(#function) }

  static var gray: Self { Self(#function) }

  static var white: Self { Self(#function) }

  static var maroon: Self { Self(#function) }

  static var red: Self { Self(#function) }

  static var purple: Self { Self(#function) }

  static var fuchsia: Self { Self(#function) }

  static var green: Self { Self(#function) }

  static var lime: Self { Self(#function) }

  static var olive: Self { Self(#function) }

  static var yellow: Self { Self(#function) }

  static var navy: Self { Self(#function) }

  static var blue: Self { Self(#function) }

  static var teal: Self { Self(#function) }

  static var aqua: Self { Self(#function) }

  // CSS Colors Level 2

  static var orange: Self { Self(#function) }

  // CSS Colors Level 3

  static var aliceblue: Self { Self(#function) }

  static var antiquewhite: Self { Self(#function) }

  static var aquamarine: Self { Self(#function) }

  static var azure: Self { Self(#function) }

  static var beige: Self { Self(#function) }

  static var bisque: Self { Self(#function) }

  static var blanchedalmond: Self { Self(#function) }

  static var blueviolet: Self { Self(#function) }

  static var brown: Self { Self(#function) }

  static var burlywood: Self { Self(#function) }

  static var cadetblue: Self { Self(#function) }

  static var chartreuse: Self { Self(#function) }

  static var chocolate: Self { Self(#function) }

  static var coral: Self { Self(#function) }

  static var cornflowerblue: Self { Self(#function) }

  static var cornsilk: Self { Self(#function) }

  static var crimson: Self { Self(#function) }

  static var cyan: Self { Self(#function) }

  static var darkblue: Self { Self(#function) }

  static var darkcyan: Self { Self(#function) }

  static var darkgoldenrod: Self { Self(#function) }

  static var darkgray: Self { Self(#function) }

  static var darkgreen: Self { Self(#function) }

  static var darkgrey: Self { Self(#function) }

  static var darkkhaki: Self { Self(#function) }

  static var darkmagenta: Self { Self(#function) }

  static var darkolivegreen: Self { Self(#function) }

  static var darkorange: Self { Self(#function) }

  static var darkorchid: Self { Self(#function) }

  static var darkred: Self { Self(#function) }

  static var darksalmon: Self { Self(#function) }

  static var darkseagreen: Self { Self(#function) }

  static var darkslateblue: Self { Self(#function) }

  static var darkslategray: Self { Self(#function) }

  static var darkslategrey: Self { Self(#function) }

  static var darkturquoise: Self { Self(#function) }

  static var darkviolet: Self { Self(#function) }

  static var deeppink: Self { Self(#function) }

  static var deepskyblue: Self { Self(#function) }

  static var dimgray: Self { Self(#function) }

  static var dimgrey: Self { Self(#function) }

  static var dodgerblue: Self { Self(#function) }

  static var firebrick: Self { Self(#function) }

  static var floralwhite: Self { Self(#function) }

  static var forestgreen: Self { Self(#function) }

  static var gainsboro: Self { Self(#function) }

  static var ghostwhite: Self { Self(#function) }

  static var gold: Self { Self(#function) }

  static var goldenrod: Self { Self(#function) }

  static var greenyellow: Self { Self(#function) }

  static var grey: Self { Self(#function) }

  static var honeydew: Self { Self(#function) }

  static var hotpink: Self { Self(#function) }

  static var indianred: Self { Self(#function) }

  static var indigo: Self { Self(#function) }

  static var ivory: Self { Self(#function) }

  static var khaki: Self { Self(#function) }

  static var lavender: Self { Self(#function) }

  static var lavenderblush: Self { Self(#function) }

  static var lawngreen: Self { Self(#function) }

  static var lemonchiffon: Self { Self(#function) }

  static var lightblue: Self { Self(#function) }

  static var lightcoral: Self { Self(#function) }

  static var lightcyan: Self { Self(#function) }

  static var lightgoldenrodyellow: Self { Self(#function) }

  static var lightgray: Self { Self(#function) }

  static var lightgreen: Self { Self(#function) }

  static var lightgrey: Self { Self(#function) }

  static var lightpink: Self { Self(#function) }

  static var lightsalmon: Self { Self(#function) }

  static var lightseagreen: Self { Self(#function) }

  static var lightskyblue: Self { Self(#function) }

  static var lightslategray: Self { Self(#function) }

  static var lightslategrey: Self { Self(#function) }

  static var lightsteelblue: Self { Self(#function) }

  static var lightyellow: Self { Self(#function) }

  static var limegreen: Self { Self(#function) }

  static var linen: Self { Self(#function) }

  static var magenta: Self { Self(#function) }

  static var mediumaquamarine: Self { Self(#function) }

  static var mediumblue: Self { Self(#function) }

  static var mediumorchid: Self { Self(#function) }

  static var mediumpurple: Self { Self(#function) }

  static var mediumseagreen: Self { Self(#function) }

  static var mediumslateblue: Self { Self(#function) }

  static var mediumspringgreen: Self { Self(#function) }

  static var mediumturquoise: Self { Self(#function) }

  static var mediumvioletred: Self { Self(#function) }

  static var midnightblue: Self { Self(#function) }

  static var mintcream: Self { Self(#function) }

  static var mistyrose: Self { Self(#function) }

  static var moccasin: Self { Self(#function) }

  static var navajowhite: Self { Self(#function) }

  static var oldlace: Self { Self(#function) }

  static var olivedrab: Self { Self(#function) }

  static var orangered: Self { Self(#function) }

  static var orchid: Self { Self(#function) }

  static var palegoldenrod: Self { Self(#function) }

  static var palegreen: Self { Self(#function) }

  static var paleturquoise: Self { Self(#function) }

  static var palevioletred: Self { Self(#function) }

  static var papayawhip: Self { Self(#function) }

  static var peachpuff: Self { Self(#function) }

  static var peru: Self { Self(#function) }

  static var pink: Self { Self(#function) }

  static var plum: Self { Self(#function) }

  static var powderblue: Self { Self(#function) }

  static var rebeccapurple: Self { Self(#function) }

  static var rosybrown: Self { Self(#function) }

  static var royalblue: Self { Self(#function) }

  static var saddlebrown: Self { Self(#function) }

  static var salmon: Self { Self(#function) }

  static var sandybrown: Self { Self(#function) }

  static var seagreen: Self { Self(#function) }

  static var seashell: Self { Self(#function) }

  static var sienna: Self { Self(#function) }

  static var skyblue: Self { Self(#function) }

  static var slateblue: Self { Self(#function) }

  static var slategray: Self { Self(#function) }

  static var slategrey: Self { Self(#function) }

  static var snow: Self { Self(#function) }

  static var springgreen: Self { Self(#function) }

  static var steelblue: Self { Self(#function) }

  static var tan: Self { Self(#function) }

  static var thistle: Self { Self(#function) }

  static var tomato: Self { Self(#function) }

  static var turquoise: Self { Self(#function) }

  static var violet: Self { Self(#function) }

  static var wheat: Self { Self(#function) }

  static var whitesmoke: Self { Self(#function) }

  static var yellowgreen: Self { Self(#function) }

  // MARK: - <system-color>

  static var accentColor: Self { Self("AccentColor") }

  static var accentColorText: Self { Self("AccentColorText") }

  static var activeText: Self { Self("ActiveText") }

  static var buttonBorder: Self { Self("ButtonBorder") }

  static var buttonFace: Self { Self("ButtonFace") }

  static var buttonText: Self { Self("ButtonText") }

  static var canvas: Self { Self("Canvas") }

  static var canvasText: Self { Self("CanvasText") }

  static var field: Self { Self("Field") }

  static var fieldText: Self { Self("FieldText") }

  static var grayText: Self { Self("GrayText") }

  static var highlight: Self { Self("Highlight") }

  static var highlightText: Self { Self("HighlightText") }

  static var linkText: Self { Self("LinkText") }

  static var mark: Self { Self("Mark") }

  static var markText: Self { Self("MarkText") }

  static var selectedText: Self { Self("SelectedText") }

  static var selectedItemText: Self { Self("SelectedItemText") }

  static var visitedText: Self { Self("VisitedText") }
}
