//
//  MyGroupsTableViewController.swift
//  VK Client
//
//  Created by Мария Коханчик on 07.02.2021.
//

import UIKit

class MyGroupsTableViewController: UITableViewController, UISearchBarDelegate {

    private var filterGroups = [Community]()
    let networkService = NetworkManager()
    
    @IBOutlet var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MyGroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        self.searchBar.delegate = self
        //self.filterGroups = groups
        networkService.getCommunity(onComplete: { [weak self] (communites) in
            self?.filterGroups = communites
            self?.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
//    @IBAction func addGroup(seque: UIStoryboardSegue) {
//        if segue.identifier == "addGroup" {
//            let allCommunityController = segue.source as! AllGroupsTableViewController
//            if let indexPath = allCommunityController.tableView.indexPathForSelectedRow {
//                let community = allCommunityController.communites[indexPath.row]
//                networkService.joinCommunity(id: community.id, onComplete: { (value) in
//                    if value == 1 {
//                        print("Запрос на вступление в группу отправлен")
//                    } else {
//                        print("Запрос отклонен")
//                    }
//                    self.tableView.reloadData()
//                }) { (error) in
//                    print(error)
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
        
        cell.groupName.text = group.name
        cell.groupImageView.image = UIImage(named: group.avatarURL)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            filterGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterGroups = []
        
        if searchText.count == 0 {
            self.filterGroups = [Community]()
        } else {
            for group in [Community]() where group.name.lowercased().contains(searchText.lowercased()) {
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
