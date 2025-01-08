/// Child Combinator `>`
///
/// e.g.: .container > a
public struct Child<Parent: Selector, S: Selector>: Selector where Parent.Content == EmptyStatement {
  public typealias Content = S.Content

  public var parent: Parent
  public var selector: S

  public init(_ parent: Parent, _ selector: S) {
    self.parent = parent
    self.selector = selector
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