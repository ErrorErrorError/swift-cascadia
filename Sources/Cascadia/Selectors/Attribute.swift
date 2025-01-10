/// e.g.: [class='test']
public struct Attribute: Selector {
  public var name: String
  public var value: Value?

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

  @inlinable @inline(__always)
  public static func render<Renderer: _SelectorRendering>(
    _ selector: consuming Self,
    into renderer: inout Renderer
  ) {
    renderer.appendTokens(0x5B) // [
    renderer.appendTokens(SelectorToken(selector.name))
    if let value = selector.value {
      renderer.appendTokens(SelectorToken(value.operator.token))
      renderer.appendTokens(0x3D) // =
      renderer.appendTokens(0x22) // "
      renderer.appendTokens(SelectorToken(value.rawValue))
      renderer.appendTokens(0x22) // "

      if let caseSensitive = value.caseSensitive {
        renderer.appendTokens(.whitespace(canOmit: false))
        if caseSensitive {
          renderer.appendTokens(0x69) // i
        } else {
          renderer.appendTokens(0x73) // s
        }
      }
    }
    renderer.appendTokens(0x5D) // ]
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
