//
//  MyGroupsTableViewController.swift
//  VK Client
//
//  Created by Мария Коханчик on 07.02.2021.
//

import UIKit

class MyGroupsTableViewController: UITableViewController, UISearchBarDelegate {

    private var filterGroups = [Group]()

    var groups = [
        Group(groupName: "Central Perk", groupImageView: "CentralPerk"),
        Group(groupName: "Barbados", groupImageView: "Barbados")
    ]
    
    var group: Group!
    
    @IBOutlet var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MyGroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        self.searchBar.delegate = self
        self.filterGroups = groups
    }
    
//    @IBAction func addGroup(seque: UIStoryboardSegue) {
//        if seque.identifier == "addGroup" {
//            let allGroupsTableViewController = seque.source as! AllGroupsTableViewController
//            if let indexPath = allGroupsTableViewController.tableView.indexPathForSelectedRow {
//                let group = allGroupsTableViewController.groups[indexPath.row]
//                if !filterGroups.contains(group) {
//                    filterGroups.append(group)
//                    tableView.reloadData()
//                }
//            }
//        }
//    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! MyGroupsTableViewCell
        
        let group = self.filterGroups[indexPath.row]
        
        cell.groupName.text = group.groupName
        cell.groupImageView.image = UIImage(named: group.groupImageView)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
//        else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterGroups = []
        
        if searchText.count == 0 {
            self.filterGroups = groups
        } else {
            for group in groups where group.groupName.lowercased().contains(searchText.lowercased()) {
                self.filterGroups.append(group)
            }
        }
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
