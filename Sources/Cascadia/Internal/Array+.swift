extension Sequence where Element == String? {
  func joined(separator: String) -> String {
    self.compactMap { $0 }.joined(separator: separator)
  }
}