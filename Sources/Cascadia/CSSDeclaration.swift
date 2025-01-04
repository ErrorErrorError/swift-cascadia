/// A general key-value property
public protocol Declaration {
  associatedtype Value

  var value: Value { get }
}

public protocol Property: Declaration where Value == PropertyValue<Self> {
  static var name: String { get }
}

public struct PropertyValue<P: Property>: Sendable, ExpressibleByStringLiteral {
  let value: String

  public init(stringLiteral value: StringLiteralType) {
    self.init(value)
  }

  init(_ value: String) {
    self.value = value
  }
}

/// Default property values
public extension PropertyValue {
  static var inherit: Self { #function }
  static var initial: Self { #function }
}
