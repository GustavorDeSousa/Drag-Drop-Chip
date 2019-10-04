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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CollectionViewHorizontal.lines * 75
    }
}
