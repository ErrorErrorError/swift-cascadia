/// A property-value pair
/// Also defines which feature is considered for a given property
public protocol Property: Sendable, Block where Body == Never {
  typealias Value = PropertyValue<Self>
  static var identifier: String { get }
  var value: Value { get }

  init(_ rawValue: Value)
}

public struct PropertyValue<P: Property>: Sendable, ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
  public let rawValue: String

  public init(stringLiteral value: StringLiteralType) {
    self.rawValue = value
  }

  public init(_ rawValue: String) {
    self.rawValue = rawValue
  }
}

extension Property {
  public consuming func important() -> Important<Self> {
    Important(self)
  }

  @_spi(Core)
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(Renderer)
  public static func _render<Writer: CSSStreamWriter>(
    _ value: consuming Self, 
    into renderer: inout Renderer<Writer>
  ) {
    renderer.declaration(
      Self.identifier,
      value: value.value.rawValue, 
      important: false
    )
  }
}

public struct Important<D: Property>: Block {
  let declaration: D

  init(_ declaration: D) {
    self.declaration = declaration
  }

  @_spi(Core)
  public var body: Never {
    neverBody(Self.self)
  }

  @_spi(Renderer)
  public static func _render<Writer: CSSStreamWriter>(
    _ value: consuming Important<D>, 
    into renderer: inout Renderer<Writer>
  ) {
    renderer.declaration(
      D.identifier, 
      value: value.declaration.value.rawValue, 
      important: true
    )
  }
}

/// The value of a property
// public struct PropertyValue<ID: Property>: Sendable, Equatable, ExpressibleByStringLiteral {
//   public var rawValue: String

//   @inlinable @inline(__always)
//   public init(stringLiteral value: StringLiteralType) {
//     self.rawValue = value
//   }

//   init(_ value: String) {
//     self.init(stringLiteral: value)
//   }
// }

/// Global property values
public extension PropertyValue {

  /// Represents the value specified as the property's initial value.
  static var initial: Self { #function }

  /// Represents the computed value of the property on the element's parent, provided it is inherited.
  static var inherit: Self { #function }

  /// Resets the property to its inherited value if it inherits from its parent or to the default value established by the user agent's stylesheet (or by user styles, if any exist).
  static var revert: Self { #function }

  /// Rolls back the value of a property in a cascade layer to the value of the property in a CSS rule matching the element in a previous cascade layer.
  static var revertLayer: Self { "revert-layer" }

  /// Acts as either inherit or initial, depending on whether the property is inherited or not.
  static var unset: Self { #function }
}