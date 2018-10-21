//
//  AddRoomTableViewController.swift
//  Hotel Manzana
//
//  Created by Denis Zubkov on 19/10/2018.
//  Copyright © 2018 Denis Zubkov. All rights reserved.
//

import UIKit

class AddRoomTableViewController: UITableViewController {
    var roomTypes: [RoomType] = []
    var currentRoomType: RoomType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as! RoomTableViewCell
        let roomType = roomTypes[indexPath.row]
        cell.updateCell(with: roomType)
        if roomType == currentRoomType {
            cell.accessoryType = .checkmark
            cell.priceTralingConstraint.constant = 20
        } else {
            cell.accessoryType = .none
            cell.priceTralingConstraint.constant = 60
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRoomType = roomTypes[indexPath.row]
        tableView.reloadData()
    }
    
}
