public struct Background: Property {
  public static let identifier = "background"
  public var value: Value

  public init(_ layer: Value) {
    self.value = layer
  }

  public init(_ layers: Value...) {
    self.value = layers.joined(separator: ", ")
  }

  /// Also known as a <bg-layer>
  public enum Value: RawValue {
    case image(BackgroundImage.Value)
    case position(BackgroundPosition.Value, size: String? = nil)
    case `repeat`(BackgroundRepeat.Value)
    case attachment(BackgroundRepeat.Value)
    // case visualBox(BackgroundVisualBox)
    case color(BackgroundColor.Value)
    case custom(String)

    public init(_ rawValue: String) {
      self = .custom(rawValue)
    }

    public var rawValue: String {
      switch self {
      case .image(let value): value.rawValue
      case .position(let value, size: let size): value.rawValue
      case .repeat(let value): value.rawValue
      case .attachment(let value): value.rawValue
      case .color(let value): value.rawValue
      case .custom(let value): value
      }
    }
  }
}

public struct BackgroundImage: Property {
  public static let identifier = "background-image"
  public var value: Value

  public init(_ layer: Value) {
    self.value = layer
  }

  public struct Value: RawValue {
    public var rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }
  }
}

public struct BackgroundPosition: Property {
  public static let identifier = "background-position"
  public var value: Value

  public init(_ layer: Value) {
    self.value = layer
  }

  public struct Value: RawValue {
    public var rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }
  }
}

public struct BackgroundSize: Property {
  public static let identifier = "background-size"
  public var value: Value

  public init(_ layer: Value) {
    self.value = layer
  }

  public struct Value: RawValue {
    public var rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }
  }
}

public struct BackgroundRepeat: Property {
  public static let identifier = "background-repeat"
  public var value: Value

  public init(_ layer: Value) {
    self.value = layer
  }

  public struct Value: RawValue {
    public var rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }
  }
}

public struct BackgroundOrigin: Property {
  public static let identifier = "background-origin"
  public var value: Value

  public init(_ layer: Value) {
    self.value = layer
  }

  public struct Value: RawValue {
    public var rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }
  }
}

public struct BackgroundClip: Property {
  public static let identifier = "background-clip"
  public var value: Value

  public init(_ layer: Value) {
    self.value = layer
  }

  public struct Value: RawValue {
    public var rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }
  }
}

public struct BackgroundAttachment: Property {
  public static let identifier = "background-attachment"
  public var value: Value

  public init(_ layer: Value) {
    self.value = layer
  }

  public struct Value: RawValue {
    public var rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }
  }
}

public struct BackgroundColor: Property {
  public static let identifier = "background-color"
  public var value: Value

  public init(_ value: Color.Value) {
    self.value = value
  }
}