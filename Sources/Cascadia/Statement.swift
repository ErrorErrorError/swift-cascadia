/// A statement is a building block, typically a ruleset, or an at-rule
public protocol Statement {
  associatedtype Body: Statement

  @StatementBuilder
  var body: Self.Body { get }

  func render<Renderer: StatementRenderer>(_ statement: consuming Self, into renderer: inout Renderer) async throws
}

extension Statement {
  public func render<Renderer: StatementRenderer>(
    _ statement: consuming Self, 
    into renderer: inout Renderer
  ) async throws {
  } 
}

extension Never: Statement {
  public var body: some Statement { self }
}

public extension Statement where Body == Never {
  var body: Body {
    fatalError("Cannot call `\(Self.self).body` directly")
  }
}

public struct EmptyStatement: Statement {
  @inlinable
  public init() {}
}