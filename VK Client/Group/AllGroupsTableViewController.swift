//
//  AllGroupsTableViewController.swift
//  VK Client
//
//  Created by Мария Коханчик on 07.02.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {

    var groups = [Community]()
    let networkService = NetworkManager()
    
    var searchController: UISearchController!
    var searchText = ""
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "AllGroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        configureSearchController()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupCell", for: indexPath) as! AllGroupsTableViewCell
        
        let community = groups[indexPath.row]
        
        cell.groupName.text = community.name
        cell.groupImageView.image = UIImage(named: community.avatarURL)
        return cell
    }
}
    
extension AllGroupsTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
        func updateSearchResults(for searchController: UISearchController) {
            guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
                return
            }
            if !isSearching {
                isSearching.toggle()
                networkService.getSearchCommunity(text: searchText, onComplete: { [weak self] (communites) in
                    self?.groups = communites
                    self?.tableView.reloadData()
                    self?.isSearching.toggle()
                }) { (error) in
                    self.isSearching.toggle()
                    print(error)
                }
            }
        }
        func  searchBarTextDidBeginEditing ( _  searchBar : UISearchBar) {
            groups.removeAll()
            tableView.reloadData()
        }
        func  searchBarCancelButtonClicked ( _  searchBar : UISearchBar) {
            groups.removeAll()
            tableView.reloadData()
        }
        
        func configureSearchController() {
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.searchBar.placeholder = "Search"
            searchController.searchBar.delegate = self
            searchController.searchBar.sizeToFit()
            tableView.tableHeaderView = searchController.searchBar
            
        }
}

