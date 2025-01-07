public struct SubsequentSibling<Parent: Selector, S: Selector>: Selector {
  init(_ parent: Parent, _ selector: S) {}
}

infix operator ~: AdditionPrecedence
public extension Selector {
  static func ~ <S: Selector>(lhs: Self, rhs: S) -> SubsequentSibling<Self, S> {
    SubsequentSibling(lhs, rhs)
  }
}