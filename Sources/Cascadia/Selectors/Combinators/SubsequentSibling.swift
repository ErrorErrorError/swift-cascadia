/// Subsequent Sibling Combinator `~`
///
/// e.g.: .container ~ .box
public struct SubsequentSibling<Parent: Selector, Child: Selector>: Selector {
  public var parent: Parent
  public var child: Child

  public var body: some Selector {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public init(_ parent: Parent, _ child: Child) {
    self.parent = parent
    self.child = child
  }

  @_spi(CascadiaCore)
  @inlinable @inline(__always)
  public static func _render(
    _ selector: consuming Self,
    into renderer: consuming Renderer
  ) {
    var renderer = renderer.selector()
    renderer.join(selector.parent, selector.child, separator: 0x7E) // >
  }
}

infix operator ~: AdditionPrecedence
public extension Selector {
  consuming func subsequent<S: Selector>(_ selector: S) -> SubsequentSibling<Self, S> {
    SubsequentSibling(self, selector)
  }

  static func ~ <S: Selector>(lhs: Self, rhs: S) -> SubsequentSibling<Self, S> {
    lhs.subsequent(rhs)
  }
}
