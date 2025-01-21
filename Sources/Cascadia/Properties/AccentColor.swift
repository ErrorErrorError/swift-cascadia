public struct AccentColor {
  public static let identifier = "accent-color"

  public init(_ value: Value) {}
}

public extension AccentColor {
  struct Value: ColorValue, AutoValue {
    public var rawValue: String

    public init(_ value: String) {
      rawValue = value
    }
  }
}