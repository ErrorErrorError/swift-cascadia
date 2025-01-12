/// A single style rule containing a selector, and a list of style declarations and rules.
/// 
/// This can also be represented as a ruleset
public struct StyleRule<S: Selector, Content: RuleChild>: RuleChild {
  public let selector: S
  public let content: Content

  public init(
    _ selector: S, 
    @RuleBuilder content: () -> Content
  ) {
    self.selector = selector
    self.content = content()
  }

  public static func render(
    _ rule: consuming Self, 
    into renderer: consuming Renderer
  ) {
    renderer.block(rule.selector) { [tokens = renderer.tokens] block in
      Content.render(rule.content, into: .init(tokens))
    }
  }
}

infix operator =>: AssignmentPrecedence;
extension Selector {
  public static func => <Content: RuleChild>(lhs: Self, @RuleBuilder rhs: () -> Content) -> StyleRule<Self, Content> {
    StyleRule(lhs, content: rhs)
  }
}