/// Subsequent Sibling Combinator `~`
///
/// e.g.: .container ~ .box
public struct SubsequentSibling<Parent: Selector, S: Selector>: Selector where Parent.Content == EmptyStatement {
  public typealias Content = S.Content

  public var parent: Parent
  public var selector: S

  public init(_ parent: Parent, _ selector: S) {
    self.parent = parent
    self.selector = selector
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