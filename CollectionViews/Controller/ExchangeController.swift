//
//  ViewController.swift
//  CollectionViews
//
//  Created by Gustavo De Sousa on 29/09/19.
//  Copyright © 2019 Gustavo De Sousa. All rights reserved.
//

import UIKit

class ExchangeController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableExchange: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //Table
        self.tableExchange.delegate = self
        self.tableExchange.dataSource = self
        self.tableExchange.register(UINib(nibName: "ExchangeTableViewCell", bundle: nil), forCellReuseIdentifier: "ExchangeTableViewCell")
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Mock.indexScreenExchange.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableExchange.dequeueReusableCell(withIdentifier: "ExchangeTableViewCell") as! ExchangeTableViewCell
        cell.lbTitleChip.text = Mock.indexScreenExchange[indexPath.row]
        cell.indexLine = indexPath.row
        if cell.indexLine == indexPath.row && indexPath.row == 0 {
            cell.collectionExchange.collectionViewLayout = CollectionViewHorizontal(qtyLines: CollectionLine.three, arr: Mock.arrPessoal)
            cell.tbCellHeight.constant = CollectionLine.three * SizeChip.chipHeight
        } else if cell.indexLine == indexPath.row && indexPath.row == 1 {
            cell.collectionExchange.collectionViewLayout = CollectionViewHorizontal(qtyLines: CollectionLine.three, arr: Mock.indicadorMercado)
            cell.tbCellHeight.constant = CollectionLine.three * SizeChip.chipHeight
        } else if cell.indexLine == indexPath.row && indexPath.row == 2 {
            cell.collectionExchange.collectionViewLayout = CollectionViewHorizontal(qtyLines: CollectionLine.two, arr: Mock.classes)
            cell.tbCellHeight.constant = CollectionLine.two * SizeChip.chipHeight
        } else if cell.indexLine == indexPath.row && indexPath.row == 3 {
            cell.collectionExchange.collectionViewLayout = CollectionViewHorizontal(qtyLines: CollectionLine.three, arr: Mock.popular)
            cell.tbCellHeight.constant = CollectionLine.three * SizeChip.chipHeight
        } else {
            cell.collectionExchange.collectionViewLayout = CollectionViewHorizontal(qtyLines: CollectionLine.two, arr: Mock.outros)
            cell.tbCellHeight.constant = CollectionLine.two * SizeChip.chipHeight
        }
        cell.tag = indexPath.row

        return cell
    }
}
