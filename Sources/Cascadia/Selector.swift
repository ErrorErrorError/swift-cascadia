/// A CSS selector
public protocol Selector {
  static func render(
    _ selector: consuming Self,
    into renderer: consuming Renderer.SelectorRenderer
  )
}

extension Selector {
  /// Renders the selector into a single string synchronously
  /// - Returns: The rendered selector
  public consuming func render() -> String {
    let storage = Renderer.ByteBuffer()
    Self.render(self, into: Renderer.SelectorRenderer(bytes: storage))
    return storage.collect()
  }
}
