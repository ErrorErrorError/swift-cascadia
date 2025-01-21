/// e.g.: .container
public struct Class: Sendable, Selector {
  public let name: String

  @_spi(Core)
  @inlinable @inline(__always)
  public var body: Never {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public init(_ name: String) {
    self.name = switch name.first {
    case .some("."):
      String(name.dropFirst())
    default:
      name
    }
  }

  @_spi(Renderer)
  @inlinable @inline(__always)
  public static func _render<Writer: CSSStreamWriter>(
    _ selector: consuming Self,
    into renderer: inout Renderer<Writer>
  ) {
    renderer.selector { renderer in
      renderer.write(0x2E) // .
      renderer.write(contentsOf: selector.name.utf8) // name
    }
  }
}

public extension Selector where Self == Class {
  static var `class`: Self.Type { Self.self }
}
