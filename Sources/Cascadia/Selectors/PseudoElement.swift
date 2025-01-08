// public struct PseudoElement: Selector, ExpressibleByStringLiteral, RawRepresentable {
//   public let rawValue: String

//   public init(rawValue: String) {
//     self.rawValue = rawValue
//   }

//   public init(stringLiteral value: StringLiteralType) {
//     self.init(rawValue: value)
//   }

//   private init(_ rawValue: String = #function) {
//     self.init(rawValue: rawValue)
//   }

//   public var body: Never {
//     fatalError()
//   }
// }

// extension PseudoElement {
//   public static var after: Self { .init() }
//   public static var before: Self { .init() }
//   public static var firstLetter: Self { "first-letter" }
// }