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

  public var identifier: String { ID.identifier }
  public var rawValue: String
  public var isImportant = false

  @_spi(Core)
  @inlinable @inline(__always)
  public var body: Never {
    neverBody(Self.self)
  }

  @inlinable @inline(__always)
  public init(stringLiteral value: StringLiteralType) {
    self.rawValue = value
  }

  @inlinable @inline(__always)
  public init(function name: String, value: String) {
    self.rawValue = "\(name)(\(value))"
  }

  @inlinable @inline(__always)
  public init(_ value: String) {
    self.rawValue = value
  }

  @inlinable @inline(__always)
  public init(_ value: Self) {
    self = value
  }

  @inlinable @inline(__always)
  public consuming func important() -> Self {
    self.isImportant = true
    return self
  }
}

extension Declaration {
  func render() -> String {
    var writer = _TextBufferWriter()
    var renderer = Renderer(&writer, config: .init())
    renderer.declaration(self.identifier, value: self.rawValue, important: self.isImportant)
    return writer.finish()
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
