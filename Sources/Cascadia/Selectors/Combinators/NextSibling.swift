/// Next Sibling Combinator `+`
///
/// e.g.: .container + a
public struct NextSibling<Parent: Selector, S: Selector>: Selector where Parent.Content == EmptyStatement {
  public typealias Content = S.Content

  public var parent: Parent
  public var selector: S

  public init(_ parent: Parent, _ selector: S) {
    self.parent = parent
    self.selector = selector
  }
}

public extension Selector {
  consuming func next<S: Selector>(_ selector: S) -> NextSibling<Self, S> {
    NextSibling(self, selector)
  }

  static func + <S: Selector>(lhs: Self, rhs: S) -> NextSibling<Self, S> {
    lhs.next(rhs)
  }
}