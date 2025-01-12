extension CSSAtRules {
  public enum Media: AtRuleIdentifier {
    public static let identifier = "media"
  }
}

public typealias Media<Content: RuleChild> = AtRule<CSSAtRules.Media, Content>

extension AtRule where Self == Media<Content> {
  public init(_ query: String, @RuleBuilder content: () -> Content) {
    self.init(value: Value(query), content: content())
  }
}