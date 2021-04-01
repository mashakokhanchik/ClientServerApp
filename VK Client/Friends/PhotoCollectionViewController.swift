//
//  PhotoCollectionViewController.swift
//  VK Client
//
//  Created by Мария Коханчик on 07.02.2021.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var photos = [Photo]()

    var data: Friend!
    
    var userID: Int?

    let networkService = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: .none), forCellWithReuseIdentifier: "PhotoCell")
        self.collectionView.delegate = self
        
        networkService.getPhoto(for: userID, onComplete: { [weak self] (photos) in
            self?.photos = photos
            self?.collectionView.reloadData()
        }) { (error) in
            print(error)
        }
    }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        guard let photoURL = photos[indexPath.item].sizes.last?.url else { return cell }
        
        cell.photo.image = UIImage(named: photoURL)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        showPresenter(photos: photos, selectedPhoto: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: UICollectionViewDelegate
    
    func showPresenter(photos: [Photo], selectedPhoto: Int){
        let presentViewController = PresenterPhoto()
        presentViewController.photos = photos//data.friendPhotos//photos
        presentViewController.selectedPhoto = selectedPhoto
        presentViewController.modalPresentationStyle = .automatic
        presentViewController.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(presentViewController, animated: true)
    }
}
