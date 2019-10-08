//
//  ExchangeTableViewCell.swift
//  CollectionViews
//
//  Created by Gustavo De Sousa on 04/10/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import UIKit

class ExchangeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,     UICollectionViewDragDelegate, UICollectionViewDropDelegate {

    @IBOutlet weak var collectionExchange: UICollectionView!
    @IBOutlet weak var lbTitleChip: UILabel!
    @IBOutlet weak var tbCellHeight: NSLayoutConstraint!
    
    var indexLine : Int?
//    var columnLayout = CollectionViewHorizontal()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Collection
        self.collectionExchange.delegate = self
        self.collectionExchange.dataSource = self
        
        self.collectionExchange.dragInteractionEnabled = true
        self.collectionExchange.dragDelegate = self
        
        self.collectionExchange.dropDelegate = self
        
        self.collectionExchange.contentInsetAdjustmentBehavior = .always
        
        self.collectionExchange.register(UINib(nibName: "ExchangeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExchangeCollectionViewCell")
    }
    
    
    //Simple Tap é para fazer um click simples na celula
    @objc func simpleTap(sender: UITapGestureRecognizer) {
        print("Click Simples")
    }
    
    //Long Pressed é para fazer um click longo na celula
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            print("Click Longo")
        }
    }
    
    // MARK: - FUNCS FACILITY YOUR LIFE
    //Função para remover o index da collection
    func removeIndex(at indexPath: IndexPath) {
        if self.tag == 0 {
            Mock.arrPessoal.remove(at: indexPath.row)
        } else if self.tag == 1 {
            Mock.indicadorMercado.remove(at: indexPath.row)
        } else if self.tag == 2 {
            Mock.classes.remove(at: indexPath.row)
        } else if self.tag == 3 {
            Mock.popular.remove(at: indexPath.row)
        } else {
            Mock.outros.remove(at: indexPath.row)
        }
    }
      
    //Função para adicionar o index na collection
    func insertIndex(array: String, at indexPath: IndexPath) {
        if self.tag == 0 {
            Mock.arrPessoal.insert(array, at: indexPath.row)
        } else if self.tag == 1 {
            Mock.indicadorMercado.insert(array, at: indexPath.row)
        } else if self.tag == 2 {
            Mock.classes.insert(array, at: indexPath.row)
        } else if self.tag == 3 {
            Mock.popular.insert(array, at: indexPath.row)
        } else {
            Mock.outros.insert(array, at: indexPath.row)
        }
    }

    // MARK: - Collection View
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.tag == 0 {
            return CGSize(width: GenericFunctions.calculateCellSize(word: Mock.arrPessoal[indexPath.row]), height: 40)
        } else if self.tag == 1 {
            return CGSize(width: GenericFunctions.calculateCellSize(word: Mock.indicadorMercado[indexPath.row]), height: 40)
        } else if self.tag == 2 {
            return CGSize(width: GenericFunctions.calculateCellSize(word: Mock.classes[indexPath.row]), height: 40)
        } else if self.tag == 3 {
            return CGSize(width: GenericFunctions.calculateCellSize(word: Mock.popular[indexPath.row]), height: 40)
        }  else {
            return CGSize(width: GenericFunctions.calculateCellSize(word: Mock.outros[indexPath.row]), height: 40)
        }
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.tag == 0 {
            return Mock.arrPessoal.count
        } else if self.tag == 1 {
            return Mock.indicadorMercado.count
        } else if self.tag == 2 {
            return Mock.classes.count
        } else if self.tag == 3 {
            return Mock.popular.count
        } else {
            return Mock.outros.count
        }
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeCollectionViewCell", for: indexPath) as! ExchangeCollectionViewCell
             
        if self.tag == 0 {
            if Mock.arrPessoal.count != 0 {
                cell.lbTitle.text = Mock.arrPessoal[indexPath.row]
            } else {
                return UICollectionViewCell()
            }
        } else if self.tag == 1 {
            if Mock.indicadorMercado.count != 0 {
                cell.lbTitle.text = Mock.indicadorMercado[indexPath.row]
            } else {
                return UICollectionViewCell()
            }
        } else if self.tag == 2 {
            if Mock.classes.count != 0 {
                cell.lbTitle.text = Mock.classes[indexPath.row]
            } else {
                return UICollectionViewCell()
            }
        } else if self.tag == 3 {
            if Mock.popular.count != 0 {
                cell.lbTitle.text = Mock.popular[indexPath.row]
            } else {
                return UICollectionViewCell()
            }
        } else {
            if Mock.outros.count != 0 {
                cell.lbTitle.text = Mock.outros[indexPath.row]
            } else {
                return UICollectionViewCell()
            }
        }
         
         if let gestures = cell.gestureRecognizers {
             if gestures.firstIndex(of: UILongPressGestureRecognizer()) == nil {
                 let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
                 cell.addGestureRecognizer(longPressRecognizer)
             }
             if gestures.firstIndex(of: UITapGestureRecognizer()) == nil {
                 let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(simpleTap))
                 cell.addGestureRecognizer(tapRecognizer)
             }
         } else {
             let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
             cell.addGestureRecognizer(longPressRecognizer)
             
             let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(simpleTap))
             cell.addGestureRecognizer(tapRecognizer)
         }
         
         return cell
     }
     
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = Mock.self.arrPessoal[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
     
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }
        var arr: [String] = []
        if self.tag == 0 {
            arr = Mock.arrPessoal
        } else if self.tag == 1 {
            arr = Mock.indicadorMercado
        } else if self.tag == 2 {
            arr = Mock.classes
        } else if self.tag == 3 {
            arr = Mock.popular
        } else {
            arr = Mock.outros
        }
        
        coordinator.items.forEach { dropItem in
            guard let sourceIndexPath = dropItem.sourceIndexPath else { return }
            collectionView.performBatchUpdates({
                let chip = arr[sourceIndexPath.row]
                removeIndex(at: sourceIndexPath)
                insertIndex(array: chip, at: destinationIndexPath)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            }, completion: { _ in
                coordinator.drop(dropItem.dragItem, toItemAt: destinationIndexPath)
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession,
                        withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal( operation: .move, intent: .insertAtDestinationIndexPath)
    }
}
