//
//  GameViewController.swift
//  Magicus
//
//  Created by Beamer Wilkins on 9/22/16.
//  Copyright © 2016 TRNSFR, Inc. All rights reserved.
//

import UIKit
import Alamofire

class GameViewController: UIViewController {
    var game:[String:AnyObject] = [:]
    var addOns:[[String:AnyObject]] = []
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = game["name"] as? String
        self.view.backgroundColor = UIColor.white

        self.tableView.frame = self.view.bounds
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(GameCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)

        self.fetch()
    }

    func fetch() {
        Alamofire.request("http://magicus.dev/games/\(game["id"]!).json").responseJSON { response in
            if let JSON = response.result.value as? [String:AnyObject] {
                print("JSON: \(JSON)")
                self.addOns = JSON["add_ons"] as! [[String:AnyObject]]
                self.tableView.reloadData()
            }
        }
    }

}

extension GameViewController : UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addOns.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Add Ons"
        }
        return ""
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let addOn = self.addOns[indexPath.row]

        if let title = addOn["title"] as? String {
            cell.textLabel?.text = title
        }

        if let cost = addOn["cost"] as? String {
            cell.detailTextLabel?.text = cost
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
