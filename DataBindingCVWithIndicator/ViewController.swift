//
//  ViewController.swift
//  DataBindingCVWithIndicator
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel : GetPostsListViewModel{
        return controller.viewModel
    }
    lazy var controller : CVListViewController = {
        return CVListViewController()
    }()
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initBinding()
        
    }
    func initView(){
        view.backgroundColor = .white
    }
    func initBinding(){
        viewModel.userLists.addObserver { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        viewModel.isLoading.addObserver { isLoading in
            if isLoading == true {
                self.loadingIndicator.startAnimating()

            }
            else{
                self.loadingIndicator.stopAnimating()
            }
        }
        viewModel.isTableViewHidden.addObserver { isHidden in
            self.collectionView.isHidden = isHidden
        }
        viewModel.title.addObserver { title in
            self.titleLabel.text = title
        }
        controller.start()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.userLists.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .lightGray
        cell.lblOutlet.text = viewModel.userLists.value[indexPath.row].userName
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10)/2
        return CGSize(width: size, height: size)
        
    }


}

