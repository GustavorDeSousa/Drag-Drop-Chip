//
//  ViewController.swift
//  CollectionViews
//
//  Created by Gustavo De Sousa on 29/09/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var array = [
        "BDR",
        "Bens Industriais",
        "Construção e Transporte",
        "Consumo Cíclico",
        "Consumo Não Cíclico",
        "Financeiro e Outros",
        "Materiais Básicos",
        "Outros",
        "Petróleo, Gás e Biocombustíveis",
        "Tecnologia da Informação",
        "Telecomunicações",
        "Utilidade Pública"
    ]
    
    let columnLayout = CustomViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.dragInteractionEnabled = true
        self.collectionView.dragDelegate = self
        
        self.collectionView.dropDelegate = self
        
        
        self.columnLayout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = columnLayout
        self.collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.register(UINib(nibName: "TesteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TesteCollectionViewCell")
    }
    
    @objc func doubleTapped() {
        let alert = UIAlertController(title: "Double Click", message: "FOII", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
    }
    
    func removePhoto(at indexPath: IndexPath) {
        array.remove(at: indexPath.row)
    }
      
    func insertPhoto(array: String, at indexPath: IndexPath) {
        self.array.insert(array, at: indexPath.row)
    }
    
    func calculateCellSize(word: String) -> Double {
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17.0)]
        let test = word.size(withAttributes: attrs)
        return Double(test.width + 30.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: calculateCellSize(word: array[indexPath.row]), height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TesteCollectionViewCell", for: indexPath) as! TesteCollectionViewCell
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        cell.addGestureRecognizer(tap)
        
        if array.count != 0 {
            cell.lbTitle.text = array[indexPath.row]
        } else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = self.array[indexPath.row]
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
            let image = array[sourceIndexPath.row]
            removePhoto(at: sourceIndexPath)
            insertPhoto(array: image, at: destinationIndexPath)
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

class CustomViewFlowLayout: UICollectionViewFlowLayout {

    
    
    let cellSpacing:CGFloat = 4
    
    override var collectionViewContentSize: CGSize {
        let defaultSize = super.collectionViewContentSize
        return CGSize(width: (defaultSize.width * 2) / 1.2, height: defaultSize.height)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.sectionInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 6)
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var posY = sectionInset.top
        let defaultSize = super.collectionViewContentSize


        attributes?.forEach({ (chip) in
            chip.frame.origin.y = posY
            chip.frame.origin.x = leftMargin

            leftMargin += chip.frame.width
            if leftMargin >= (defaultSize.width * 2) / 1.5  {
                posY += chip.frame.height
                leftMargin = sectionInset.left
            }

        })
        return attributes
    }
}
