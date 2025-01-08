public struct Select<S: Selector, Content: Statement>: Selector {
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