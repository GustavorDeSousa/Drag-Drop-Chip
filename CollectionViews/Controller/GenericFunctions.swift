
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
        let elementInLine = (arr.count/lines) - 1
        var arrModificated : [String] = []
        
        var typeLine = "A"
        var arrA : [String] = []
        var sizeA = 0.0

        var arrB : [String] = []
        var sizeB = 0.0

        var arrC : [String] = []
        var sizeC = 0.0
        
        for i in arr {
            arrModificated.append(i)
        }

        for _ in 0 ..< lines {
            for (index, element) in arrModificated.enumerated() {
                if typeLine == "A" {
                    if index <= elementInLine {
                        arrA.append(element)
                        arrModificated.remove(at: index)
                        if index == elementInLine {
                            typeLine = "B"
                        }
                    }
                } else if typeLine == "B" {
                    if index <= elementInLine {
                        arrB.append(element)
                        arrModificated.remove(at: index)
                        if index == elementInLine {
                            typeLine = "C"
                        }
                    }
                } else {
                    if index <= elementInLine {
                        arrC.append(element)
                    }
                }
            }
        }

        for i in arrA {
            sizeA += GenericFunctions.calculateCellSize(word: i)
        }
        
        for i in arrB {
            sizeB += GenericFunctions.calculateCellSize(word: i)
        }
        
        for i in arrC {
            sizeC += GenericFunctions.calculateCellSize(word: i)
        }
        
        if sizeA >= sizeB {
            if sizeA >= sizeC {
                return sizeA
            } else {
                return sizeC
            }
        } else {
            if sizeB >= sizeC{
                return sizeB
            } else {
                return sizeC
            }
        }
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
