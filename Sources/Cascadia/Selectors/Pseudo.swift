public struct Pseudo: Selector, Sendable {
  public let value: Value

  /// e.g.: :active
  public init(class value: Class) {
    self.value = .class(value)
  }

  /// e.g.: ::after
  public init(element value: Element) {
    self.value = .element(value)
  }

  public init(_ value: Value) {
    self.value = value
  }

  public enum Value: Equatable, Sendable {
    case `class`(Class)
    case element(Element)
  }

  @inlinable @inline(__always)
  public static func render(
    _ selector: consuming Self,
    into renderer: consuming Renderer.SelectorRenderer
  ) {
    renderer.add(0x3A)  // :
    let (requiresColon, identifier, value) = switch selector.value {
    case let .class(pseudo): (false, pseudo.identifier, pseudo.value)
    case let .element(pseudo): (true, pseudo.identifier, pseudo.value)
    }
    if requiresColon {
      renderer.add(0x3A)  // :
    }
    renderer.add(identifier) // identifier
    if let value {
      renderer.add(0x28)  // (
      renderer.add(value) // value
      renderer.add(0x29)  // )
    }
  }
}

public extension Selector where Self == Pseudo {
  static var pseudo: Pseudo.Type { Pseudo.self }
}

extension Selector {
  func pseudo(_ value: Pseudo.Value) -> some Selector {
    chain(Pseudo(value))
  }
}

public extension Pseudo {
  struct Class: Equatable, Sendable, ExpressibleByStringLiteral {
    public let identifier: String
    public let value: String?

    public init(_ identifier: String, value: String? = nil) {
      self.identifier = switch identifier.first {
      case ":": String(identifier.dropFirst())
      default: identifier
      }
      self.value = value
    }

    public init(_ identifier: String, values: [String], separator: String = ", ") {
      self.init(
        identifier,
        value: values.joined(separator: separator)
      )
    }

    public init(stringLiteral identifier: StringLiteralType) {
      self.init(identifier)
    }

    public static var active: Self { #function }

    public static var anyLink: Self { "any-link" }

    public static var autofill: Self { #function }

    public static var blank: Self { #function }

    public static var checked: Self { #function }

    public static var current: Self { #function }

    public static var `default`: Self { #function }

    public static var defined: Self { #function }

    public static func dir(rtl: Bool) -> Self {
      Self("dir", value: rtl ? "rtl" : "ltr")
    }

    public static var disabled: Self { #function }

    public static var empty: Self { #function }

    public static var enabled: Self { #function }

    public static var first: Self { #function }

    public static var firstChild: Self { "first-child" }

    public static var firstOfType: Self { "first-of-type" }

    public static var focus: Self { #function }

    public static var focusVisible: Self { "focus-visible" }

    public static var focusWithin: Self { "focus-within" }

    public static var fullscreen: Self { #function }

    public static var future: Self { #function }

    public static func has<S: Selector>(_ selector: S) -> Self {
      // TODO: Restrict to combinators
      Self("has", value: selector.render())
    }

    public static var host: Self { #function }

    public static var hover: Self { #function }

    public static var indeterminate: Self { #function }

    public static var inRange: Self { "in-range" }

    public static var invalid: Self { #function }

    public static func `is`<each S: Selector>(_: repeat each S) -> Self {
      // TODO: Render each selector as a SelectorList
      Self("is", value: "")
    }

    public static func lang(_ language: String, _ languages: String...) -> Self {
      Self("lang", values: [language] + languages, separator: ", ")
    }

    public static var lastChild: Self { "last-child" }

    public static var lastOfType: Self { "last-of-type" }

    public static var left: Self { #function }

    public static var link: Self { #function }

    public static var localLink: Self { "local-link" }

    public static var modal: Self { #function }

    public static func not<each S: Selector>(_: repeat each S) -> Self {
      // TODO: Parse each selector and concadinate as comma-separated list
      Self("not", value: "")
    }

    public static func nthChild(_ index: String) -> Self {
      Self("nth-child", value: index.description)
    }

    public static func nthLastChild(_ index: String) -> Self {
      Self("nth-last-child", value: index.description)
    }

    public static func nthLastOfType(_ index: String) -> Self {
      Self("nth-last-of-type", value: index.description)
    }

    public static func nthOfType(_ index: String) -> Self {
      Self("nth-of-type", value: index.description)
    }

    public static var onlyChild: Self { "only-child" }

    public static var onlyOfType: Self { "only-of-type" }

    public static var optional: Self { #function }

    public static var outOfRange: Self { "out-of-range" }

    public static var past: Self { #function }

    public static var paused: Self { #function }

    public static var pictureInPicture: Self { "picture-in-picture" }

    public static var placeholderShown: Self { "placeholder-shown" }

    public static var playing: Self { "playing" }

    public static var popoverOpen: Self { "popover-open" }

    public static var readOnly: Self { "read-only" }

    public static var readWrite: Self { "read-write" }

    public static var required: Self { #function }

    public static var right: Self { #function }

    public static var root: Self { #function }

    public static var scope: Self { #function }

    /// The ``Pseudo/Class/state()`` CSS pseudo-class matches custom elements that have the specified custom state.
    public static func state(_ identifier: String) -> Self {
      Self("state", value: identifier)
    }

    /// The ``Pseudo/Class/target`` CSS pseudo-class represents a unique element (the target element) with an id matching the URL's fragment.
    public static var target: Self { #function }

    public static var targetWithin: Self { "target-within" }

    public static var userInvalid: Self { "user-invalid" }

    public static var valid: Self { #function }

    public static var visited: Self { #function }

    /// The ``Pseudo/Class/where()`` CSS pseudo-class function takes a selector list as its argument, and selects any element that can be selected by one of the selectors in that list.
    public static func `where`<each S: Selector>(_: repeat each S) -> Self {
      // TODO: Parse each selector and concadinate as comma-separated list
      Self("where", value: "")
    }
  }
}

public extension Pseudo {
  struct Element: Equatable, Sendable, ExpressibleByStringLiteral {
    public let identifier: String
    public let value: String?

    public init(_ identifier: String, value: String? = nil) {
      self.identifier = identifier.hasPrefix("::") ? String(identifier.dropFirst(2)) : identifier
      self.value = value
    }

    public init(_ identifier: String, values: [String], separator: String = ", ") {
      self.init(identifier, value: values.joined(separator: separator))
    }

    public init(stringLiteral identifier: StringLiteralType) {
      self.init(identifier)
    }

    public static var after: Self { #function }

    public static var backdrop: Self { #function }

    public static var before: Self { #function }

    public static var cue: Self { #function }

    public static func cue<S: Selector>(_ selector: S) -> Self {
      Self(cue.identifier, value: selector.render())
    }

    public static var fileSelectorButton: Self { "file-selector-button" }

    public static var firstLetter: Self { "first-letter" }

    public static var firstLine: Self { "first-line" }

    public static func highlight(_ name: String) -> Self {
      Self("highlight", value: name)
    }

    public static var marker: Self { #function }

    public static func part(_ names: String...) -> Self {
      Self("part", values: names, separator: " ")
    }

    public static var placeholder: Self { #function }

    public static var selection: Self { #function }

    public static func slotted<S: Selector>(_ selector: S) -> Self {
      Self("slotted", value: selector.render())
    }

    public static var spellingError: Self { "spelling-error" }

    public static var targetText: Self { "target-text" }

    public static var viewTransition: Self { "view-transition" }

    public static func viewTransitionImagePair(_ identifier: String) -> Self {
      Self("view-transition-image-pair", value: identifier)
    }

    public static func viewTransitionGroup(_ identifier: String) -> Self {
      Self("view-transition-group", value: identifier)
    }

    public static func viewTransitionNew(_ identifier: String) -> Self {
      Self("view-transition-new", value: identifier)
    }

    public static func viewTransitionOld(_ identifier: String) -> Self {
      Self("view-transition-old", value: identifier)
    }
  }
}
