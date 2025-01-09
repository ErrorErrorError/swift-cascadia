/// Subsequent Sibling Combinator `~`
///
/// e.g.: .container ~ .box
public struct SubsequentSibling<Parent: Selector, S: Selector>: Selector {
  public var parent: Parent
  public var selector: S

  public init(_ parent: Parent, _ selector: S) {
    self.parent = parent
    self.selector = selector
  }

  public static func render<Renderer: _SelectorRendering>(
    _ selector: consuming Self, 
    into renderer: inout Renderer
  ) {
    Parent.render(selector.parent, into: &renderer)
    renderer.addWhitespace(canOmit: true)
    renderer.appendBytes(0x7E)  // ~
    renderer.addWhitespace(canOmit: true)
    S.render(selector.selector, into: &renderer)
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