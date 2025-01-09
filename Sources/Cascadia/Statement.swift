/// A statement is a building block, typically a ruleset, or an at-rule.
/// 
/// https://developer.mozilla.org/en-US/docs/Web/CSS/Syntax#css_statements
public protocol Statement {
  static func render<Renderer: _StatementRendering>(_ statement: consuming Self, into renderer: inout Renderer) async throws
}

extension Statement {
  public static func render<Renderer: _StatementRendering>(
    _ statement: consuming Self, 
    into renderer: inout Renderer
  ) {
  } 
}

public struct EmptyStatement: Statement {
  @inlinable
  public init() {}
}

public protocol _StatementRendering {

}