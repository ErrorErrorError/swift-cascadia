/// A namespace for all property identifiers
public enum CSSProperty {}

/// An identifier that defines which feature is considered for a given property
public protocol Property {
  typealias Value = Declaration<Self>
  static var identifier: String { get }
}

/// A property-value pair
public struct Declaration<ID: Property>: Equatable, ExpressibleByStringLiteral {
  public typealias ID = ID

  public var rawValue: String
  public var isImportant = false

  @inlinable
  public init(stringLiteral value: StringLiteralType) {
    self.rawValue = value
  }

  @inlinable
  public init(function name: String, value: String) {
    self.rawValue = "\(name)(\(value))"
  }

  @inlinable
  public init(_ value: String) {
    self.rawValue = value
  }

  public init(_ value: Self) {
    self = value
  }

  @inlinable @inline(__always)
  public static func render(
    _ declaration: consuming Self,
    into renderer: inout DeclarationRenderer
  ) {
    renderer.appendToken(.pair(ID.identifier, declaration.rawValue))
  }

  public consuming func important() -> Self {
    self.isImportant = true
    return self
  }

  public consuming func render() -> String {
    var renderer = DeclarationRenderer()
    Self.render(self, into: &renderer)
    return renderer.collect()
  }
}

public struct DeclarationRenderer {
  private var result: [UInt8] = []

  init() {
    result.reserveCapacity(1024)
  }

  public mutating func appendToken(_ token: consuming Token) {
    switch token {
      case .pair(let identifier, let value):
        result.append(contentsOf: identifier.utf8)
        result.append(0x3A) // :
        result.append(0x20) // spacer
        result.append(contentsOf: value.utf8)
        result.append(0x3B) // ;
    }
  }

  public consuming func collect() -> String {
    String(decoding: result, as: UTF8.self)
  }

  public enum Token {
    case pair(String, String)
  }
}

/// Global property values
public extension Declaration {
  static var inherit: Self { #function }
  static var initial: Self { #function }
  static var revert: Self { #function }
  static var revertLayer: Self { "revert-layer" }
  static var unset: Self { #function }
}
