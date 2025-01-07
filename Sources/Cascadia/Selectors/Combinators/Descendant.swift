/// Combine two selectors such that elements matched by the second selector are selected if they have an ancestor.
/// 
/// In CSS, this is typically represented by a single space " " between two selectors.
public struct Descendant<S0: Selector, S1: Selector>: Selector {
  public init(_ first: S0, _ second: S1) {}
}

public extension Selector {
  static func * <S: Selector>(lhs: Self, rhs: S) -> Descendant<Self, S> {
    Descendant(lhs, rhs)
  }
}