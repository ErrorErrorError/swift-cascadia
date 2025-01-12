extension CSSAtRules {
  public enum Import: AtRuleIdentifier {
    public static let identifier = "import"
  }
}

public typealias Import = StatementAtRule<CSSAtRules.Import>

extension Import {
  public init(
    _ url: URLValue,
    layer: String? = nil,
    supports: String? = nil,
    queries: String? = nil
  ) {
    self.init(value: url.value)
  }

  public enum URLValue: ExpressibleByStringLiteral {
    case string(String)
    case url(String)
    case src(String)

    public init(stringLiteral value: StringLiteralType) {
      self = .string(value)
    }

    var value: Value {
      switch self {
      case .string(let value): .quoted(value)
      case .url(let url): .function("url", value: .quoted(url))
      case .src(let src): .function("src", value: .quoted(src))
      }
    }
  }
}