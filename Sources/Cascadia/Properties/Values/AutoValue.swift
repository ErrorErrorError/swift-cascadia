public protocol AutoValue: RawValue {}

extension AutoValue {
  public static var auto: Self { #function }
}