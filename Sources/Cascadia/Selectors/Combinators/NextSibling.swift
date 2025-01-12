/// Next Sibling Combinator `+`
///
/// e.g.: .container + a
public struct NextSibling<Parent: Selector, Child: Selector>: Selector {
  public var parent: Parent
  public var child: Child

  public init(_ parent: Parent, _ child: Child) {
    self.parent = parent
    self.child = child
  }

  @inlinable @inline(__always)
  public static func _render(
    _ selector: consuming Self,
    into renderer: consuming Renderer
  ) {
    var renderer = renderer.selector()
    renderer.join(selector.parent, selector.child, separator: 0x2B) // +
  }
}

public extension Selector {
  consuming func next<S: Selector>(_ selector: S) -> NextSibling<Self, S> {
    NextSibling(self, selector)
  }

  static func + <S: Selector>(lhs: Self, rhs: S) -> NextSibling<Self, S> {
    lhs.next(rhs)
  }
}