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
  public static func render<Renderer: _SelectorRendering>(
    _ selector: consuming Self,
    into renderer: inout Renderer
  ) {
    Parent.render(selector.parent, into: &renderer)
    renderer.appendTokens(.whitespace(), 0x3E, .whitespace()) // >
    Child.render(selector.child, into: &renderer)
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
