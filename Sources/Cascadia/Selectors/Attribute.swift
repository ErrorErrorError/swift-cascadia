/// e.g.: [class='test']
public struct Attribute<Content: Statement>: Selector {
  public let name: String
  public let modifier: Modifier?
  public let value: String?
  public let content: Content

  public init(
    _ name: String, 
    @StatementBuilder content: () -> Content
  ) {
    self.name = name
    self.modifier = nil
    self.value = nil
    self.content = content()
  }

  public init(
    _ name: String, 
    match modifier: Modifier, 
    value: String,
    caseSensitive: Bool? = nil,
    @StatementBuilder content: () -> Content
  ) {
    self.name = name
    self.modifier = modifier
    self.value = value
    self.content = content()
  }

  public struct Modifier {
    public let token: String

    public init(_ token: String) {
      self.token = token
    }

    /// Selects elements where the attribute value exactly matches the given value.
    public static var exact: Self { Self("") }

    /// Selects elements where the attribute value starts with the specified substring.
    public static var starts: Self { Self("^") }
    
    /// Selects elements where the attribute value ends with the specified substring.
    public static var ends: Self { Self("$") }

    /// Selects elements where the attribute value contains the specified text.
    public static var text: Self { Self("*") }

    /// Selects elements where the attribute value contains the specified word (in a list separated by spaces).
    public static var word: Self { Self("~") }

    /// Selects elements where the attribute value can begin with the specified value immediately followed by a hyphen.
    public static var hyphen: Self { Self("|") }
  }
}
