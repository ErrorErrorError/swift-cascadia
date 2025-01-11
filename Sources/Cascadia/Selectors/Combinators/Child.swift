/// Child Combinator `>`
///
/// e.g.: .container > a
public struct Child<Parent: Selector, Child: Selector>: Selector {
  public var parent: Parent
  public var child: Child

  public init(_ parent: Parent, _ child: Child) {
    self.parent = parent
    self.child = child
  }

  @inlinable @inline(__always)
  public static func render(
    _ selector: consuming Self,
    into renderer: consuming Renderer.SelectorRenderer
  ) {
    renderer.join(selector.parent, selector.child, separator: 0x3E) // >
  }
}

public extension Selector {
  consuming func child<S: Selector>(_ selector: S) -> Child<Self, S> {
    Child(self, selector)
  }

  static func > <S: Selector>(lhs: Self, rhs: S) -> Child<Self, S> {
    lhs.child(rhs)
  }
}
