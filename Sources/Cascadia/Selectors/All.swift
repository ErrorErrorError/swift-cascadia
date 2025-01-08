public struct All<Content: Statement>: Selector {
  public let content: Content

  public init(@StatementBuilder content: () -> Content = EmptyStatement.init) {
    self.content = content()
  }
}