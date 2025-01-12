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

  public var body: some Rule {
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

  public static func _render(
    _ statement: consuming Self,
    into renderer: consuming Renderer
  ) {
    switch statement.storage {
    case let .statement(value):
      return renderer.statement(
        ID.identifier,
        value: value.rawValue,
        use: true
      )
    case let .block(.some(value), content):
      renderer.block(
        ID.identifier,
        value: value.rawValue,
        use: true
      ) { _ in
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
