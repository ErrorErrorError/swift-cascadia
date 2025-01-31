public struct Display: PrimitiveProperty {
  public static let identifier = "display"
  public let value: Value

  public init(_ value: Value) {
    self.value = value
  }

  public init(_ outside: Value.DisplayOutside) {
    self.value = Value(outside.rawValue)
  }

  public init(_ outside: Value.DisplayOutside, _ inside: Value.DisplayInside) {
    self.value = outside.joined(with: inside, separator: " ")
  }

  public init(_ inside: Value.DisplayInside) {
    self.value = Value(inside.rawValue)
  }
}

public extension Display {
  struct Value: Sendable, RawValue {
    public let rawValue: String

    public init(_ value: String) {
      self.rawValue = value
    }

    // <display-outside>
    public struct DisplayOutside: Sendable, RawValue {
      public let rawValue: String

      public init(_ value: String) {
        self.rawValue = value
      }

      public static var block: Self { #function }
      public static var inline: Self { #function }
      public static var runIn: Self { "run-in" }
    }

    // <display-inside>
    public struct DisplayInside: Sendable, RawValue {
      public let rawValue: String

      public init(_ value: String) {
        self.rawValue = value
      }

      public static var flow: Self { #function }
      public static var flowRoot: Self { "flow-root" }
      public static var table: Self { #function }
      public static var flex: Self { #function }
      public static var grid: Self { #function }
      public static var ruby: Self { #function }
    }

    // <display-listitem>
    public struct ListItem: Sendable, RawValue {
      public let rawValue: String

      public init(_ value: String) {
        self.rawValue = value
      }

      public static let listItem: Self = "list-item"
    }

    // <display-internal>
    public static var tableRowGroup: Self { "table-row-group" }
    public static var tableHeaderGroup: Self { "table-header-group" }
    public static var tableFooterGroup: Self { "table-footer-group" }
    public static var tableRow: Self { "table-row" }
    public static var tableCell: Self { "table-cell" }
    public static var tableColumnGroup: Self { "table-column-group" }
    public static var tableColumn: Self { "table-column" }
    public static var tableCaption: Self { "table-caption" }
    public static var rubyBase: Self { "ruby-base" }
    public static var rubyText: Self { "ruby-text" }
    public static var rubyBaseContainer: Self { "ruby-base-container" }
    public static var rubyTextContainer: Self { "ruby-text-container" }

    // <display-box>
    public static var contents: Self { #function }
    public static var none: Self { #function }

    // <display-legacy>
    public static var inlineBlock: Self { "inline-block" }
    public static var inlineTable: Self { "inline-table" }
    public static var inlineFlex: Self { "inline-flex" }
    public static var inlineGrid: Self { "inline-grid" }

    // <display-outside> || [ <display-inside> | math ]
  }
}
