// enum CSSSelector {
//   // MARK: General selectors

//   /// e.g.: `*`
//   case all

//   /// e.g.: [class='test']
//   indirect case attr(Self? = nil, name: String, operation: String? = nil, value: String? = nil)

//   /// e.g.: .container
//   case `class`(String)

//   /// e.g.: div
//   case element(String)

//   /// e.g.: #id
//   case id(String)

//   /// e.g.: :first-child
//   indirect case pseudo(Self? = nil, PseudoClass)

//   /// e.g.: ::before
//   indirect case pseudo(Self, element: PseudoElement)

//   // MARK: Combinators

//   /// Child Combinator `>`
//   ///
//   /// e.g.: .container > a
//   indirect case child(Self, Self)

//   /// Descendant Combinator ` `
//   ///
//   /// e.g.: .container .item .a
//   indirect case descendant(Self, Self)

//   /// Next Sibling Combinator `+`
//   ///
//   /// e.g.: .container + a
//   indirect case next(Self, Self)

//   /// Subsequent Sibling Combinator `~`
//   ///
//   /// e.g.: .container ~ .box
//   indirect case subsequent(Self, Self)

//   // MARK: Other

//   /// Chain selectors
//   /// e.g.: div.container#id
//   indirect case chain(Self, Self)

//   static func > (lhs: Self, rhs: Self) -> Self {
//     .child(lhs, rhs)
//   }

//   static func * (lhs: Self, rhs: Self) -> Self {
//     .descendant(lhs, rhs)
//   }

//   static func + (lhs: Self, rhs: Self) -> Self {
//     .next(lhs, rhs)
//   }

//   static func ~ (lhs: Self, rhs: Self) -> Self {
//     .subsequent(lhs, rhs)
//   }

//   /// Chain selectors
//   static func <> (lhs: Self, rhs: Self) -> Self {
//     .chain(lhs, rhs)
//   }

//   public struct PseudoClass {
//     public var rawValue: String

//     public init(_ value: String) {
//      self.rawValue = value
//     }

//     public static var active: Self { Self("active") }
//   }

//   public struct PseudoElement: ExpressibleByStringLiteral {
//     public var rawValue: String

//     public init(stringLiteral value: StringLiteralType) {
//      self.rawValue = value
//     }

//     public static var firstLetter: Self { "first-letter" }
//     public static var firstLine: Self { "first-line" }

//   }
// }

// struct _Select<Content: Statement>: Statement {
//   let selector: CSSSelector
//   let content: Content

//   init(_ selector: CSSSelector, @StatementBuilder content: () -> Content) {
//     self.selector = selector
//     self.content = content()
//   }
// }

// infix operator =>: AdditionPrecedence
// func => <Content: Statement>(selector: CSSSelector, @StatementBuilder content: () -> Content) -> _Select<Content> {
//   _Select(selector, content: content)
// }
