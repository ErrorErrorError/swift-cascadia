/// A type that allows 
public protocol Block: Renderable {
  associatedtype Content: Block

  @BlockBuilder
  var content: Self.Content { get }
}

extension Block {
  @_documentation(visibility: internal)
  public static func _render(
    _ block: consuming Self,
    into renderer: consuming Renderer
  ) {
    Content._render(block.content, into: renderer)
  }
}

extension Never: Block {
  public typealias Content = Never

  public var content: Never {
    fatalError()
  }

  public static func _render(
    _ rule: consuming Self, 
    into renderer: consuming Renderer
  ) {
    fatalError("")
  }
}

func neverBody<T>(_ type: T.Type = T.self) -> Never {
  fatalError("body cannot be called on \(type)")
}
