public struct TupleStatement<each S: Statement>: Statement {
  public let statements: (repeat each S)

  public init(_ statements: repeat each S) {
    self.statements = (repeat each statements)
  }
}

extension TupleStatement: NestedStatement where repeat each S: NestedStatement {}