//
//  TesteCollectionViewCell.swift
//  CollectionViews
//
//  Created by Gustavo De Sousa on 29/09/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import UIKit

class TesteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbTitle.layer.cornerRadius = lbTitle.frame.height / 4
        lbTitle.clipsToBounds = true
    }

}
