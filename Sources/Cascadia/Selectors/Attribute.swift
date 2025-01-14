/// e.g.: [class='test']
public struct Attribute: Selector {
  public var name: String
  public var value: Value?

  @_spi(Core)
  @inlinable @inline(__always)
  public var body: Never {
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

  @_spi(Renderer)
  @inlinable @inline(__always)
  public static func _render<Renderer: CSSRendering>(
    _ selector: consuming Self,
    into renderer: inout Renderer
  ) {
    renderer.selector { renderer in
      renderer.write(0x5B) // [
      renderer.write(contentsOf: selector.name.utf8)
      if let value = selector.value {
        renderer.write(contentsOf: value.operator.token.utf8)
        renderer.write(0x3D) // =
        renderer.write(0x22) // "
        renderer.write(contentsOf: value.rawValue.utf8)
        renderer.write(0x22) // "

        if let caseSensitive = value.caseSensitive {
          renderer.write(0x20)
          // renderer.addSpace(canOmit: false)
          if caseSensitive {
            renderer.write(0x69) // i
          } else {
            renderer.write(0x73) // s
          }
        }
      }
      renderer.write(0x5D) // ]
    }
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
