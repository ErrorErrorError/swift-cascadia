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

  @_spi(CascadiaCore)
  @inlinable @inline(__always)
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(CascadiaCore)
  public static func _render<Writer: StyleSheetWriter>(
    _ style: consuming Self,
    into renderer: consuming Renderer<Writer>
  ) {
    renderer.block(style.selector) { block in
      Content._render(style.content, into: Renderer(block.writer))
    }
  }
}

infix operator =>: AssignmentPrecedence;
extension Selector {
  public static func => <Content: Block>(lhs: Self, @CSSBuilder rhs: () -> Content) -> StyleRule<Self, Content> {
    StyleRule(lhs, content: rhs)
  }
}