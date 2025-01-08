/// Chain selectors
///
/// e.g.: div.container#id
public struct Chain<Parent: Selector, S: Selector>: Selector where Parent.Content == EmptyStatement {
  public typealias Content = S.Content

  public var parent: Parent
  public var selector: S

  public init(_ parent: Parent, _ selector: S) {
    self.parent = parent
    self.selector = selector
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