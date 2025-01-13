/// Next Sibling Combinator `+`
///
/// e.g.: .container + a
public struct NextSibling<Parent: Selector, Child: Selector>: Selector {
  public var parent: Parent
  public var child: Child

  @_spi(CascadiaCore)
  @inlinable @inline(__always)
  public var body: Never {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public init(_ parent: Parent, _ child: Child) {
    self.parent = parent
    self.child = child
  }

  @_spi(CascadiaCore)
  @inlinable @inline(__always)
  public static func _render<Writer: StyleSheetWriter>(
    _ selector: consuming Self,
    into renderer: consuming Renderer<Writer>
  ) {
    var renderer = renderer.selector()
    renderer.join(selector.parent, selector.child, separator: 0x2B) // +
  }
}

public extension Selector {
  consuming func next<S: Selector>(_ selector: S) -> NextSibling<Self, S> {
    NextSibling(self, selector)
  }

  static func + <S: Selector>(lhs: Self, rhs: S) -> NextSibling<Self, S> {
    lhs.next(rhs)
  }
}