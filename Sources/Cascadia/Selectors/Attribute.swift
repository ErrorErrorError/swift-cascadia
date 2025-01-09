/// e.g.: [class='test']
public struct Attribute: Selector {
  public var name: String
  public var value: Value?

  public init(_ name: String) {
    self.name = name
    value = nil
  }

  public init(
    _ name: String,
    match modifier: Modifier,
    value: String,
    caseSensitive: Bool? = nil
  ) {
    self.name = name
    self.value = Value(
      modifier: modifier,
      rawValue: value,
      caseSensitive: caseSensitive
    )
  }

  public static func render<Renderer: _SelectorRendering>(
    _ selector: consuming Self,
    into renderer: inout Renderer
  ) {
    renderer.appendBytes(0x5B) // [
    renderer.appendBytes(selector.name.utf8)
    if let value = selector.value {
      renderer.appendBytes(value.modifier.token.utf8)
      renderer.appendBytes(0x3D) // =
      renderer.appendBytes(0x22) // "
      renderer.appendBytes(value.rawValue.utf8)
      renderer.appendBytes(0x22) // "

      if let caseSensitive = value.caseSensitive {
        renderer.addWhitespace(canOmit: false)
        if caseSensitive {
          renderer.appendBytes(0x69) // i
        } else {
          renderer.appendBytes(0x73) // s
        }
      }
    }
    renderer.appendBytes(0x5D) // ]
  }

  public struct Value: Sendable {
    public let modifier: Modifier
    public let rawValue: String
    public let caseSensitive: Bool?
  }
}

public extension Selector where Self == Attribute {
  static var attr: Attribute.Type { Attribute.self }
}

public extension Attribute {
  struct Modifier: Sendable {
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
