extension CSSAtRules {
  public enum Layer: AtRuleIdentifier {
    public static let identifier = "layer"
  }
}

public typealias Layer<Content: Rule> = AtRule<CSSAtRules.Layer, Content>

extension AtRule where Self == Layer<Never> {
  public init(_ names: String...) {
    self.init(value: Value(names.joined(separator: ", ")))
  }
}

extension AtRule where Self == Layer<Content>, Content: Rule {
  public init(_ first: String? = nil, @RuleBuilder content: () -> Content) {
    self.init(
      value: first.flatMap(Value.init(stringLiteral:)), 
      content: content()
    )
  }
}