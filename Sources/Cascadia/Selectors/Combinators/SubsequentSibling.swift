/// Subsequent Sibling Combinator `~`
///
/// e.g.: .container ~ .box
public struct SubsequentSibling<Parent: Selector, Child: Selector>: Selector {
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
    renderer.appendTokens(.whitespace(), 0x7E, .whitespace()) // ~
    Child.render(selector.child, into: &renderer)
  }
}

infix operator ~: AdditionPrecedence
public extension Selector {
  consuming func subsequent<S: Selector>(_ selector: S) -> SubsequentSibling<Self, S> {
    SubsequentSibling(self, selector)
  }

  static func ~ <S: Selector>(lhs: Self, rhs: S) -> SubsequentSibling<Self, S> {
    lhs.subsequent(rhs)
  }
}
