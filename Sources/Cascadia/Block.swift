///
public protocol Block {
  associatedtype Content: Block

  @BlockBuilder
  var content: Self.Content { get }

  @_documentation(visibility: internal)
  static func _renderBlock(
    _ block: consuming Self,
    into renderer: consuming Renderer
  )
}

extension Block {
  @_documentation(visibility: internal)
  public static func _renderBlock(
    _ block: consuming Self,
    into renderer: consuming Renderer
  ) {
    Content._renderBlock(block.content, into: renderer)
  }

  consuming func render() -> String {
    let storage = Renderer.TokensStorage()
    Self._renderBlock(self, into: Renderer(storage))
    return storage.collect()
  }
}

extension Never: Block {
  public typealias Content = Never

  public var content: Never {
    fatalError()
  }
}

func neverBody<T>(_ type: T.Type = T.self) -> Never {
  fatalError("body cannot be called on \(type)")
}
