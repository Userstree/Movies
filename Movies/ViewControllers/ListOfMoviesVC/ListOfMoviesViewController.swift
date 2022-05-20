//
//  ListOfMoviesViewController.swift
//  Movies
//
//  Created by Dossymkhan Zhulamanov on 20.05.2022.
//

import UIKit

class ListOfMoviesViewController: UIViewController {

    lazy var table: UITableView = {
        let tableView = UITableView()
//        tableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension ListOfMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "temp", for: indexPath)
        return cell
    }
    
    
}
