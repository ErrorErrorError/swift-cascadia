public struct Select<S: Selector, Content: Statement>: Statement {
  public let selector: S
  public let content: Content

  public init(
    _ selector: S, 
    @StatementBuilder content: () -> Content = EmptyStatement.init
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