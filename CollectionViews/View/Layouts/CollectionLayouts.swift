//
//  CollectionLayouts.swift
//  CollectionViews
//
//  Created by Gustavo De Sousa on 04/10/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import UIKit

// MARK: - LAYOUT COLLECTION
class CollectionViewHorizontal: UICollectionViewFlowLayout {
    //Quantity line in collectionView
    static let lines: CGFloat = 3
    //More space in collectionView
    let mult: CGFloat = 1.5
    
    override var collectionViewContentSize: CGSize {
        let defaultSize = super.collectionViewContentSize
        let characterInLine = GenericFunctions.arrSize(lines: Int(CollectionViewHorizontal.lines))
        return CGSize(width: CGFloat(characterInLine) * mult, height: defaultSize.height)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        self.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        var leftMargin = sectionInset.left
        var posY = sectionInset.top
        var count = 0
        
        attributes?.forEach({ (chip) in
            chip.frame.origin.y = posY
            chip.frame.origin.x = leftMargin

            leftMargin += chip.frame.width
            if leftMargin + chip.frame.width >= CGFloat(GenericFunctions.arrSize(lines: Int(CollectionViewHorizontal.lines))) * mult  {
                count += 1
                if count <= Int(CollectionViewHorizontal.lines) {
                    posY += chip.frame.height
                    leftMargin = sectionInset.left
                }
            }
        })
        return attributes
    }
}