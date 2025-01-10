/// Descendant Combinator ` `
/// Combine two selectors such that elements matched by the second selector are selected if they have an ancestor.
///
/// e.g.: .container .item .a
public struct Descendant<Parent: Selector, Child: Selector>: Selector {
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
    renderer.appendTokens(.whitespace(canOmit: false))
    Child.render(selector.child, into: &renderer)
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