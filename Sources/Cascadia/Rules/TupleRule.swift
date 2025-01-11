public struct TupleRule<each R: Rule>: Rule {
  public let rules: (repeat each R)

  public init(_ rules: repeat each R) {
    self.rules = (repeat each rules)
  }

  public static func render(
    _ rule: consuming Self,
    into renderer: consuming Renderer
  ) {
    // repeat (each R).render(repeat each rule.rules, into: renderer)
  }
}

extension TupleRule: GroupingRule where repeat each R: GroupingRule {
    public typealias Content = Never
}
