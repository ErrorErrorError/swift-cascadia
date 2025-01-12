/// A single CSS rule.
public protocol Rule {
  associatedtype Body: Rule

  @RuleBuilder
  var body: Self.Body { get }

  @_documentation(visibility: internal)
  static func _renderRule(
    _ rule: consuming Self,
    into renderer: consuming Renderer
  )
}

extension Rule {
  @_documentation(visibility: internal)
  public static func _renderRule(
    _ rule: consuming Self,
    into renderer: consuming Renderer
  ) {
    Body._renderRule(rule.body, into: renderer)
  }

  consuming func render() -> String {
    let storage = Renderer.TokensStorage()
    Self._renderRule(self, into: Renderer(storage))
    return storage.collect()
  }
}

extension Never: Rule {
  public typealias Body = Never

  public var body: Never {
    fatalError()
  }
}