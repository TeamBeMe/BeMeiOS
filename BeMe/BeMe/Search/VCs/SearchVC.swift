//
//  SearchVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/05.
//

import UIKit

class SearchVC: UIViewController {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var underTableView: UITableView!
    
    @IBOutlet weak var backButton: UIButton!
    
    var searched: [FindPeopleSearchData] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        underTableView.dataSource = self
        underTableView.delegate = self
        searchTextField.delegate = self
        setItems()
        
        
    }
    
    func setItems(){
        underTableView.separatorStyle = .none
        setTableViewHeader()
        searchTextField.addTarget(self, action: #selector(textFieldDidChange),
                                  for: .editingChanged)
        
        searchTextField.addLeftPadding(left: 23)
        searchTextField.backgroundColor = .veryLightPinkTwo
    }
    
    func setTableViewHeader(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
        let headerLabel = UILabel().then{
            $0.text = "최근 검색"
            $0.font = UIFont.systemFont(ofSize: 14)
        }
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = .white
        headerLabel.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            
        }
        underTableView.tableHeaderView = headerView
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}


extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchTextField.text == ""{
            return 5
        }
        else{
            return searched.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchTextField.text == ""{
            guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: SearchRecentTVC.identifier, for: indexPath)
                    as? SearchRecentTVC else { return UITableViewCell() }
            setTableViewHeader()
            return cell
            
        }
        else{
            guard let cell = tableView
                    .dequeueReusableCell(withIdentifier: SearchNewTVC.identifier, for: indexPath)
                    as? SearchNewTVC else { return UITableViewCell() }
            underTableView.tableHeaderView = .none
            
            let data = searched[indexPath.item]
            let profileImgurl = data.profileImg ?? ""
            
            cell.setItems(profileImg: profileImgurl, userName: data.nickname, isFollowed: data.isFollowed)
            cell.findPeopleSearchData = searched[indexPath.item]
            return cell
            
        }
        
    }
    
    
}

extension SearchVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
        
    }
    
    
    
    
}


extension SearchVC: UITextFieldDelegate{
    
    
    @objc func textFieldDidChange(){
        
        
        
        
        underTableView.reloadData()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("called")
        
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("called2")
        FindPeopleSearchService.shared.search(findID: searchTextField.text!,
                                              isFollowing: 0){(networkResult) -> (Void) in
            switch networkResult{
            case .success(let data) :
                self.searched = []
                print(self.searchTextField.text!)
                if let searchedData = data as? FindPeopleSearchData{
                    
                    
                    self.searched.append(searchedData)
                    
                    
                }
                self.underTableView.reloadData()
                print("success")
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serverErr")
            case .networkFail:
                print("networkFail")
                
            }
            
            
        }
        
        
        
        
        return true
    }
}
