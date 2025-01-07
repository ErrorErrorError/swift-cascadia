/// The building block of a css selector, property, and a declaration block
public protocol CSS {
  associatedtype Body: CSS

  @CSSBuilder
  var body: Self.Body  { get }
}

public struct EmptyCSS: CSS, Statement {
  @inlinable
  public init() {}
}

extension Never: CSS {
  public typealias Content = Never
  public var body: some CSS { self }
}

public extension CSS where Body == Never {
  var body: Body {
    fatalError("Cannot call `\(Self.self).body` directly")
  }
}