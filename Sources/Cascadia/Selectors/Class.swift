/// e.g.: .container
public struct Class: Selector {
  public let name: String
  public init(_ name: String) {
    self.name = switch name.first {
    case .some("."):
      String(name.dropFirst())
    default:
      name
    }
  }

  @inlinable @inline(__always)
  public static func _renderSelector(
    _ selector: consuming Self,
    into renderer: consuming Renderer.SelectorRenderer
  ) {
    renderer.add(0x2E) // .
    renderer.add(selector.name) // name
  }
}

public extension Selector where Self == Class {
  static var `class`: Self.Type { Self.self }
}
