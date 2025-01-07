// infix operator <>: AdditionPrecedence
// public enum CSSSelector {
//   // MARK: General

//   /// e.g.: `*`
//   case all
  
//   /// e.g.: *[class='test']
//   indirect case attribute(Self, String)
  
//   /// e.g.: .container
//   case `class`(String)
  
//   /// e.g.: div
//   case element(String)
  
//   /// e.g.: #id
//   case id(String)
  
//   // case pseudo(String)

//   // MARK: Combinators

//   /// Child Combinator
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
//   /// e.g.: container ~ box
//   indirect case subsequent(Self, Self)

//   // MARK: Other

//   /// e.g.: div.container#id
//   indirect case joined(Self, Self)

//   static func * (lhs: Self, rhs: Self) -> Self {
//     .descendant(lhs, rhs)
//   }

//   static func > (lhs: Self, rhs: Self) -> Self {
//     .child(lhs, rhs)
//   }

//   static func + (lhs: Self, rhs: Self) -> Self {
//     .next(lhs, rhs)
//   }

//   static func ~ (lhs: Self, rhs: Self) -> Self {
//     .subsequent(lhs, rhs)
//   }

//   static func <>(lhs: Self, rhs: Self) -> Self {
//     .joined(lhs, rhs)
//   }
// }

// func test() {
//   let selector = (.all > .class("")) > .id("String") ~ .all
// }