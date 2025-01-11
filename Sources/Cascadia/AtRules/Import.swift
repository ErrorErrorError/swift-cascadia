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
    /// TODO: Add Rule builder
    let urlRule: Self.Value = switch url {
    case .string(let value): .quoted(value)
    case .url(let url): .function("url", value: .quoted(url))
    }
    self.init(urlRule)
  }

  public enum URLValue: ExpressibleByStringLiteral {
    case string(String)
    case url(String)

    public init(stringLiteral value: StringLiteralType) {
      self = .string(value)
    }
  }
}