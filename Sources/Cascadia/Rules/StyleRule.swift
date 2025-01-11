/// A single style rule containing a selector, and a list of style declarations and rules.
public struct StyleRule<S: Selector, Content: GroupingRule>: GroupingRule {
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
    // S.render(rule.selector, into: renderer.selector())
    // renderer.selector()
    // renderer.block(S.render(Selector, into: Renderer.SelectorRenderer))
  }
}

infix operator =>: AssignmentPrecedence;
extension Selector {
  public static func => <Content: GroupingRule>(lhs: Self, @RuleBuilder rhs: () -> Content) -> StyleRule<Self, Content> {
    StyleRule(lhs, content: rhs)
  }
}