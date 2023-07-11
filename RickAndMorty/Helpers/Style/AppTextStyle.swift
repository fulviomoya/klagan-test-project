//
//  AppTextStyle.swift
//  RickAndMorty
//

import UIKit

public class AppTextStyle {
    
    private let isHeadline: Bool
    private let isBold: Bool
    private let isItalic: Bool
    private let fontSize: CGFloat

    lazy var bold: AppTextStyle = {
        return AppTextStyle(
            isHeadline: self.isHeadline,
            isBold: true,
            isItalic: self.isItalic,
            fontSize: self.fontSize)
    }()

    lazy var italic: AppTextStyle = {
        return AppTextStyle(
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

public extension AppTextStyle {
    static let lg = AppTextStyle(isHeadline: false, fontSize: 18)
    static let md = AppTextStyle(isHeadline: false, fontSize: 16)
    static let sm = AppTextStyle(isHeadline: false, fontSize: 14)
    static let xs = AppTextStyle(isHeadline: false, fontSize: 12)
}
