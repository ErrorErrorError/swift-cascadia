@resultBuilder
public enum RuleBuilder {
  @inlinable
  public static func buildBlock() -> EmptyRule {
    EmptyRule()
  }

  @inlinable
  public static func buildIf<Content: Rule>(_ content: Content?) -> Content? {
    content
  }

  @inlinable
  public static func buildEither<TrueContent: Rule, FalseContent: Rule>(first: TrueContent) -> some Rule {
    _RuleConditional<TrueContent, FalseContent>.trueContent(first)
  }

  @inlinable
  public static func buildEither<TrueContent: Rule, FalseContent: Rule>(second: FalseContent) -> some Rule {
    _RuleConditional<TrueContent, FalseContent>.falseContent(second)
  }
}

/// Build TupleRules without nesting tuples.
public extension RuleBuilder {
  @inlinable
  static func buildPartialBlock<Content: Rule>(first content: Content) -> Content {
    content
  }

  @inlinable
  static func buildPartialBlock<S0: Rule, S1: Rule>(accumulated: S0, next: S1) -> TupleRule<S0, S1> {
    TupleRule(accumulated, next)
  }

  @inlinable
  static func buildPartialBlock<each S0, S1: Rule>(accumulated: TupleRule< repeat each S0>, next: S1) -> TupleRule< repeat each S0, S1> {
    TupleRule(repeat each accumulated.rules, next)
  }

  // @inlinable
  // public static func buildPartialBlock<S0: Statement, S1>(accumulated: S0, next: TupleStatement<S1>) -> TupleStatement<S0, S1> {
  //   TupleStatement(accumulated, next.statements)
  // }
}

// Adds support for building ruleset from properties
public extension RuleBuilder {
  @inlinable
  static func buildPartialBlock<Content: Property>(first content: Content.Value) -> StyleDeclaration<Content> {
    StyleDeclaration(content)
  }

  @inlinable
  static func buildPartialBlock<each C0: Property, C1: Property>(accumulated: StyleDeclaration< repeat each C0>, next: C1.Value) -> StyleDeclaration< repeat each C0, C1> {
    StyleDeclaration(repeat each accumulated.properties, next)
  }

  @inlinable
  static func buildPartialBlock<S0: Rule, P0: Property>(accumulated: S0, next: P0.Value) -> TupleRule<S0, StyleDeclaration<P0>> {
    TupleRule(accumulated, StyleDeclaration(next))
  }

  @inlinable
  static func buildPartialBlock<each S0: Rule, each P0: Property, P1: Property>(
    accumulated: TupleRule< repeat each S0, StyleDeclaration< repeat each P0>>,
    next: P1
  ) -> TupleRule< repeat each S0, StyleDeclaration< repeat each P0, P1>> {
    fatalError("")
    // TupleStatement(repeat each accumulated.statements.0, RuleSet(repeat each accumulated.statements.1, next))
  }
}

@_documentation(visibility: internal)
public enum _RuleConditional<TrueContent: Rule, FalseContent: Rule>: Rule {
  case trueContent(TrueContent)
  case falseContent(FalseContent)

  public static func render(
    _ rule: consuming Self,
    into renderer: consuming Renderer
  ) {
    switch rule {
      case .trueContent(let rule):
        TrueContent.render(rule, into: renderer)
      case .falseContent(let rule):
        FalseContent.render(rule, into: renderer)
    }
  }
}

// extension _RuleConditional: RuleChild where TrueContent: RuleChild, FalseContent: RuleChild {
//   public typealias Content = _RuleConditional<TrueContent.Content, FalseContent.Content>
// }

extension Optional: Rule where Wrapped: Rule {
  public static func render(
    _: consuming Self,
    into renderer: consuming Renderer
  ) {
  }
}

extension Optional: RuleChild where Wrapped: RuleChild {
  // public typealias Content = Wrapped.Content
}
