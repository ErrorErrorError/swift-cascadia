public struct Media<Content: NestedStatement>: NestedAtRule {
  public static var identifier: String { "media" }

  /// A media query
  public var query: String

  public var content: Content

  public init(_ query: String, @StatementBuilder content: () -> Content) {
    self.query = query
    self.content = content()
  }
}