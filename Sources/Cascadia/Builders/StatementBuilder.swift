@resultBuilder
public enum StatementBuilder {
  @inlinable
  public static func buildBlock() -> some Statement {
    EmptyStatement()
  }

  @inlinable
  public static func buildBlock<Content: Statement>(_ component: Content) -> some Statement {
    component
  }

  @inlinable
  public static func buildBlock<each Content: Statement>(_ content: repeat each Content) -> TupleStatement<repeat each Content> {
    TupleStatement(repeat each content)
  }

  @inlinable
  public static func buildIf<Content: Statement>(_ content: Content?) -> (some Statement)? {
    content
  }

  @inlinable
  public static func buildEither<TrueContent: Statement, FalseContent: Statement>(first: TrueContent) -> some Statement {
    _StatementConditional<TrueContent, FalseContent>.trueContent(first)
  }

  @inlinable
  public static func buildEither<TrueContent: Statement, FalseContent: Statement>(second: FalseContent) -> some Statement {
    _StatementConditional<TrueContent, FalseContent>.falseContent(second)
  }
}

// Adds support for property builder
extension StatementBuilder {
  // @inlinable
  // public static func buildExpression<Content: Statement>(_ content: Content) -> Content {
  //   content
  // }

  // @inlinable
  // public static func buildExpression<Content: Property>(_ content: Content) -> RuleSet<Content> {
  //   RuleSet(content)
  // }

  @inlinable
  public static func buildBlock<each P: Property>(_ properties: repeat each P) -> RuleSet<repeat each P> {
    RuleSet(repeat each properties)
  }

  // @inlinable
  // public static func buildBlock<Content: Statement, each P: Property>(_ content: Content, _ properties: repeat each P) -> _StatementTuple<Content, RuleSet<repeat each P>> {
  //   _StatementTuple(content, RuleSet(repeat each properties))
  // }
}

@_documentation(visibility: internal)
public enum _StatementConditional<TrueContent: Statement, FalseContent: Statement>: Statement {
  case trueContent(TrueContent)
  case falseContent(FalseContent)
}

public struct TupleStatement<each S: Statement>: Statement {
  let statements: (repeat each S)

  public init(_ statements: repeat each S) {
    self.statements = (repeat each statements)
  }
}

@_documentation(visibility: internal)
public struct RuleSet<each P: Property>: Statement {
  let properties: (repeat each P)
  
  public init(_ properties: repeat each P) {
    self.properties = (repeat each properties)
  }
}

extension Optional: Statement where Wrapped: Statement {}