/// Selects all elements
public struct All: Selector, Sendable {

  @_spi(Core)
  @inlinable @inline(__always)
  public var body: Never {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public init() {}

  @_spi(Renderer)
  @inlinable @inline(__always)
  public static func _render<Writer: CSSStreamWriter>(
    _: consuming Self,
    into renderer: inout Renderer<Writer>
  ) {
    renderer.selector { selector in
      selector.write(0x2A)  // *      
    }
  }
}

extension Selector where Self == All {
  public static var all: Self { Self() }
}