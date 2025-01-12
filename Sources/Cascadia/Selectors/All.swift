/// Selects all elements
public struct All: Selector, Sendable {

  public var body: some Selector {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public init() {}

  @_spi(CascadiaCore)
  @inlinable @inline(__always)
  public static func _render(
    _ selector: consuming Self,
    into renderer: consuming Renderer
  ) {
    var renderer = renderer.selector()
    renderer.add(0x2A)  // *
  }
}

extension Selector where Self == All {
  public static var all: Self { Self() }
}