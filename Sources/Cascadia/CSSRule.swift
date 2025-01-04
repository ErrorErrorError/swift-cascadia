// let backgroundColor = BackgroundColor.init

/// A qualified rule has a prelude consisting of a list of component values, and a block consisting of a simple {} block
public protocol QualifiedRule {
  associatedtype Prelude
  associatedtype Content

  var prelude: Self.Prelude { get }
  var body: Self.Content { get }
}

public protocol Selector {}

/// A style rule is a qualified rule with the prelude being a selector, and the content being a list of properties.
///
/// ```css
/// head {
///   background-color: 'red'
/// }
/// ```
public protocol StyleRule: QualifiedRule where Prelude: Selector, Content: Property {
  var body: Self.Content { get }
}

/// A stylesheet consists of style rules and at-rules.
public protocol Stylesheet {
  associatedtype Content: QualifiedRule

  var body: Self.Content { get }
}
