extension CSSAtRules {
  public enum Media: NestedAtRuleID {
    public static let identifier = "media"
  }
}

public typealias Media<Content: NestedStatement> = AtRule<CSSAtRules.Media, Content>

extension Media where Content: NestedStatement {
  public init(_ query: String, @StatementBuilder content: () -> Content) {
    self.init(Rule(query), content())
  }
}