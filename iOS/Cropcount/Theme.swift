import SwiftUI

/// garden leaf green with linen cream
enum Theme {
    static let accent = Color(red: 0.3451, green: 0.5059, blue: 0.3412)
    static let accentSecondary = Color(red: 0.8549, green: 0.8431, blue: 0.8039)
    static let background = Color(red: 0.0706, green: 0.0863, blue: 0.0588)
    static let cardBackground = background.opacity(0.6)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
