/// A selector that follows a CSS ruleset structure.
public protocol Selector<Content>: Statement where Body == Never {
  associatedtype Content: Statement
  
  static func render<Renderer: SelectorRenderer>(_ selector: consuming Self, into renderer: inout Renderer) async throws
}

extension Selector {
  public static func render<Renderer: SelectorRenderer>(
    _ selector: consuming Self, 
    into renderer: inout Renderer
  ) async throws {

  }
}

extension Selector {
  public func render<Renderer: SelectorRenderer>(
    _ selector: consuming Self, 
    into renderer: inout Renderer
  ) async throws {}
}