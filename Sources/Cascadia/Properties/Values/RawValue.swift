public protocol RawValue: ExpressibleByStringLiteral where StringLiteralType == String {
  var rawValue: String { get }

  init(_ value: String)
}

extension RawValue {
  public init(stringLiteral value: String) {
    self.init(value)
  }

  func joined<each V: RawValue, S: RawValue>(with values: repeat each V, separator: String) -> S {
    var allValues = [self.rawValue]
    for value in repeat each values {
      allValues.append(value.rawValue)
    }
    return S(allValues.joined(separator: separator))
  }
}

extension Sequence where Element: RawValue {
  func joined<S: RawValue>(separator: String) -> S {
    S(self.map({ $0.rawValue }).joined(separator: separator))
  }
}

/// Global property values
public extension RawValue {

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