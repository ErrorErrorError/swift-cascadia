/// A CSS selector
public protocol Selector {
  // associatedtype Body: Selector

  // var body: Body { get }

  static func _renderSelector(
    _ selector: consuming Self,
    into renderer: consuming Renderer.SelectorRenderer
  )
}

extension Selector {
  /// Renders the selector into a single string synchronously
  /// - Returns: The rendered selector
  consuming func render() -> String {
    let storage = Renderer.TokensStorage()
    Self._renderSelector(self, into: Renderer.SelectorRenderer(storage))
    return storage.collect()
  }
}
