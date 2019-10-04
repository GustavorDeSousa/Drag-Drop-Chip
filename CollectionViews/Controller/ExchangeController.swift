//
//  ViewController.swift
//  CollectionViews
//
//  Created by Gustavo De Sousa on 29/09/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import UIKit

class ExchangeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableExchange: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let columnLayout = CollectionViewHorizontal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Table
        self.tableExchange.delegate = self
        self.tableExchange.dataSource = self
        self.tableExchange.register(UINib(nibName: "MatchTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchTableViewCell")
        
        // Collection
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.dragInteractionEnabled = true
        self.collectionView.dragDelegate = self
        
        self.collectionView.dropDelegate = self
        
        
        self.columnLayout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = columnLayout
        self.collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.register(UINib(nibName: "ExchangeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ExchangeCollectionViewCell")
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
    
    //Simple Tap é para fazer um click simples na celula
    @objc func simpleTap(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Simple Click", message: "FOII", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    //Long Pressed é para fazer um click longo na celula
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let alert = UIAlertController(title: "Long Click", message: "FOII", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableMatch.dequeueReusableCell(withIdentifier: "MatchTableViewCell") as! MatchTableViewCell
//        guard let vm = viewModel else { return UITableViewCell() }
//        if viewModel?.getLastMatch().count != 0 {
//            for championId in (vm.getListChamppion().data) {
//                if Int(championId.key) == vm.lastMatchDTO?[0].matches[indexPath.row].champion {
//                    cell.imgChampion.downloaded(from: MapURL.BASEURLIMG_V2 + championId.image.full)
//                    cell.lblChampion.text = championId.name
//                }
//            }
//        } else {
            return UITableViewCell()
//        }
//        return cell
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
                let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ExchangeController.longPressed(sender:)))
                cell.addGestureRecognizer(longPressRecognizer)
            }
            if gestures.firstIndex(of: UITapGestureRecognizer()) == nil {
                let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ExchangeController.simpleTap))
                cell.addGestureRecognizer(tapRecognizer)
            }
        } else {
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ExchangeController.longPressed(sender:)))
            cell.addGestureRecognizer(longPressRecognizer)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ExchangeController.simpleTap))
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
            
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession,
      withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
      return UICollectionViewDropProposal( operation: .move, intent: .insertAtDestinationIndexPath)
    }
}
