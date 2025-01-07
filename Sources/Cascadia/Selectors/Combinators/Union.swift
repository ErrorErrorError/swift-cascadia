/// Joins multipe selectors as comma-separated selector
public struct Union<Parent: Selector, S: Selector>: Selector {
  init(_ parent: Parent, _ selector: S) {}
}

public extension Selector {
  static func | <S: Selector>(lhs: Self, rhs: S) -> Union<Self, S> {
    Union(lhs, rhs)
  }
}