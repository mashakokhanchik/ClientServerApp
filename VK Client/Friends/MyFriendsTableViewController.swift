//
//  MyFriendsTableViewController.swift
//  VK Client
//
//  Created by Мария Коханчик on 07.02.2021.
//

import UIKit

class MyFriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    
  
//    private var lettersControl = LettersControl()
//    var friendDictionary = [Character: [User]]()
//    var firstLetters: [Character] {
//        get {
//            friendDictionary.keys.sorted()
//        }
//    }
//
//    private var filterFriends = [Friend]()
//
//    private struct Section {
//        let letter: String
//        let friend: [Friend]
//    }
//
//    private var sections = [Section]()
    private var headers = [String]()
    
    let networkService = NetworkManager()
    
    var data = [Friend]()
    var friends = [Friend]()
    var friendDict = [Character:[Friend]]()
    var firstLetters: [Character] {
        get {
            friendDict.keys.sorted()
        }
    }
    
    private var lettersControl = LettersControl()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    
    
//    @IBOutlet var searchBar: UISearchBar!
//
//    private func sortedHeader() {
//        let sectionsData = Dictionary(grouping: self.friends, by: { String ($0.lastName.prefix(1)) })
//        let sort = sectionsData.keys.sorted()
//        self.sections = sort.map { Section(letter: $0, friend: sectionsData[$0]!) }
//        self.headers = self.sections.map {$0.letter}
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "MyFriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendCell")
        self.tableView.register(UINib(nibName: "HeaderMyFriends", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        
        tableView.dataSource = self
        
        networkService.getFriends(onComplete: { [weak self] (friends) in
            let tmpFriends = friends.filter { !$0.lastName.isEmpty }
            self?.data = tmpFriends
            self?.friendDict = self?.getSortedUsers(searchText: nil, list: tmpFriends) ?? [Character: [Friend]]()
            self?.tableView.reloadData()
            self?.setLettersControl()
        }) { (error) in
            print(error)
        }
        setSearchController()

        
        //self.searchBar.delegate = self
        
        //self.filterFriends = friends
        
        //sortedHeader()
        
        //setLettersControl()
        
        //self.tableView.reloadData()
        
    }
    
    private func getSortedUsers(searchText: String? , list: [Friend]) -> [Character:[Friend]]{
        var tempUsers: [Friend]
        if let text = searchText?.lowercased(), searchText != "" {
            tempUsers = list.filter{ $0.lastName.lowercased().contains(text) || $0.firstName.lowercased().contains(text) }
        } else {
            tempUsers = list
        }
        let sortedUsers = Dictionary.init(grouping: tempUsers) { $0.lastName.lowercased().first ?? "#" }
            .mapValues{ $0.sorted{ $0.lastName.lowercased() < $1.lastName.lowercased() } }
        return sortedUsers
    }
    
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    private func setLettersControl(){
        view.addSubview(lettersControl)
        
        lettersControl.translatesAutoresizingMaskIntoConstraints = false
        lettersControl.arrChar = friendDict.keys.sorted()
        lettersControl.backgroundColor = .clear
        lettersControl.addTarget(self, action: #selector(scrollToSelectedLetter), for: [.touchUpInside])
        
        NSLayoutConstraint.activate([
            lettersControl.heightAnchor.constraint(equalToConstant: CGFloat(15*lettersControl.arrChar.count)),
            lettersControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lettersControl.widthAnchor.constraint(equalToConstant: 20),
            lettersControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    @objc func scrollToSelectedLetter(){
        let selectLetter = lettersControl.selectedLetter
        for indexSextion in 0..<firstLetters.count{
            if selectLetter == firstLetters[indexSextion]{
                tableView.scrollToRow(at: IndexPath(row: 0, section: indexSextion), at: .top, animated: true)
                break
            }
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return friendDict.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !firstLetters.isEmpty else { return 0 }
        let key = firstLetters[section]
        return friendDict[key]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! MyFriendsTableViewCell

        let key = firstLetters[indexPath.section]
        let friendsForKey = friendDict[key]
        guard let friend = friendsForKey?[indexPath.row] else { return cell }
        
        cell.friendName.text = friend.firstName + " " + friend.lastName
        cell.avatarURL.image = UIImage(named: friend.avatarURL)

        return cell
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "photoViewController") as! PhotoCollectionViewController
//        vc.data = self.sections[indexPath.section].friend[indexPath.row]//friends[indexPath.section]
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            
//        let view = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! HeaderMyFriends
//        
//        view.header.text = self.headers[section]
//        return view
//    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.filterFriends = []
//
//        if searchText.count == 0 {
//            self.filterFriends = [Friend]()
//        } else {
//            for friend in [Friend]() where friend.lastName.lowercased().contains(searchText.lowercased()) || friend.firstName.lowercased().contains(searchText.lowercased()) {
//                self.filterFriends.append(friend)
//            }
//        }
//        sortedHeader()
//        self.tableView.reloadData()
//    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollection" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! PhotoCollectionViewController
                let users = friendDict[firstLetters[indexPath.section]]
                guard let user = users?[indexPath.row] else { return }
                
                controller.userID = user.id
                controller.title = user.firstName + " " + user.lastName
            }
        }
    }

}
extension MyFriendsTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterFriendForSearchText(searchController.searchBar.text!)
    }
    
    private func filterFriendForSearchText(_ searchText: String){
        friendDict = self.getSortedUsers(searchText: searchText, list: data)
        
        if searchText == "" {
            lettersControl.isHidden = false
        }else{
            lettersControl.isHidden = true
        }
        tableView.reloadData()
    }
}

