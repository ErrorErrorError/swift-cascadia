extension CSSAtRules {
  public enum Media: AtRuleIdentifier {
    public static let identifier = "media"
  }
}

public typealias Media<Content: Rule> = AtRule<CSSAtRules.Media, Content>

extension AtRule where ID == CSSAtRules.Media, Content: Rule {
  public init(_ query: String, @CSSBuilder content: () -> Content) {
    self.init(value: Value(query), content: content())
  }
}