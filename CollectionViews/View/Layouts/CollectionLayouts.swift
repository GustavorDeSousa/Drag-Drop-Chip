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
    var lines: CGFloat = 0
    var arr: [String] = []
  
    override init() {
        super.init()
    }
    
    init(qtyLines : CGFloat, arr: [String], direction : UICollectionView.ScrollDirection = .horizontal) {
        super.init()
        self.lines = qtyLines
        self.arr = arr
        self.scrollDirection = direction
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        self.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        var leftMargin = sectionInset.left
        var posY = sectionInset.top
        
        attributes?.forEach({ (chip) in
            chip.frame.origin.y = posY
            chip.frame.origin.x = leftMargin

            leftMargin += chip.frame.width
            if leftMargin >= CGFloat(GenericFunctions.arrSize(lines: Int(self.lines), arr: arr)) {
                posY += chip.frame.height
                leftMargin = sectionInset.left
            }
        })
        return attributes
    }
}
