/// Chain selectors
///
/// e.g.: div.container#id
public struct Chain<Parent: Selector, Child: Selector>: Selector {
  public var parent: Parent
  public var child: Child

  @_spi(Core)
  @inlinable @inline(__always)
  public var body: Never {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public init(_ parent: Parent, _ child: Child) {
    self.parent = parent
    self.child = child
  }

  @_spi(Renderer)
  @inlinable @inline(__always)
  public static func _render<Renderer: CSSRendering>(
    _ selector: consuming Self,
    into renderer: inout Renderer
  ) {
    renderer.selector { renderer in
      renderer.join(selector.parent, selector.child)
    }
  }
}

infix operator <>: AdditionPrecedence
public extension Selector {
  consuming func chain<S: Selector>(_ selector: S) -> Chain<Self, S> {
    Chain(self, selector)
  }

  static func <> <S: Selector>(lhs: Self, rhs: S) -> Chain<Self, S> {
    lhs.chain(rhs)
  }
}