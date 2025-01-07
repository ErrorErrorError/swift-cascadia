public protocol Selector: Statement where Body == Never {
  // var attributes: [Attribute] { get }
  // var pseudoElements: [PseudoElement] { get set }
  // var pseudoClasses: [PseudoClass] { get set }

  // func render<Renderer: SelectorRenderer>(_ selector: consuming Self, into renderer: inout Renderer) async throws
}

public extension Selector {
  // var attributes: [Attribute] { [] }
  // func render<Renderer: SelectorRenderer>(_: consuming Self, into _: inout Renderer) {}
}
