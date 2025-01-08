public struct Media<Content: Selector>: AtRule {
  
  /// A media query
  public var query: String

  @StatementBuilder
  public var content: Content

  public init(_ query: String, @StatementBuilder content: () -> Content) {
    self.query = query
    self.content = content()
  }
}