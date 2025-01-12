/// A type that allows nesting other rules and blocks
public protocol Block: CSS where Body == Never {
  associatedtype Content: Block

  @CSSBuilder
  var content: Self.Content { get }
}

extension Block {
  @_spi(CascadiaCore)
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
    neverBody(Self.self)
  }
}

extension EmptyCSS: Block {
  public var content: some Block {
    neverBody(Self.self)
  }
}

extension TupleCSS: Block where repeat each Child: Block {
  public var content: some Block {
    neverBody(Self.self)
  }
}

extension _CSSConditional where TrueContent: Block, FalseContent: Block {
  public var content: some Block {
    neverBody(Self.self)
  }
}

extension Optional: Block where Wrapped: Block {
  public var content: some Block {
    neverBody(Self.self)
  }
}