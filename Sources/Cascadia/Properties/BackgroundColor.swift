extension CSSProperty { 
  public enum BackgroundColor: Property, ColorRepresentable {
    public static let identifier = "background-color"
  }
}

public typealias BackgroundColor = CSSProperty.BackgroundColor.Value