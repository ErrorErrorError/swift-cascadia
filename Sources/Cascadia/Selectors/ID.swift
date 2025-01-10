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
  public static func render<Renderer: _SelectorRendering>(
    _ selector: consuming Self,
    into renderer: inout Renderer
  ) {
    renderer.appendTokens(0x23) // #
    renderer.appendTokens(SelectorToken(selector.name)) // name
  }
}

public extension Selector where Self == ID {
  static var id: Self.Type { Self.self }
}
