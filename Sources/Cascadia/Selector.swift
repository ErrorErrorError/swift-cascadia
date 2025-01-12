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
  consuming func render() -> String {
    let storage = Renderer.TokensStorage()
    Self.render(self, into: Renderer.SelectorRenderer(storage))
    return storage.collect()
  }
}
