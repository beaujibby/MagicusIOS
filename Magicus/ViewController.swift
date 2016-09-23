//
//  ViewController.swift
//  Magicus
//
//  Created by Beamer Wilkins on 9/22/16.
//  Copyright © 2016 TRNSFR, Inc. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    let tableView = UITableView()
    var games:[[String:AnyObject]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Magicus"

        self.tableView.frame = self.view.bounds
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(GameCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)

        self.fetch()
    }

    func fetch() {
        Alamofire.request("http://magicus.dev/games.json").responseJSON { response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                self.games = JSON as! [[String:AnyObject]]
                self.tableView.reloadData()
            }
        }
    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator

        let game = self.games[indexPath.row]

        if let name = game["name"] as? String {
            cell.textLabel?.text = name
        }

        if let addOnCount = game["add_ons"] as? Int {
            cell.detailTextLabel?.text = "\(addOnCount) Add Ons"
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let game = self.games[indexPath.row]

        let vc = GameViewController()
        vc.game = game

        self.navigationController?.pushViewController(vc, animated: true)
    }

}
