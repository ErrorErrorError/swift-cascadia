public enum CSSAtRules {}

public protocol AtRuleIdentifier {
  static var identifier: String { get }
}

public struct AtRule<ID: AtRuleIdentifier, Content: Rule>: Rule {
  private enum Storage {
    case statement(Value)
    case block(Value?, Content)
  }

  private let storage: Storage

  @_spi(Core)
  @inlinable @inline(__always)
  public var body: Never {
    neverBody(Self.self)
  }

  public struct Value: ExpressibleByStringLiteral {
    public let rawValue: String

    public init(stringLiteral value: String) {
      rawValue = value
    }

    public init(_ value: String) {
      rawValue = value
    }

    public static func function(
      _ name: consuming String,
      value: consuming Self
    ) -> Self {
      Self("\(name)(\(value.rawValue))")
    }

    public static func quoted(_ value: consuming String) -> Self {
      Self("\"\(value)\"")
    }
  }

  @_spi(Renderer)
  public static func _render<Writer: CSSStreamWriter>(
    _ statement: consuming Self,
    into renderer: inout Renderer<Writer>
  ) {
    switch statement.storage {
    case let .statement(value):
      return renderer.statement(
        atSymbol: true,
        ID.identifier,
        value: value.rawValue
      )
    case let .block(.some(value), content):
      renderer.block(
        atSymbol: true,
        ID.identifier,
        value: value.rawValue
      ) { renderer in
        // Content._render(content, into: renderer)
      }
    default:
      break
    }
  }
}

extension AtRule where Content == Never {
  init(value: Value) {
    storage = .statement(value)
  }
}

extension AtRule where Content: Rule {
  init(value: Value? = nil, content: Content) {
    storage = .block(value, content)
  }
}

public typealias StatementAtRule<ID: AtRuleIdentifier> = AtRule<ID, Never>
