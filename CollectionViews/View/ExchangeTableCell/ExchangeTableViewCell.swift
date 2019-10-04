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
    
    
    var indexLine : Int?
    let columnLayout = CollectionViewHorizontal()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Collection
        self.collectionExchange.delegate = self
        self.collectionExchange.dataSource = self
        
        self.collectionExchange.dragInteractionEnabled = true
        self.collectionExchange.dragDelegate = self
        
        self.collectionExchange.dropDelegate = self
        
        
        columnLayout.scrollDirection = .horizontal
        self.collectionExchange.collectionViewLayout = columnLayout
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
        Mock.arrPessoal.remove(at: indexPath.row)
    }
      
    //Função para adicionar o index na collection
    func insertIndex(array: String, at indexPath: IndexPath) {
        Mock.arrPessoal.insert(array, at: indexPath.row)
    }

    // MARK: - Collection View
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: GenericFunctions.calculateCellSize(word: Mock.arrPessoal[indexPath.row]), height: 40)
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return Mock.arrPessoal.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeCollectionViewCell", for: indexPath) as! ExchangeCollectionViewCell
             
         if Mock.arrPessoal.count != 0 {
             cell.lbTitle.text = Mock.arrPessoal[indexPath.row]
             cell.backgroundColor = .none
         } else {
             return UICollectionViewCell()
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
     
     func collectionView(_ collectionView: UICollectionView,
                         canHandle session: UIDropSession) -> Bool {
       return true
     }
     
     func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
         guard let destinationIndexPath = coordinator.destinationIndexPath else {
           return
         }

         coordinator.items.forEach { dropItem in
           guard let sourceIndexPath = dropItem.sourceIndexPath else {
             return
           }

           collectionView.performBatchUpdates({
             let image = Mock.arrPessoal[sourceIndexPath.row]
             removeIndex(at: sourceIndexPath)
             insertIndex(array: image, at: destinationIndexPath)
             collectionView.deleteItems(at: [sourceIndexPath])
             collectionView.insertItems(at: [destinationIndexPath])
           }, completion: { _ in
             coordinator.drop(dropItem.dragItem,
                               toItemAt: destinationIndexPath)
           })
        }
     }
     
     func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession,
       withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
       return UICollectionViewDropProposal( operation: .move, intent: .insertAtDestinationIndexPath)
     }
}
