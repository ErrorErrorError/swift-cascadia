public enum CSSAtRules {}

public protocol AtRuleID {
  static var identifier: String { get }
}

public protocol NestedAtRuleID: AtRuleID {}

public struct AtRule<ID: AtRuleID, Content>: Statement {
  private enum Storage {
    case statement(Rule)
    case block(Rule?, Content)
  }

  private let storage: Storage

  public struct Rule: ExpressibleByStringLiteral {
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

  public static func render<Renderer: _StatementRendering>(
    _ statement: consuming Self, 
    into renderer: inout Renderer
  ) async throws {
  }
}

extension AtRule where Content == Never {
  init(_ rule: Rule) {
    self.storage = .statement(rule)
  }
}

extension AtRule where Content: Statement {
  init(_ rule: Rule? = nil, _ content: Content) {
    self.storage = .block(rule, content)
  }
}

extension AtRule: NestedStatement where ID: NestedAtRuleID {}

public typealias StatementAtRule<ID: AtRuleID> = AtRule<ID, Never>