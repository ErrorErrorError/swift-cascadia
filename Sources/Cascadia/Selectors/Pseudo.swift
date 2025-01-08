public struct Pseudo<Content: Statement>: Selector {
  public let value: Value
  public let content: Content

  public init(class value: Class, @StatementBuilder content: () -> Content) {
    self.value = .class(value)
    self.content = content()
  }

  public init(element value: Element, @StatementBuilder content: () -> Content) {
    self.value = .element(value)
    self.content = content()
  }
}

extension Pseudo {
  public enum Value {
    case `class`(Class)
    case element(Element)
  }

  public struct Class: ExpressibleByStringLiteral {
    public let identifier: String
    public let value: String?

    public init(_ identifier: String) {
      self.identifier = identifier
      self.value = nil
    }

    public init(_ identifier: String, value: String) {
      self.identifier = identifier
      self.value = value
    }

    public init(stringLiteral identifier: StringLiteralType) {
      self.init(identifier)
    }
    
    public static var active: Self { #function }
    
    public static var checked: Self { #function }
    
    public static var `default`: Self { "default" }
    
    public static var disabled: Self { #function }
    
    public static var empty: Self { #function }
    
    public static var enabled: Self { #function }
    
    public static var firstChild: Self { "first-child" }
    
    public static var firstOfType: Self { "first-of-type" }
    
    public static var focus: Self { #function }
    
    public static var fullscreen: Self { #function }
    
    public static var hover: Self { #function }

    public static var inRange: Self { "in-range" }

    public static var invalid: Self { #function }

    public static func lang(_ lang: String) -> Self { 
      Self("lang", value: lang) 
    }
    
    public static var lastChild: Self { "last-child" }
    public static var lastOfType: Self { "last-of-type" }
    public static var link: Self { #function }

    public static func nthChild(_ index: Int) -> Self {
      Self("nth-child", value: index.description)
    }

    public static func nthLastChild(_ index: Int) -> Self { 
      Self("nth-last-child", value: index.description) 
    }

    public static func nthLastOfType(_ index: Int) -> Self { 
      Self("nth-last-of-type", value: index.description)
    }

    public static func nthOfType(_ index: Int) -> Self { 
      Self("nth-of-type", value: index.description) 
    }

    public static var onlyChild: Self { "only-child" }

    public static var onlyOfType: Self { "only-of-type" }

    public static var optional: Self { #function }

    public static var outOfRange: Self { "out-of-range" }

    public static var readOnly: Self { "read-only" }

    public static var readWrite: Self { "read-write" }

    public static var required: Self { #function }

    public static var root: Self { #function }

    public static var target: Self { #function }

    public static var valid: Self { #function }

    public static var visited: Self { #function }

    public static func not<S: Selector>(_ selector: S) -> Self {
      Self("not", value: "")
    }
  }

  public struct Element: ExpressibleByStringLiteral {
    public let identifier: String

    public init(stringLiteral value: StringLiteralType) {
      self.init(value)
    }

    private init(_ identifier: String) {
      self.identifier = identifier
    }

    public static var after: Self { #function }
    public static var before: Self { #function }
    public static var firstLetter: Self { "first-letter" }
    public static var firstSentence: Self { "first-sentence" }
    public static var selection: Self { #function }
  }
}
