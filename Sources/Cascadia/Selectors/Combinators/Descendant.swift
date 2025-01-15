/// Descendant Combinator ` `
/// Combine two selectors such that elements matched by the second selector are selected if they have an ancestor.
///
/// e.g.: .container .item .a
public struct Descendant<Parent: Selector, Child: Selector>: Selector {
  public var parent: Parent
  public var child: Child

  @_spi(Core)
  @inlinable @inline(__always)
  public var body: Never {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public init(_ parent: Parent, _ child: Child) {
    self.parent = parent
    self.child = child
  }

  @_spi(Renderer)
  @inlinable @inline(__always)
  public static func _render<Writer: CSSStreamWriter>(
    _ selector: consuming Self,
    into renderer: inout Renderer<Writer>
  ) {
    renderer.selector { renderer in
      renderer.join(selector.parent, selector.child, separator: 0x20) // ` `
    }
  }
}

public extension Selector {
  consuming func descendant<S: Selector>(_ selector: S) -> Descendant<Self, S> {
    Descendant(self, selector)
  }

  static func * <S: Selector>(lhs: Self, rhs: S) -> Descendant<Self, S> {
    lhs.descendant(rhs)
  }
}