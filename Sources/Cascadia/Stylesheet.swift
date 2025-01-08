/// A CSS that can contain statement
public struct Stylesheet<Content: Statement> {
  
  /// The ``Stylesheet/body`` of the statement
  @StatementBuilder
  public var body: Content

  /// Creates a new Cascading Style Sheet (CSS) with the specified statement.
  /// - Parameter content: The content of the statement
  @inlinable
  public init(@StatementBuilder content: () -> Content) {
    self.body = content()
  }
}