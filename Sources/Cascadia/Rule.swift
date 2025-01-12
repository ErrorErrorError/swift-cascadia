/// A single CSS rule.
public protocol Rule: CSS where Body: Rule {}

extension Rule {
  @_spi(CascadiaCore)
  @_documentation(visibility: internal)
  public static func _render(
    _ rule: consuming Self,
    into renderer: consuming Renderer
  ) {
    Body._render(rule.body, into: renderer)
  }
}

extension Never: Rule {}
extension EmptyCSS: Rule  {}
extension TupleCSS: Rule where repeat each Child: Rule {}
extension _CSSConditional where TrueContent: Rule, FalseContent: Rule {}
extension Optional: Rule where Wrapped: Rule {}