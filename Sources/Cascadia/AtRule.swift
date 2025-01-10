/// A top-level At-Rule that 
public protocol AtRule: Statement {
  static var identifier: String { get }
}

/// A nestable At-Rule that can be used in nested statements
public typealias NestedAtRule = AtRule & NestedStatement