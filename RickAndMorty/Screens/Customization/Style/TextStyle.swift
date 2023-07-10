//
//  TextStyle.swift
//  RickAndMorty
//

import UIKit

public class TextStyle {
    
    private let isHeadline: Bool
    private let isBold: Bool
    private let isItalic: Bool
    private let fontSize: CGFloat

    lazy var bold: TextStyle = {
        return TextStyle(
            isHeadline: self.isHeadline,
            isBold: true,
            isItalic: self.isItalic,
            fontSize: self.fontSize)
    }()

    lazy var italic: TextStyle = {
        return TextStyle(
            isHeadline: self.isHeadline,
            isBold: self.isBold,
            isItalic: true,
            fontSize: self.fontSize)
    }()

    lazy var font: UIFont = {
        let textStyle: UIFont.TextStyle = isHeadline ? .headline : .body
        var fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)

        if isBold {
            fontDescriptor = fontDescriptor.withSymbolicTraits(.traitBold) ?? fontDescriptor
        }
        if isItalic {
            fontDescriptor = fontDescriptor.withSymbolicTraits(.traitItalic) ?? fontDescriptor
        }
        return UIFont(descriptor: fontDescriptor, size: fontSize)
    }()

    private init(isHeadline: Bool = false,
                 isBold: Bool = false,
                 isItalic: Bool = false,
                 fontSize:CGFloat) {
        self.isHeadline = isHeadline
        self.isBold = isBold
        self.isItalic = isItalic
        self.fontSize = fontSize
    }

}

public extension TextStyle {
    static let lg = TextStyle(isHeadline: false, fontSize: 18)
    static let md = TextStyle(isHeadline: false, fontSize: 16)
    static let sm = TextStyle(isHeadline: false, fontSize: 14)
    static let xs = TextStyle(isHeadline: false, fontSize: 12)
}
