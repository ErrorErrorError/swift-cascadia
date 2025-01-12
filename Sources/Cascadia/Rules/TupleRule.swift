public struct TupleRule<each R: Rule>: Rule {
  public let rules: (repeat each R)

  public init(_ rules: repeat each R) {
    self.rules = (repeat each rules)
  }

  public static func render(
    _ rule: consuming Self,
    into renderer: consuming Renderer
  ) {
    for (rule, type) in repeat (each rule.rules, (each R).self) {
      type.render(rule, into: Renderer(renderer.tokens))
    }
  }
}

extension TupleRule: RuleChild where repeat each R: RuleChild {
    public typealias Content = Never
}
