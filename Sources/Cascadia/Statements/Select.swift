/// A ruleset containing a selector, and a list of properties.
public struct Select<S: Selector, Content: NestedStatement>: NestedStatement {
  public let selector: S
  public let content: Content

  public init(
    _ selector: S, 
    @StatementBuilder content: () -> Content
  ) {
    self.selector = selector
    self.content = content()
  }
}

infix operator =>: AssignmentPrecedence;
extension Selector {
  public static func => <Content: Statement>(lhs: Self, @StatementBuilder rhs: () -> Content) -> Select<Self, Content> {
    Select(lhs, content: rhs)
  }
}