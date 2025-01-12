extension CSSAtRules {
  public enum Namespace: AtRuleIdentifier {
    public static let identifier = "namespace"
  }
}

public typealias Namespace = AtRule<CSSAtRules.Namespace, Never>

extension Namespace {
  public init(prefix: String? = nil, _ value: Import.URLValue) {
    self.init(value: Value([prefix, value.value.rawValue].compactMap { $0 }.joined(separator: " ")))
  }
}