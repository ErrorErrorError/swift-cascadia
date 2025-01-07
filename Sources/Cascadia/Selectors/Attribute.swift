public struct Attribute: Selector {
  init(_ name: String) {}
  
  init(_ name: String, matches value: String, caseSensitive: Bool? = nil) {}

  init(_ name: String, contains value: String, caseSensitive: Bool? = nil) {}

  init(_ name: String, prefix value: String, caseSensitive: Bool? = nil) {}

  init(_ name: String, suffix value: String, caseSensitive: Bool? = nil) {}

  init(_ name: String, specificWord value: String, caseSensitive: Bool? = nil) {}

  init(_ name: String, exact value: String, caseSensitive: Bool? = nil) {}

  enum OperandToken: String {
    case exists = ""
    case matches = "="
    case contains = "*="
    case prefix = "^="
    case suffix = "$="
    case containsWord = "~="
    case exact = "!="
  }

  public var body: Never {
    fatalError()
  }
}
