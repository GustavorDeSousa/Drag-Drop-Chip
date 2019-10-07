
//
//  GenericFunctions.swift
//  CollectionViews
//
//  Created by Gustavo De Sousa on 04/10/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import Foundation
import UIKit

struct GenericFunctions {
    static func calculateCellSize(word: String) -> Double {
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17.0)]
        let stringSize = word.size(withAttributes: attrs)
        return Double(stringSize.width + 30.0)
    }
    
    //Retorna o tamanho de todas as string e dividi para a quantidade de linhas informadas
    static func arrSize(lines: Int, arr: [String]) -> Double {
        var size = 0.0
        for i in arr {
            size += GenericFunctions.calculateCellSize(word: i)
        }
        size = size / Double(lines)
        return size
    }
}


//TROCAR PARA EXTENSION
extension Array {
    func calculateStringWordCount(for lines: Int) -> Int {
        var size = 0
        for i in self {
            if let i = i as? String {
                size += Int(GenericFunctions.calculateCellSize(word: i))
            }
        }
        size = size / lines
        return size
    }
}
