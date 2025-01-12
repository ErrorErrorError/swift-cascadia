/// e.g.: div
public struct Element: Selector {
  public let element: HTMLTag

  public init(_ element: HTMLTag) {
    self.element = element
  }

  @inlinable @inline(__always)
  public static func _renderSelector(
    _ selector: consuming Self,
    into renderer: consuming Renderer.SelectorRenderer
  ) {
    renderer.add(selector.element.rawValue)  // element
  }
}

public extension Selector where Self == Element {
  static var element: Self.Type { Self.self }
}

public extension Element {
  struct HTMLTag: ExpressibleByStringLiteral {
    public var rawValue: String

    public init(stringLiteral value: String) {
      rawValue = value
    }

    public init(_ rawValue: String) {
      self.rawValue = rawValue
    }

    /// main root, sectioning root
    public static var html: Self { #function }
    public static var body: Self { #function }

    /// content sectioning
    public static var address: Self { #function }
    public static var article: Self { #function }
    public static var aside: Self { #function }
    public static var footer: Self { #function }
    public static var header: Self { #function }
    public static var h1: Self { #function }
    public static var h2: Self { #function }
    public static var h3: Self { #function }
    public static var h4: Self { #function }
    public static var h5: Self { #function }
    public static var h6: Self { #function }
    public static var main: Self { #function }
    public static var nav: Self { #function }
    public static var section: Self { #function }

    /// text content
    public static var blockquote: Self { #function }
    public static var dd: Self { #function }
    public static var div: Self { #function }
    public static var dl: Self { #function }
    public static var dt: Self { #function }
    public static var figcaption: Self { #function }
    public static var figure: Self { #function }
    public static var hr: Self { #function }
    public static var li: Self { #function }
    public static var ol: Self { #function }
    public static var p: Self { #function }
    public static var pre: Self { #function }
    public static var ul: Self { #function }

    /// inline text semantics
    public static var a: Self { #function }
    public static var abbr: Self { #function }
    public static var b: Self { #function }
    public static var bdi: Self { #function }
    public static var bdo: Self { #function }
    public static var br: Self { #function }
    public static var cite: Self { #function }
    public static var code: Self { #function }
    public static var data: Self { #function }
    public static var dfn: Self { #function }
    public static var em: Self { #function }
    public static var i: Self { #function }
    public static var kbd: Self { #function }
    public static var mark: Self { #function }
    public static var q: Self { #function }
    public static var ruby: Self { #function }
    public static var s: Self { #function }
    public static var samp: Self { #function }
    public static var small: Self { #function }
    public static var span: Self { #function }
    public static var strong: Self { #function }
    public static var sub: Self { #function }
    public static var sup: Self { #function }
    public static var time: Self { #function }
    public static var u: Self { #function }
    public static var `var`: Self { #function }
    public static var wbr: Self { #function }

    /// image and multi-media
    public static var area: Self { #function }
    public static var audio: Self { #function }
    public static var img: Self { #function }
    public static var map: Self { #function }
    public static var track: Self { #function }
    public static var video: Self { #function }

    /// embedded content
    public static var embed: Self { #function }
    public static var iframe: Self { #function }
    public static var object: Self { #function }
    public static var param: Self { #function }
    public static var picture: Self { #function }
    public static var portal: Self { #function }
    public static var source: Self { #function }

    /// svg and math
    public static var svg: Self { #function }
    public static var math: Self { #function }

    /// scripting
    public static var canvas: Self { #function }
    public static var noscript: Self { #function }
    public static var script: Self { #function }

    /// demarcating edits
    public static var del: Self { #function }
    public static var ins: Self { #function }

    /// table content
    public static var caption: Self { #function }
    public static var col: Self { #function }
    public static var colgroup: Self { #function }
    public static var table: Self { #function }
    public static var tbody: Self { #function }
    public static var td: Self { #function }
    public static var tfoot: Self { #function }
    public static var th: Self { #function }
    public static var thead: Self { #function }
    public static var tr: Self { #function }

    /// forms
    public static var button: Self { #function }
    public static var datalist: Self { #function }
    public static var fieldset: Self { #function }
    public static var form: Self { #function }
    public static var input: Self { #function }
    public static var label: Self { #function }
    public static var legend: Self { #function }
    public static var meter: Self { #function }
    public static var optgroup: Self { #function }
    public static var option: Self { #function }
    public static var output: Self { #function }
    public static var progress: Self { #function }
    public static var select: Self { #function }
    public static var textarea: Self { #function }

    /// interactive elements
    public static var details: Self { #function }
    public static var dialog: Self { #function }
    public static var menu: Self { #function }
    public static var summary: Self { #function }

    /// web components
    public static var slot: Self { #function }
    public static var template: Self { #function }
  }
}
