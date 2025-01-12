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

  public struct Value: ExpressibleByStringLiteral {
    public let rawValue: String

    public init(stringLiteral value: String) {
      self.rawValue = value
    }

    public init(_ value: String) {
      self.rawValue = value
    }

    public static func `function`(
      _ name: consuming String, 
      value: consuming Self
    ) -> Self {
      Self("\(name)(\(value.rawValue))")
    }

    public static func quoted(_ value: consuming String) -> Self {
      Self("\"\(value)\"")
    }
  }

  public static func render(
    _ statement: consuming Self, 
    into renderer: consuming Renderer
  ) {
    switch statement.storage {
      case .statement(let value):
        return renderer.statement(
          ID.identifier, 
          value: value.rawValue,
          use: true
        )
      case .block(.some(let value), let content):
        renderer.block(
          ID.identifier, 
          value: value.rawValue,
          use: true
        ) { block in

        }
      default:
        break
    }
  }
}

extension AtRule where Content == Never {
  init(value: Value) {
    self.storage = .statement(value)
  }
}

extension AtRule where Content: Rule {
  init(value: Value? = nil, content: Content) {
    self.storage = .block(value, content)
  }
}

extension AtRule: RuleChild where Content: RuleChild {}

public typealias StatementAtRule<ID: AtRuleIdentifier> = AtRule<ID, Never>