@resultBuilder
public enum CSSBuilder {
  @inlinable @inline(__always)
  public static func buildBlock() -> EmptyCSS {
    EmptyCSS()
  }

  @inlinable @inline(__always)
  public static func buildBlock<Content: CSS>(_ content: Content) -> Content {
    content
  }

  @inlinable @inline(__always)
  public static func buildBlock<each Content: CSS>(_ contents: repeat each Content) -> CSSTuple<repeat each Content> {
    CSSTuple(repeat each contents)
  }

  @inlinable @inline(__always)
  public static func buildIf<Content: CSS>(_ content: Content?) -> Content? {
    content
  }

  @inlinable @inline(__always)
  public static func buildEither<TrueContent: CSS, FalseContent: CSS>(first: TrueContent) -> _CSSConditional<TrueContent, FalseContent> {
    .trueContent(first)
  }

  @inlinable @inline(__always)
  public static func buildEither<TrueContent: CSS, FalseContent: CSS>(second: FalseContent) -> _CSSConditional<TrueContent, FalseContent> {
    .falseContent(second)
  }
}

public struct EmptyCSS: CSS, Sendable {
  public init() {}

  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(CascadiaCore)
  public static func _render(
    _ value: consuming Self,
    into renderer: consuming Renderer
  ) {
  }
}

/// A type that joins multiple tuple rules
public struct CSSTuple<each Child: CSS>: CSS {
  public let values: (repeat each Child)

  @inlinable
  public init(_ values: repeat each Child) {
    self.values = (repeat each values)
  }

  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(CascadiaCore)
  public static func _render(
    _ value: consuming Self,
    into renderer: consuming Renderer
  ) {
    for value in repeat each value.values {
      func render<T: CSS>(_ value: T) {
        T._render(value, into: Renderer(renderer.tokens))
      }

      render(value)
    }
  }
}

extension CSSTuple: Sendable where repeat each Child: Sendable {}

@_documentation(visibility: internal)
public enum _CSSConditional<TrueContent: CSS, FalseContent: CSS>: CSS {
  case trueContent(TrueContent)
  case falseContent(FalseContent)

  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(CascadiaCore)
  public static func _render(
    _ value: consuming Self,
    into renderer: consuming Renderer
  ) {
    switch value {
      case .trueContent(let value):
        TrueContent._render(value, into: renderer)
      case .falseContent(let value):
        FalseContent._render(value, into: renderer)
    }
  }
}

extension _CSSConditional: Sendable where TrueContent: Sendable, FalseContent: Sendable {}


extension Optional: CSS where Wrapped: CSS {
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(CascadiaCore)
  public static func _render(
    _ renderable: consuming Self,
    into renderer: consuming Renderer
  ) {
    guard let renderable else {
      return
    }
    Wrapped._render(renderable, into: renderer)
  }
}

extension Optional: Sendable where Wrapped: Sendable {}