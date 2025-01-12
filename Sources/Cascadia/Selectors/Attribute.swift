/// e.g.: [class='test']
public struct Attribute: Selector {
  public var name: String
  public var value: Value?

  public var body: some Selector {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public init(_ name: String) {
    self.name = name
    self.value = nil
  }

  public init(
    _ name: String,
    match operator: Operator,
    value: String,
    caseSensitive: Bool? = nil
  ) {
    self.name = name
    self.value = Value(
      operator: `operator`,
      rawValue: value,
      caseSensitive: caseSensitive
    )
  }

  @_spi(CascadiaCore)
  @inlinable @inline(__always)
  public static func _render(
    _ selector: consuming Self,
    into renderer: consuming Renderer
  ) {
    var renderer = renderer.selector()
    renderer.add(0x5B) // [
    renderer.add(selector.name)
    if let value = selector.value {
      renderer.add(value.operator.token)
      renderer.add(0x3D) // =
      renderer.add(0x22) // "
      renderer.add(value.rawValue)
      renderer.add(0x22) // "

      if let caseSensitive = value.caseSensitive {
        renderer.addSpace(canOmit: false)
        if caseSensitive {
          renderer.add(0x69) // i
        } else {
          renderer.add(0x73) // s
        }
      }
    }
    renderer.add(0x5D) // ]
  }

  public struct Value: Sendable {
    public let `operator`: Operator
    public let rawValue: String
    public let caseSensitive: Bool?
  }
}

public extension Selector where Self == Attribute {
  static var attr: Attribute.Type { Attribute.self }
}

public extension Attribute {
  struct Operator: Sendable {
    public let token: String

    public init(_ token: String) {
      self.token = token
    }

    /// Selects elements where the attribute value exactly matches the given value.
    public static var exact: Self { Self("") }

    /// Selects elements where the attribute value starts with the specified substring.
    public static var starts: Self { Self("^") }

    /// Selects elements where the attribute value ends with the specified substring.
    public static var ends: Self { Self("$") }

    /// Selects elements where the attribute value contains the specified text.
    public static var text: Self { Self("*") }

    /// Selects elements where the attribute value contains the specified word (in a list separated by spaces).
    public static var word: Self { Self("~") }

    /// Selects elements where the attribute value can begin with the specified value immediately followed by a hyphen.
    public static var hyphen: Self { Self("|") }
  }
}
