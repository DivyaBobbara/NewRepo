//
//  ViewController.swift
//  DataBindingCVWithIndicator
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var lblCount: UILabel!
    
    var viewModel : GetPostsListViewModel{
        return controller.viewModel
    }
    lazy var controller : CVListViewController = {
        return CVListViewController()
    }()
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        AF.request("http://stagetao.gcf.education:3000/api/v1/postLikes/73/3/false", method: .put, parameters: nil, headers: nil).responseDecodable(of:UpdateLikes.self) { res in
//            print(res)
//        }
        initView()
        initBinding()
        
    }
   
    func initView(){
        view.backgroundColor = .white
    }
    func initBinding(){
        viewModel.isClicked.addObserver { isClicked in
            
//            self.controller.apiCall()
            if isClicked {
                self.controller.apiCall()
            }
            
            
        }
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
        return viewModel.userLists.value.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .lightGray
        cell.likesButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        cell.likesButton.tag = indexPath.row
        cell.likesCountLabel.text = "\(viewModel.userLists.value[indexPath.row].totalLikes)"
        cell.lblOutlet.text = viewModel.userLists.value[indexPath.row].userName
        cell.postDataLabelOutlet.text = "\(viewModel.userLists.value[indexPath.row].postData)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10)/2
        return CGSize(width: size, height: size)
        
    }
   
    @objc func didTapLikeButton(sender : UIButton){
//        print(sender.tag)
//        var likeStatus = viewModel.userLists.value[sender.tag].likeStatus
//        var postId = viewModel.userLists.value[sender.tag].postId
//        print(likeStatus)
//        print(postId)
//        AF.request("http://stagetao.gcf.education:3000/api/v1/postLikes/\(postId)/3/\(!likeStatus)", method: .put, parameters: nil, headers: nil).responseDecodable(of:UpdateLikes.self) { res in
//                    print(res)
//                }
        
        controller.updateLikes(index: sender.tag)
        viewModel.isClicked.value = true
        
    }
    

  
    
}

