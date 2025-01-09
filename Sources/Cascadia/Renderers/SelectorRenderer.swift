struct SelectorRenderer: _SelectorRendering {
  private var result: [UInt8] = []

  init() {
    result.reserveCapacity(1024)
  }

  mutating func appendBytes<S: Sequence>(_ bytes: S) where S.Element == UInt8 {
    result.append(contentsOf: bytes)
  }

  consuming func collect() -> String {
    String(decoding: result, as: Unicode.UTF8.self)
  }
}
