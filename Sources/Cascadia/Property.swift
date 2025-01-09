/// An identifier that defines which feature is considered for a given property
public protocol Property {
  typealias Value = PropertyValue<Self>
  static var identifier: String { get }
  var value: Value { get }

  static func render<Renderer: _PropertyRendering>(_ property: consuming Self, into render: inout Renderer)
}

public protocol _PropertyRendering {}

extension Property {
  public static func render<Renderer: _PropertyRendering>(
    _ property: consuming Self, 
    into render: inout Renderer
  ) {
  }
}

public struct PropertyValue<P: Property>: Equatable, ExpressibleByStringLiteral {
  public var rawValue: String

  @inlinable
  public init(stringLiteral value: StringLiteralType) {
    rawValue = value
  }

  @inlinable
  public init(_ value: String) {
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
