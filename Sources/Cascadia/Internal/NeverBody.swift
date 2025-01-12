func neverBody<T>(_ type: T.Type) -> Never {
  fatalError("'body' cannot be called on \(type)")
}
