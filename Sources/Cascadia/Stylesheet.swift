/// A CSS that can contain statement
public struct Stylesheet<Content: Statement> {
  
  /// The ``Stylesheet/body`` of the statement
  @StatementBuilder
  public var body: Content

  /// Creates a new Cascading Style Sheet (CSS) with the specified statement.
  /// - Parameter content: The content of the statement
  @inlinable
  public init(
    charset: Charset = .utf8,
    @StatementBuilder content: () -> Content
  ) {
    self.body = content()
  }

  public consuming func render() {
    // var renderer = StatementRenderer()
    // let result = try await Content.render(body, into: &renderer)
  }
}

extension Stylesheet {
  public enum Charset {
    /// UTF-8
    case utf8

    /// ISO 8559-15 
    case iso8559_15
  }
}