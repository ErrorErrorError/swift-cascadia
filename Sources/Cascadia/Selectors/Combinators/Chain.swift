/// Chain selectors
///
/// e.g.: div.container#id
public struct Chain<Parent: Selector, Child: Selector>: Selector {
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
    Child.render(selector.child, into: &renderer)
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