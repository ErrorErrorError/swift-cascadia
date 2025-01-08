// /// Joins multipe selectors as comma-separated selector
// private struct List<Parent: Selector, S: Selector>: Selector where Parent.Content == EmptyStatement {
//   public init(_ parent: Parent, _ selector: S) {}
// }

// private extension Selector {
//   consuming func list<S: Selector>(_ selector: S) -> List<Self, S> {
//     List(self, selector)
//   }

//   static func | <S: Selector>(lhs: Self, rhs: S) -> List<Self, S> {
//     lhs.list(rhs)
//   }
// }