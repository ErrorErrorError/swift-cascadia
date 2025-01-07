/// An identifier that defines which feature is considered for a given property
public protocol Property: CSS where Body == Never {
  typealias Value = PropertyValue<Self>
  static var identifier: String { get }
  var value: Value { get }
}

public struct PropertyValue<P: Property>: ExpressibleByStringLiteral {
  public let rawValue: String

  @inlinable
  public init(stringLiteral value: StringLiteralType) {
    rawValue = value
  }

  @usableFromInline
  init(_ value: String) {
    rawValue = value
  }
}

/// Global property values
public extension PropertyValue {
  static var inherit: Self { #function }
  static var initial: Self { #function }
  static var revert: Self { #function }
  static var revertLayer: Self { "revert-layer" }
  static var unset: Self { #function }
}
