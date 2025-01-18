public struct BorderColor: Property, ColorValue {
  public static let identifier = "border-color"
  public var value: Value

  public init(_ rawValue: Value) {
    self.value = rawValue
  }

  public init(y: Color.Value, x: Color.Value) {
    self.value = ""
  }

  public init(top: Color.Value, x: Color.Value, bottom: Color.Value) {
    self.value = ""
  }

  public init(top: Color.Value, right: Color.Value, bottom: Color.Value, left: Color.Value) {
    self.value = ""
  }
}

public struct BorderTopColor: Property, ColorValue {
  public static let identifier = "border-top-color"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }
}

public struct BorderBottomColor: Property, ColorValue {
  public static let identifier = "border-bottom-color"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }
}

public struct BorderLeftColor: Property, ColorValue {
  public static let identifier = "border-left-color"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }
}

public struct BorderRightColor: Property, ColorValue {
  public static let identifier = "border-right-color"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }
}