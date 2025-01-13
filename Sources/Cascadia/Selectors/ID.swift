public struct ID: Selector {
  public let name: String

  @_spi(CascadiaCore)
  @inlinable @inline(__always)
  public var body: Never {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public init(_ name: String) {
    self.name = switch name.first {
    case .some("#"):
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
    renderer.add(0x23) // #
    renderer.add(selector.name) // name
  }
}

public extension Selector where Self == ID {
  static var id: Self.Type { Self.self }
}
