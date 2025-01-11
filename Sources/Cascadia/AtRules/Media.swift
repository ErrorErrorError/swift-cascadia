extension CSSAtRules {
  public enum Media: AtRuleIdentifier {
    public static let identifier = "media"
  }
}

public typealias Media<Content: GroupingRule> = AtRule<CSSAtRules.Media, Content>

extension Media where Content: GroupingRule {
  public init(_ query: String, @RuleBuilder content: () -> Content) {
    self.init(Value(query), content())
  }
}