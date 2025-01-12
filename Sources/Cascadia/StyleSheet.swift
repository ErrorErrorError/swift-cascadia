/// A CSS that can contain statement
public struct StyleSheet<Content: Rule> {
  
  /// The ``Stylesheet/body`` of the statement
  @CSSBuilder
  public var body: Content

  /// Creates a new Cascading Style Sheet (CSS) with the specified statement.
  /// - Parameter content: The content of the statement
  @inlinable
  public init(
    charset: Charset = .utf8,
    @CSSBuilder content: () -> Content
  ) {
    self.body = content()
  }

  public consuming func render() -> String {
    let storage = Renderer.TokensStorage()
    Content._render(body, into: Renderer(storage))
    return storage.collect()
  }
}

extension StyleSheet {
  public enum Charset {
    /// UTF-8
    case utf8

    /// ISO 8559-15 
    case iso8559_15
  }
}