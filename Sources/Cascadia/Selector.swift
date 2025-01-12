/// A CSS selector
public protocol Selector: CSS where Body: Selector {}

extension Selector {
  @_spi(CascadiaCore)
  @_documentation(visibility: internal)
  public static func _render(
    _ selector: consuming Self,
    into renderer: consuming Renderer
  ) {
    Body._render(selector.body, into: renderer)
  }
}

extension Never: Selector {}

extension EmptyCSS: Selector {}

extension TupleCSS: Selector where repeat each Child: Selector {}

extension _CSSConditional where TrueContent: Selector, FalseContent: Selector {}

extension Optional: Selector where Wrapped: Selector {}