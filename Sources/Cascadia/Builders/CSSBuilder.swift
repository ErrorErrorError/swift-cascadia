@resultBuilder
public enum CSSBuilder {
  @inlinable
  public static func buildBlock() -> EmptyCSS {
    EmptyCSS()
  }

  @inlinable
  public static func buildBlock<Content: CSS>(_ component: Content) -> Content {
    component
  }

  @inlinable
  public static func buildIf<Content: CSS>(_ content: Content?) -> Content? {
    content
  }

  @inlinable
  public static func buildEither<TrueContent: CSS, FalseContent: CSS>(first: TrueContent) -> _CSSConditional<TrueContent, FalseContent> {
    .trueContent(first)
  }

  @inlinable
  public static func buildEither<TrueContent: CSS, FalseContent: CSS>(second: FalseContent) -> _CSSConditional<TrueContent, FalseContent> {
    .falseContent(second)
  }

  @inlinable
  public static func buildBlock<each Content: CSS>(_ content: repeat each Content) -> _CSSTuple<repeat each Content> {
    _CSSTuple(repeat each content)
  }
}

@_documentation(visibility: internal)
public enum _CSSConditional<TrueContent: CSS, FalseContent: CSS>: CSS {
  case trueContent(TrueContent)
  case falseContent(FalseContent)
}

extension _CSSConditional: Statement where TrueContent: Statement, FalseContent: Statement {}

@_documentation(visibility: internal)
public struct _CSSTuple<each Content: CSS>: CSS {
  @inlinable
  public init(_ pack: repeat each Content) {
  }
}

extension _CSSTuple: Statement where repeat each Content: Statement {}

extension Optional: CSS where Wrapped: CSS {}