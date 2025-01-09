/// Selects all elements
public struct All: Selector, Sendable {
  @inlinable
  public init() {}

  @inlinable @inline(__always)
  public static func render<Renderer: _SelectorRendering>(
    _ selector: consuming Self, 
    into renderer: inout Renderer
  ) {
    renderer.appendBytes(0x2A) // *
  }
}

extension Selector where Self == All {
  public static var all: Self { Self() }
}