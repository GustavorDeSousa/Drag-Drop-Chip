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
            cell.collectionExchange.collectionViewLayout = CollectionViewHorizontal(qtyLines: 3)
        } else if cell.indexLine == indexPath.row && indexPath.row == 1 {
            cell.collectionExchange.collectionViewLayout = CollectionViewHorizontal(qtyLines: 3)
        } else if cell.indexLine == indexPath.row && indexPath.row == 2 {
            cell.collectionExchange.collectionViewLayout = CollectionViewHorizontal(qtyLines: 2)
        } else if cell.indexLine == indexPath.row && indexPath.row == 3 {
            cell.collectionExchange.collectionViewLayout = CollectionViewHorizontal(qtyLines: 3)
        } else {
            cell.collectionExchange.collectionViewLayout = CollectionViewHorizontal(qtyLines: 2)
        }

        cell.tag = indexPath.row

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightFix: CGFloat = 60
        if indexPath.row == 0 {
            return 4 * heightFix
        } else if indexPath.row == 1 {
            return 3 * heightFix
        } else if indexPath.row == 2 {
            return 2 * heightFix
        } else  if indexPath.row == 3 {
            return 3 * heightFix
        } else {
            return 2 * heightFix
        }
    }
}
