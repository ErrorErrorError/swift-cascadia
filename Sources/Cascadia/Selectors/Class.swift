/// e.g.: .container
public struct Class: Selector {
  public let name: String

  @_spi(CascadiaCore)
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

  @_spi(CascadiaCore)
  @inlinable @inline(__always)
  public static func _render<Writer: StyleSheetWriter>(
    _ selector: consuming Self,
    into renderer: consuming Renderer<Writer>
  ) {
    var renderer = renderer.selector()
    renderer.add(0x2E) // .
    renderer.add(selector.name) // name
  }
}

public extension Selector where Self == Class {
  static var `class`: Self.Type { Self.self }
}
