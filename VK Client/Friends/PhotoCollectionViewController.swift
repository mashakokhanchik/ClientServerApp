//
//  PhotoCollectionViewController.swift
//  VK Client
//
//  Created by Мария Коханчик on 07.02.2021.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var friendPhoto = [VKPhoto]()
    
    var userID: Int?

    var data: VKUser!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: .none), forCellWithReuseIdentifier: "PhotoCell")
        self.collectionView.delegate = self
    
    }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendPhoto.count//data.friendPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        guard let photoURL = friendPhoto[indexPath.item].sizes.last?.url else { return cell }
        
        cell.photo.image = UIImage(named: photoURL)
        
        
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        
        //cell.photo.image = data.friendPhotos[indexPath.row]

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
        showPresenter(photos: friendPhoto, selectedPhoto: indexPath.item)
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
    
    func showPresenter(photos: [VKPhoto], selectedPhoto: Int){
        let presentViewController = PresenterPhoto()
        presentViewController.photos = photos//data.friendPhotos
        presentViewController.selectedPhoto = selectedPhoto
        presentViewController.modalPresentationStyle = .automatic
        presentViewController.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(presentViewController, animated: true)
    }
}
