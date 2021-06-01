//
//  UITapGestureRecognizerExtension.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//

import UIKit

extension UITapGestureRecognizer {
  func didTapAttributedTextInLabel(inRange targetRange: NSRange) -> Bool {
    // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
    guard let label = view as? UILabel,
      let attributedText = label.attributedText else { return false }
    let labelSize = label.bounds.size
    
    // Configure textContainer
    let textContainer = NSTextContainer(size: labelSize)
    textContainer.lineFragmentPadding = 0.0
    textContainer.lineBreakMode = label.lineBreakMode
    textContainer.maximumNumberOfLines = label.numberOfLines
    textContainer.size = labelSize
    
    // Add text container to layout manager
    let layoutManager = NSLayoutManager()
    layoutManager.addTextContainer(textContainer)
    
    // Configure layoutManager and textStorage
    let textStorage = NSTextStorage(attributedString: attributedText)
    textStorage.addLayoutManager(layoutManager)
    
    // Find the tapped character location and compare it to the specified range
    let locationOfTouchInLabel = self.location(in: label)
    let textBoundingBox = layoutManager.usedRect(for: textContainer)
    
    // Calculate alignment offset based on text alignment
    let alignmentOffset: CGFloat
    switch label.textAlignment {
    case .left, .natural, .justified:
      alignmentOffset = 0.0
    case .center:
      alignmentOffset = 0.5
    case .right:
      alignmentOffset = 1.0
    @unknown default:
      fatalError("Unhandled alignment")
    }
    
    // Finding touch point in text container
    let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * alignmentOffset - textBoundingBox.origin.x,
                                      y: (labelSize.height - textBoundingBox.size.height) * alignmentOffset - textBoundingBox.origin.y)
    let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                 y: locationOfTouchInLabel.y - textContainerOffset.y)
    let indexOfCharacter = layoutManager
      .characterIndex(
        for: locationOfTouchInTextContainer,
        in: textContainer,
        fractionOfDistanceBetweenInsertionPoints: nil
    )
    
    return NSLocationInRange(indexOfCharacter, targetRange)
  }
}
