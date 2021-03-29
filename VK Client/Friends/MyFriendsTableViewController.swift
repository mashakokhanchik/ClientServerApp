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
    //let networkManager = NetworkManager()
    var filterFriends = [VKUser]()
    let networkService = NetworkManager()
    private struct Section {
        let letter: String
        let friend: [VKUser]
    }
    
    private var sections = [Section]()
    private var headers = [String]()
    
    @IBOutlet var searchBar: UISearchBar!
    
    private func sortedHeader() {
        let sectionsData = Dictionary(grouping: self.filterFriends, by: { String ($0.lastName.prefix(1)) })
        let sort = sectionsData.keys.sorted()
        self.sections = sort.map { Section(letter: $0, friend: sectionsData[$0]!) }
        self.headers = self.sections.map {$0.letter}
    }
    
//    var friends = [
//        User(id: .max, name: "Monica", surname: "Geller", isFriend: true, avatarImageView: "MAv", friendPhotos: [UIImage(named: "M1")!, UIImage(named: "M2")!, UIImage(named: "M3")!, UIImage(named: "M4")!]),
//        User(id: .max, name: "Rashel", surname: "Green", isFriend: true, avatarImageView: "RAv", friendPhotos: [UIImage(named: "R1")!, UIImage(named: "R2")!, UIImage(named: "R3")!, UIImage(named: "R4")!]),
//        User(id: .max, name: "Joe", surname: "Tribbiani", isFriend: true, avatarImageView: "JAv", friendPhotos: [UIImage(named: "J1")!, UIImage(named: "J2")!, UIImage(named: "J3")!, UIImage(named: "J4")!]),
//        User(id: .max, name: "Ross", surname: "Geller", isFriend: true, avatarImageView: "RoAv", friendPhotos: [UIImage(named: "Ro1")!, UIImage(named: "Ro2")!, UIImage(named: "Ro3")!, UIImage(named: "Ro4")!])
//    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "MyFriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendCell")
        self.tableView.register(UINib(nibName: "HeaderMyFriends", bundle: nil), forHeaderFooterViewReuseIdentifier: "Header")
        
        tableView.dataSource = self
        
        self.searchBar.delegate = self
        
        self.filterFriends = [VKUser]()
        
        sortedHeader()
        
        //setLettersControl()
        networkService.loadFriends(onComplete: { [weak self] (filterFriends) in self?.filterFriends = filterFriends
            
        })
//        NetworkManager.shared.loadFriends(token: "") { [weak self] (filterFriends) in
//
//            self?.filterFriends = filterFriends
//
//        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].friend.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! MyFriendsTableViewCell

        cell.friendName.text = self.sections[indexPath.section].friend[indexPath.row].lastName + " " + self.sections[indexPath.section].friend[indexPath.row].firstName
        cell.avatarImageView.image = UIImage(named: self.sections[indexPath.section].friend[indexPath.row].avatarURL)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "photoViewController") as! PhotoCollectionViewController
        vc.data = self.sections[indexPath.section].friend[indexPath.row]//friends[indexPath.section]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
        let view = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! HeaderMyFriends
        
        view.header.text = self.headers[section]
        return view
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterFriends = []
        
        if searchText.count == 0 {
            self.filterFriends = [VKUser]()
        } else {
            for friend in [VKUser]() where friend.lastName.lowercased().contains(searchText.lowercased()) || friend.firstName.lowercased().contains(searchText.lowercased()) {
                self.filterFriends.append(friend)
            }
        }
        sortedHeader()
        self.tableView.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollection" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let photoCollectionViewController = segue.destination as! PhotoCollectionViewController
                let friend = self.sections[indexPath.section].friend[indexPath.row]
                //photoCollectionViewController.friendPhoto = friend.friendPhotos
                photoCollectionViewController.userID = friend.userId
            }
        }
    }

//    private func setLettersControl(){
//
//        view.addSubview(lettersControl)
//
//        lettersControl.translatesAutoresizingMaskIntoConstraints = false
//        lettersControl.arrChar = friendDictionary.keys.sorted()
//        lettersControl.backgroundColor = .clear
//        lettersControl.addTarget(self, action: #selector(scrollToSelectedLetter), for: [.touchUpInside])
//
//        NSLayoutConstraint.activate([
//            lettersControl.heightAnchor.constraint(equalToConstant: CGFloat(15*lettersControl.arrChar.count)),
//            lettersControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            lettersControl.widthAnchor.constraint(equalToConstant: 20),
//            lettersControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//
//    }
//
//    @objc func scrollToSelectedLetter(){
//        let selectLetter = lettersControl.selectedLetter
//        for indexSextion in 0..<firstLetters.count{
//            if selectLetter == firstLetters[indexSextion]{
//                tableView.scrollToRow(at: IndexPath(row: 0, section: indexSextion), at: .top, animated: true)
//                break
//            }
//        }
//    }


}



