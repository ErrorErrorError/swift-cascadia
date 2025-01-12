/// A single CSS rule.
public protocol Rule: Renderable {
  associatedtype Body: Rule

  @RuleBuilder
  var body: Self.Body { get }
}

extension Rule {
  @_documentation(visibility: internal)
  public static func _render(
    _ rule: consuming Self,
    into renderer: consuming Renderer
  ) {
    Body._render(rule.body, into: renderer)
  }
}

extension Never: Rule {
  public typealias Body = Never

  public var body: Never {
    fatalError()
  }
}