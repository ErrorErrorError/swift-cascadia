/// Descendant Combinator ` `
///
/// Combine two selectors such that elements matched by the second selector are selected if they have an ancestor.
/// e.g.: .container .item .a
public struct Descendant<Parent: Selector, S: Selector>: Selector where Parent.Content == EmptyStatement {
  public typealias Content = S.Content

  public var parent: Parent
  public var selector: S

  public init(_ parent: Parent, _ selector: S) {
    self.parent = parent
    self.selector = selector
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