@resultBuilder
public enum BlockBuilder {
  @inlinable @inline(__always)
  public static func buildBlock() -> EmptyBlock {
    EmptyBlock()
  }

  @inlinable @inline(__always)
  public static func buildBlock<Content: Block>(_ content: Content) -> Content {
    content
  }

  public static func buildBlock<each Content: Block>(_ contents: repeat each Content) -> TupleBlock<repeat each Content> {
    TupleBlock(repeat each contents)
  }

  @inlinable @inline(__always)
  public static func buildIf<Content: Block>(_ content: Content?) -> Content? {
    content
  }

  @inlinable @inline(__always)
  public static func buildEither<TrueContent: Block, FalseContent: Block>(first: TrueContent) -> _BlockConditional<TrueContent, FalseContent> {
    .trueContent(first)
  }

  @inlinable @inline(__always)
  public static func buildEither<TrueContent: Block, FalseContent: Block>(second: FalseContent) -> _BlockConditional<TrueContent, FalseContent> {
    .falseContent(second)
  }
}

/// A type that represents an empty CSS rule.
public struct EmptyBlock: Block {
  @inlinable @inline(__always)
  public init() {}

  public var content: some Block {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public static func _renderBlock(
    _ block: consuming Self, 
    into renderer: consuming Renderer
  ) {
  }
}

/// A type that joins multiple tuple rules
public struct TupleBlock<each Child: Block>: Block {
  public let blocks: (repeat each Child)

  @inlinable
  public init(_ blocks: repeat each Child) {
    self.blocks = (repeat each blocks)
  }

  public var content: some Block {
    neverBody(Self.self)
  }

  public static func _renderBlock(
    _ block: consuming Self,
    into renderer: consuming Renderer
  ) {
    for block in repeat each block.blocks {
      func render<R: Block>(_ block: R) {
        R._renderBlock(block, into: Renderer(renderer.tokens))
      }

      render(block)
    }
  }
}

@_documentation(visibility: internal)
public enum _BlockConditional<TrueContent: Block, FalseContent: Block>: Block {
  case trueContent(TrueContent)
  case falseContent(FalseContent)

  public var content: some Block {
    neverBody(Self.self)
  }

  public static func _renderBlock(
    _ block: consuming Self,
    into renderer: consuming Renderer
  ) {
    switch block {
      case .trueContent(let block):
        TrueContent._renderBlock(block, into: renderer)
      case .falseContent(let block):
        FalseContent._renderBlock(block, into: renderer)
    }
  }
}

extension Optional: Block where Wrapped: Block {
  public var content: some Block {
    neverBody(Self.self)
  }

  public static func _renderBlock(
    _ block: consuming Self,
    into renderer: consuming Renderer
  ) {
    guard let block else {
      return
    }
    Wrapped._renderBlock(block, into: renderer)
  }
}