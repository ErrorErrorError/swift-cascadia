@resultBuilder
public enum StatementBuilder {
  @inlinable
  public static func buildBlock() -> EmptyStatement {
    EmptyStatement()
  }

  @inlinable
  public static func buildIf<Content: Statement>(_ content: Content?) -> Content? {
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

extension StatementBuilder {
  @inlinable
  public static func buildPartialBlock<Content: Statement>(first content: Content) -> Content {
    content
  }

  // @_disfavoredOverload
  @inlinable
  public static func buildPartialBlock<S0: Statement, S1: Statement>(accumulated: S0, next: S1) -> TupleStatement<S0, S1> {
    TupleStatement(accumulated, next)
  }

  @inlinable
  public static func buildPartialBlock<each S0, S1: Statement>(accumulated: TupleStatement<repeat each S0>, next: S1) -> TupleStatement<repeat each S0, S1> {
    TupleStatement(repeat each accumulated.statements, next)
  }

  // @inlinable
  // public static func buildPartialBlock<S0: Statement, S1>(accumulated: S0, next: TupleStatement<S1>) -> TupleStatement<S0, S1> {
  //   TupleStatement(accumulated, next.statements)
  // }
}

// Adds support for building ruleset from properties
extension StatementBuilder {
  @inlinable
  public static func buildPartialBlock<Content: Property>(first content: Content.Value) -> RuleSet<Content> {
    RuleSet(content)
  }

  @inlinable
  public static func buildPartialBlock<each C0: Property, C1: Property>(accumulated: RuleSet<repeat each C0>, next: C1.Value) -> RuleSet<repeat each C0, C1> {
    RuleSet(repeat each accumulated.properties, next)
  }

  @inlinable
  public static func buildPartialBlock<S0: Statement, P0: Property>(accumulated: S0, next: P0.Value) -> TupleStatement<S0, RuleSet<P0>> {
    TupleStatement(accumulated, RuleSet(next))
  }

  @inlinable
  public static func buildPartialBlock<each S0: Statement, each P0: Property, P1: Property>(
    accumulated: TupleStatement<repeat each S0, RuleSet<repeat each P0>>, 
    next: P1
  ) -> TupleStatement<repeat each S0, RuleSet<repeat each P0, P1>> {
    fatalError("")
    // TupleStatement(repeat each accumulated.statements.0, RuleSet(repeat each accumulated.statements.1, next))
  }
}

@_documentation(visibility: internal)
public enum _StatementConditional<TrueContent: Statement, FalseContent: Statement>: Statement {
  case trueContent(TrueContent)
  case falseContent(FalseContent)
}

extension _StatementConditional: NestedStatement where TrueContent: NestedStatement, FalseContent: NestedStatement {}

extension Optional: Statement where Wrapped: Statement {}
extension Optional: NestedStatement where Wrapped: NestedStatement {}