struct SelectorRenderer: _SelectorRendering {
  private var result: [UInt8] = []

  init() {
    result.reserveCapacity(1024)
  }
  
  mutating func appendTokens(_ tokens: SelectorToken...) {
    for token in tokens {
      switch token {
        // TODO: If minified, omit white spaces if possible
      case .whitespace(canOmit: let canOmit): result.append(0x20)
      case .newline: break
      case .bytes(let bytes): result.append(contentsOf: bytes)
      }
    }
  }

  // mutating func appendBytes<S: Sequence>(_ bytes: S) where S.Element == UInt8 {
  //   result.append(contentsOf: bytes)
  // }

  consuming func collect() -> String {
    String(decoding: result, as: Unicode.UTF8.self)
  }
}