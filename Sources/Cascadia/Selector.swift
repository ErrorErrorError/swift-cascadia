/// A CSS selector
public protocol Selector {  
  static func render<Renderer: _SelectorRendering>(_ selector: consuming Self, into renderer: inout Renderer)
}

extension Selector {
  // public static func render<Renderer: _SelectorRendering>(
  //   _ selector: consuming Self, 
  //   into renderer: inout Renderer
  // ) async throws {
  // }

  public consuming func render() -> String {
    var renderer = SelectorRenderer()
    Self.render(self, into: &renderer)
    return renderer.collect()
  }
}

public protocol _SelectorRendering {
  mutating func appendBytes<S: Sequence>(_ bytes: S) where S.Element == UInt8
}

extension _SelectorRendering {
  public mutating func appendBytes(_ bytes: UInt8...) {
    self.appendBytes(bytes)
  }

  public mutating func addWhitespace(canOmit: Bool) {
    appendBytes(0x20) // whitepace
  }
}