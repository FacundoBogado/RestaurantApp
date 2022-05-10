//
//  RestaurantViewController.swift
//  RestaurantApp
//
//  Created by Facu Bogado on 09/05/2022.
//

import UIKit

protocol ViewControllerProtocol {
    func fecthData()
}

class RestaurantViewController: UIViewController, ViewControllerProtocol {
    private var controller = RestaurantController()
    var restaurants = RestaurantResult(data: [])

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fecthData()
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func fecthData() {
        controller.getRestaurantData { result in
            self.restaurants = result
            self.tableView.reloadData()
        }
    }
}

extension RestaurantViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.selectionStyle = .none 
        cell.configure(model: restaurants.data[indexPath.row]) 
        return cell
    }
}

extension RestaurantViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 470
    }
}
