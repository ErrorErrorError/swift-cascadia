public struct NextSibling<Parent: Selector, S: Selector>: Selector {
  init(_ parent: Parent, _ selector: S) {}
}

public extension Selector {
  static func + <S: Selector>(lhs: Self, rhs: S) -> NextSibling<Self, S> {
    NextSibling(lhs, rhs)
  }
}