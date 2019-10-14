
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
    
    static var testeA : Double = 0
    static var testeB : Double = 0
    
    //Retorna o tamanho de todas as string e dividi para a quantidade de linhas informadas
    static func arrSize(lines: Int, arr: [String]) -> Double {
        //Quantidade de elementos por linha e a linha em que esta inserindo, onde é utilizado para criar os arrays por linha
        let elementInLine = (arr.count/lines)
        var indexLine = 0
        
        //Arrays das linhas para verificar o maior tamanho
        var arrLineOne : [String] = []
        var sizeLineOne = 0.0

        var arrLineTwo : [String] = []
        var sizeLineTwo = 0.0

        var arrLineThree : [String] = []
        var sizeLineThree = 0.0

        //Percorrendo o array da lista original para conseguir calcular a maior linha
        for (index, element) in arr.enumerated() {
            if indexLine == 0 {
                if index + 1 <= elementInLine {
                    arrLineOne.append(element)
                    if index + 1 == elementInLine {
                        indexLine = 1
                    }
                }
            } else if indexLine == 1 {
                if index + 1 <= elementInLine * Int(CollectionLine.two) {
                    arrLineTwo.append(element)
                    if index + 1 == elementInLine * 2 {
                        indexLine = 2
                    }
                }
            } else {
                if index + 1 <= elementInLine * Int(CollectionLine.three) {
                    arrLineThree.append(element)
                }
            }
        }

        //Atualiza as variaveis de tamanho de cada linha
        if arrLineOne != [] {
            for i in arrLineOne {
                sizeLineOne += GenericFunctions.calculateCellSize(word: i)
            }
        }
        
        if arrLineTwo != [] {
            for (index, element) in arrLineTwo.enumerated() {
                if index == 0 {
                    testeA = GenericFunctions.calculateCellSize(word: element)
                }
                sizeLineTwo += GenericFunctions.calculateCellSize(word: element)
            }
        }
        
        if arrLineThree != [] {
            for (index, element) in arrLineThree.enumerated() {
                if index == 1 {
                    testeB = GenericFunctions.calculateCellSize(word: element)
                }
                sizeLineThree += GenericFunctions.calculateCellSize(word: element)
            }
        }

        //Retorna a linha com maior tamanho
        if sizeLineOne >= sizeLineTwo {
            if sizeLineOne >= sizeLineThree {
                return sizeLineOne
            } else {
                return sizeLineThree
            }
        } else {
            if sizeLineTwo >= sizeLineThree{
                return sizeLineTwo
            } else {
                return sizeLineThree
            }
        }
    }
}
