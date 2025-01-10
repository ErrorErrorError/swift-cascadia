/// A statement is a building block, typically a ruleset, or an at-rule.
/// 
/// https://developer.mozilla.org/en-US/docs/Web/CSS/Syntax#css_statements
public protocol Statement {
  static func render<Renderer: _StatementRendering>(
    _ statement: consuming Self, 
    into renderer: inout Renderer
  ) async throws
}

public protocol NestedStatement: Statement {}

public enum StatementRenderToken {}

extension Statement {
  public static func render<Renderer: _StatementRendering>(
    _ statement: consuming Self, 
    into renderer: inout Renderer
  ) {
  }

  public consuming func render() -> String {
    fatalError("not implemented")
  }
}

public struct EmptyStatement: NestedStatement {
  @inlinable
  public init() {}
}

public protocol _StatementRendering {}