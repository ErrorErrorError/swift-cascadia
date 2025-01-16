/// Selects elements based on string
public struct Select: Selector, Sendable {
  public var selector: String

  @inlinable @inline(__always)
  public init(_ selector: String) {
    self.selector = selector
  }

  @_spi(Core)
  @inlinable @inline(__always)
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(Renderer)
  @inlinable @inline(__always)
  public static func _render<Writer: CSSStreamWriter>(
    _ selector: consuming Self,
    into renderer: inout Renderer<Writer>
  ) {
    renderer.selector { renderer in
      renderer.write(contentsOf: selector.selector.utf8)
    }
  }
}

extension Selector where Self == Select {
  public static func select(_ selector: String) -> Self {
    Self(selector)
  }
}