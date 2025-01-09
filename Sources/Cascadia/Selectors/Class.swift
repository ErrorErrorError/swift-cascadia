/// e.g.: .container
public struct Class: Selector {
  public let name: String  
  public init(_ name: String) {
    self.name = switch  name.first {
    case .some("."):
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
    renderer.appendBytes(0x2E)                // .
    renderer.appendBytes(selector.name.utf8)  // name
  }
}

extension Selector where Self == Class {
  public static var `class`: Self.Type { Self.self }
}
