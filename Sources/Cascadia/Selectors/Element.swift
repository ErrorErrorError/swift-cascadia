public struct Element<Content: Statement>: Selector {
  public let element: HTMLTag
  public let content: Content

  public init(_ element: HTMLTag, @StatementBuilder content: () -> Content = EmptyStatement.init) {
    self.element = element
    self.content = content()
  }
}

extension Element {
  public enum HTMLTag: ExpressibleByStringLiteral {
    case div
    case a
    case r
    case custom(String)

    public init(stringLiteral value: String) {
      self = .custom(value)
    }
  }
}