extension CSSAtRules {
  public enum Charset: AtRuleIdentifier {
    public static let identifier = "charset"
  }
}

public typealias Charset = AtRule<CSSAtRules.Charset, Never>

extension Charset {
  public init(_ encoding: Encoding) {
    self.init(value: .quoted(encoding.rawValue))
  }

  public enum Encoding: String, Hashable, Sendable {

    /// UTF-8
    case utf8 = "UTF-8"

    /// ISO 8559-15 (Latin-9)
    case isoLatin9 = "iso-8859-15"
  }
}