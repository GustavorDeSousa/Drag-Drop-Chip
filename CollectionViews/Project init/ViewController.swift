//
//  ViewController.swift
//  CollectionViews
//
//  Created by Gustavo De Sousa on 29/09/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static var array = [
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
    
    static func arrSize(lines: Int) -> Double {
        var size = 0.0
        for i in ViewController.array {
            size += ViewController.calculateCellSize(word: i)
        }
        size = size / Double(lines)
        return size
    }
    
    func removePhoto(at indexPath: IndexPath) {
        ViewController.array.remove(at: indexPath.row)
    }
      
    func insertPhoto(array: String, at indexPath: IndexPath) {
        ViewController.self.array.insert(array, at: indexPath.row)
    }
    
    static func calculateCellSize(word: String) -> Double {
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17.0)]
        let test = word.size(withAttributes: attrs)
        return Double(test.width + 30.0)
    }
    
    @objc func simpleTap(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Simple Click", message: "FOII", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let alert = UIAlertController(title: "Long Click", message: "FOII", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ViewController.calculateCellSize(word: ViewController.array[indexPath.row]), height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewController.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TesteCollectionViewCell", for: indexPath) as! TesteCollectionViewCell
            
        if ViewController.array.count != 0 {
            cell.lbTitle.text = ViewController.array[indexPath.row]
            cell.backgroundColor = .none
        } else {
            return UICollectionViewCell()
        }
        
        if let gestures = cell.gestureRecognizers {
            if gestures.firstIndex(of: UILongPressGestureRecognizer()) == nil {
                let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressed(sender:)))
                cell.addGestureRecognizer(longPressRecognizer)
            }
            if gestures.firstIndex(of: UITapGestureRecognizer()) == nil {
                let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.simpleTap))
                cell.addGestureRecognizer(tapRecognizer)
            }
        } else {
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressed(sender:)))
            cell.addGestureRecognizer(longPressRecognizer)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.simpleTap))
            cell.addGestureRecognizer(tapRecognizer)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = ViewController.self.array[indexPath.row]
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
            let image = ViewController.array[sourceIndexPath.row]
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
    //Quantity line in collectionView
    let lines: CGFloat = 3
    //More space in collectionView
    let mult: CGFloat = 1.2
    
    override var collectionViewContentSize: CGSize {
        let defaultSize = super.collectionViewContentSize
        let characterInLine = ViewController.arrSize(lines: Int(lines))
        return CGSize(width: CGFloat(characterInLine) * mult, height: defaultSize.height)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        self.sectionInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 6)
        var leftMargin = sectionInset.left
        var posY = sectionInset.top
        var count = 0
        
        attributes?.forEach({ (chip) in
            chip.frame.origin.y = posY
            chip.frame.origin.x = leftMargin

            leftMargin += chip.frame.width
            if leftMargin + chip.frame.width >= CGFloat(ViewController.arrSize(lines: Int(lines))) * mult  {
                count += 1
                if count <= Int(lines) {
                    posY += chip.frame.height
                    leftMargin = sectionInset.left
                }
            }
        })
        return attributes
    }
}
