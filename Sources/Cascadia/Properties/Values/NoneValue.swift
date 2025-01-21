public protocol NoneValue: RawValue {}

extension NoneValue {
  public static var none: Self { #function }
}