/// A single style rule containing a selector, and a list of style declarations and rules.
/// 
/// This can also be represented as a ruleset
public struct StyleRule<S: Selector, Content: Block>: Rule, Block {
  let selector: S
  let content: Content

  public init(
    _ selector: S, 
    @CSSBuilder content: () -> Content
  ) {
    self.selector = selector
    self.content = content()
  }

  @_spi(Core)
  @inlinable @inline(__always)
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(Renderer)
  public static func _render<Renderer: CSSRendering>(
    _ style: consuming Self,
    into renderer: inout Renderer
  ) {
    renderer.block(style.selector) { block in
      Content._render(style.content, into: &block)
    }
  }
}

infix operator =>: AssignmentPrecedence;
extension Selector {
  public static func => <Content: Block>(lhs: Self, @CSSBuilder rhs: () -> Content) -> StyleRule<Self, Content> {
    StyleRule(lhs, content: rhs)
  }
}