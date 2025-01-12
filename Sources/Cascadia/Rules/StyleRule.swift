/// A single style rule containing a selector, and a list of style declarations and rules.
/// 
/// This can also be represented as a ruleset
public struct StyleRule<S: Selector, Content: Block>: Rule, Block {
  public let selector: S
  public let content: Content

  public init(
    _ selector: S, 
    @BlockBuilder content: () -> Content
  ) {
    self.selector = selector
    self.content = content()
  }

  public var body: some Rule {
    neverBody(Self.self)
  }

  public static func _render(
    _ rule: consuming Self, 
    into renderer: consuming Renderer
  ) {
    renderer.block(rule.selector) { block in
      Content._render(rule.content, into: Renderer(block.tokens))
    }
  }
}

infix operator =>: AssignmentPrecedence;
extension Selector {
  public static func => <Content: Block>(lhs: Self, @BlockBuilder rhs: () -> Content) -> StyleRule<Self, Content> {
    StyleRule(lhs, content: rhs)
  }
}