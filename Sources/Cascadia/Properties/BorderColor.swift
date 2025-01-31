public struct BorderColor: PrimitiveProperty {
  public static let identifier = "border-color"
  public var value: Value

  public init(_ value: Value) {
    self.value = value
  }

  public init(y: Value, x: Value) {
    self.value = x.joined(with: y, separator: " ")
  }

  public init(top: Value, x: Value, bottom: Value) {
    self.value = top.joined(with: x, bottom, separator: " ")
  }

  public init(top: Value, right: Value, bottom: Value, left: Value) {
    self.value = top.joined(with: right, bottom, left, separator: " ")
  }
}

extension BorderColor {
  public struct Value: ColorValue {
    public var rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }

    public struct ColorStripe: ColorValue {
      public var rawValue: String
      public init(_ value: String) {
        self.rawValue = value
      }

      public init(_ color: Color.Value, length: String? = nil) {
        self.rawValue = [color.rawValue, length].joined(separator: " ")
      }
    }

    public static func stripes(
      _ stripe: ColorStripe, 
      _ stripes: ColorStripe...
    ) -> Self {
      let allStripes = [stripe] + stripes
      return Self("stripes(\(allStripes.map(\.rawValue).joined(separator: ", ")))")
    }
  }
}

public struct BorderTopColor: PrimitiveProperty {
  public static let identifier = "border-top-color"
  public var value: BorderColor.Value

  public init(_ value: BorderColor.Value) {
    self.value = value
  }
}

public struct BorderBottomColor: PrimitiveProperty {
  public static let identifier = "border-bottom-color"
  public var value: BorderColor.Value

  public init(_ value: BorderColor.Value) {
    self.value = value
  }
}

public struct BorderLeftColor: PrimitiveProperty {
  public static let identifier = "border-left-color"
  public var value: BorderColor.Value

  public init(_ value: BorderColor.Value) {
    self.value = value
  }
}

public struct BorderRightColor: PrimitiveProperty {
  public static let identifier = "border-right-color"
  public var value: BorderColor.Value

  public init(_ value: BorderColor.Value) {
    self.value = value
  }
}