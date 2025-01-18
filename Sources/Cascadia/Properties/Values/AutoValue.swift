public protocol AutoValue {}

extension Property where Self: AutoValue {
  public static var auto: Self { Self(#function) }
}