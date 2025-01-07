// > delimiter
public struct Child<Parent: Selector, S: Selector>: Selector {
  init(_: Parent, _: S) {}
}

public extension Selector {
  static func > <S: Selector>(lhs: Self, rhs: S) -> Child<Self, S> {
    Child(lhs, rhs)
  }
}
