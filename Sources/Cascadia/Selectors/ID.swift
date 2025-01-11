public struct ID: Selector {
  public let name: String

  public init(_ name: String) {
    self.name = switch name.first {
    case .some("#"):
      String(name.dropFirst())
    default:
      name
    }
  }

  @inlinable @inline(__always)
  public static func render(
    _ selector: consuming Self,
    into renderer: consuming Renderer.SelectorRenderer
  ) {
    renderer.add(0x23) // #
    renderer.add(selector.name) // name
  }
}

public extension Selector where Self == ID {
  static var id: Self.Type { Self.self }
}
