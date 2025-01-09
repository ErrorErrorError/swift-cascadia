/// Chain selectors
///
/// e.g.: div.container#id
public struct Chain<Parent: Selector, S: Selector>: Selector {
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
    S.render(selector.selector, into: &renderer)
  }
}

infix operator <>: AdditionPrecedence
public extension Selector {
  consuming func chain<S: Selector>(_ selector: S) -> Chain<Self, S> {
    Chain(self, selector)
  }

  static func <> <S: Selector>(lhs: Self, rhs: S) -> Chain<Self, S> {
    lhs.chain(rhs)
  }
}