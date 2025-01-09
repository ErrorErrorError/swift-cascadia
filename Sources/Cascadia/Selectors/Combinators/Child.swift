/// Child Combinator `>`
///
/// e.g.: .container > a
public struct Child<Parent: Selector, S: Selector>: Selector {
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
    renderer.appendBytes(0x3E)  // >
    renderer.addWhitespace(canOmit: true)
    S.render(selector.selector, into: &renderer)
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