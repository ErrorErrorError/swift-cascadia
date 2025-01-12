@resultBuilder
public enum RuleBuilder {
  @inlinable @inline(__always)
  public static func buildBlock() -> EmptyRule {
    EmptyRule()
  }

  @inlinable @inline(__always)
  public static func buildBlock<Content: Rule>(_ content: Content) -> Content {
    content
  }

  public static func buildBlock<each Content: Rule>(_ contents: repeat each Content) -> TupleRule<repeat each Content> {
    TupleRule(repeat each contents)
  }

  @inlinable @inline(__always)
  public static func buildIf<Content: Rule>(_ content: Content?) -> Content? {
    content
  }

  @inlinable @inline(__always)
  public static func buildEither<TrueContent: Rule, FalseContent: Rule>(first: TrueContent) -> _RuleConditional<TrueContent, FalseContent> {
    .trueContent(first)
  }

  @inlinable @inline(__always)
  public static func buildEither<TrueContent: Rule, FalseContent: Rule>(second: FalseContent) -> _RuleConditional<TrueContent, FalseContent> {
    .falseContent(second)
  }
}

/// A type that represents an empty CSS rule.
public struct EmptyRule: Rule {
  @inlinable @inline(__always)
  public init() {}

  public var body: some Rule {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public static func _renderRule(
    _ rule: consuming Self, 
    into renderer: consuming Renderer
  ) {
  }
}

/// A type that joins multiple tuple rules
public struct TupleRule<each Child: Rule>: Rule {
  public let rules: (repeat each Child)

  @inlinable
  public init(_ rules: repeat each Child) {
    self.rules = (repeat each rules)
  }

  public var body: some Rule {
    neverBody(Self.self)
  }

  public static func _renderRule(
    _ rule: consuming Self,
    into renderer: consuming Renderer
  ) {
    for rule in repeat each rule.rules {
      func render<R: Rule>(_ rule: R) {
        R._renderRule(rule, into: Renderer(renderer.tokens))
      }

      render(rule)
    }
  }
}

@_documentation(visibility: internal)
public enum _RuleConditional<TrueContent: Rule, FalseContent: Rule>: Rule {
  case trueContent(TrueContent)
  case falseContent(FalseContent)

  public var body: some Rule {
    neverBody(Self.self)
  }

  public static func _renderRule(
    _ rule: consuming Self,
    into renderer: consuming Renderer
  ) {
    switch rule {
      case .trueContent(let rule):
        TrueContent._renderRule(rule, into: renderer)
      case .falseContent(let rule):
        FalseContent._renderRule(rule, into: renderer)
    }
  }
}

extension Optional: Rule where Wrapped: Rule {
  public var body: some Rule {
    neverBody(Self.self)
  }

  public static func _renderRule(
    _ rule: consuming Self,
    into renderer: consuming Renderer
  ) {
    guard let rule else {
      return
    }
    Wrapped._renderRule(rule, into: renderer)
  }
}