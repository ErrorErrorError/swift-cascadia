@resultBuilder
public enum CSSBuilder {
  @inlinable @inline(__always)
  public static func buildBlock() -> EmptyCSS {
    EmptyCSS()
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

extension CSSBuilder {
  @inlinable @inline(__always)
  public static func buildPartialBlock<Content: CSS>(first content: Content) -> Content {
    content
  }

  @inlinable @inline(__always)
  public static func buildPartialBlock<S0: CSS, S1: CSS>(accumulated: S0, next: S1) -> CSSTuple<S0, S1> {
    CSSTuple(accumulated, next)
  }

  @inlinable @inline(__always)
  public static func buildPartialBlock<each S0: CSS, S1: CSS>(
    accumulated: CSSTuple<repeat each S0>, 
    next: S1
  ) -> CSSTuple<repeat each S0, S1> {
    CSSTuple(repeat each accumulated.values, next)
  }
}

public struct EmptyCSS: CSS, Sendable {
  public init() {}

  @_spi(Core)
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(Renderer)
  public static func _render<Writer: CSSStreamWriter>(
    _ value: consuming Self,
    into renderer: inout Renderer<Writer>
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

  @_spi(Core)
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(Renderer)
  public static func _render<Writer: CSSStreamWriter>(
    _ value: consuming Self,
    into renderer: inout Renderer<Writer>
  ) {
    for value in repeat each value.values {
      func render<T: CSS>(_ value: T) {
        T._render(value, into: &renderer)
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

  @_spi(Core)
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(Renderer)
  public static func _render<Writer: CSSStreamWriter>(
    _ value: consuming Self,
    into renderer: inout Renderer<Writer>
  ) {
    switch value {
      case .trueContent(let value):
        TrueContent._render(value, into: &renderer)
      case .falseContent(let value):
        FalseContent._render(value, into: &renderer)
    }
  }
}

extension _CSSConditional: Sendable where TrueContent: Sendable, FalseContent: Sendable {}

extension Optional: CSS where Wrapped: CSS {
  @_spi(Core)
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(Renderer)
  public static func _render<Writer: CSSStreamWriter>(
    _ value: consuming Self,
    into renderer: inout Renderer<Writer>
  ) {
    guard let value else {
      return
    }
    Wrapped._render(value, into: &renderer)
  }
}

extension Optional: Sendable where Wrapped: Sendable {}