//
//  HomeViewController.swift
//  AlDarMachinTest
//
//  Created by Mumthasir VP on 05/08/24.
//

import UIKit
import TagListView
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tagListView: TagListView!
    
    private var newsModel: News?
    private var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagListView.delegate = self
        tagListView.addTags(Constants.tags)
        
        clearNavigatioBar()
        collectionViewConfig()
        callToViewModelForUIUpdate()
    }
    
    func collectionViewConfig(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        self.collectionView.isPagingEnabled = true
        self.collectionView.clipsToBounds = false
    }
    
    func clearNavigatioBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func callToViewModelForUIUpdate() {
        self.homeViewModel = HomeViewModel()
        self.homeViewModel.bindHomeViewModelToController = {
            debugPrint("Update data now...!!!")
            self.newsModel = self.homeViewModel.newsData
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            
        }
    }
}

extension HomeViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        self.homeViewModel = HomeViewModel()
        self.homeViewModel.callFuncToGetNewsDataBasedOnTags(tag: title.lowercased()) { data in
            self.newsModel = data
            self.collectionView.reloadData()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsModel?.articles.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.newsCellIdentifier, for: indexPath) as! TrendingNewsCollectionViewCell
        if let imageUrl = newsModel?.articles[indexPath.row].urlToImage {
            cell.newsImage.sd_setImage(with: URL(string: imageUrl))
        } else {
            cell.newsImage.image = UIImage(named: Constants.placeHolderImage)
        }
        cell.newsTitle.text = newsModel?.articles[indexPath.row].title
        cell.sourceLabel.text = newsModel?.articles[indexPath.row].source.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 250, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        if let urlString = newsModel?.articles[indexPath.row].url {
            let url = URL(string: urlString)
            detailVC.webviewUrl = url
            self.navigationController?.pushViewController(detailVC, animated: true)
        } else {
            debugPrint("#No detail page url found!")
        }
    }
}
