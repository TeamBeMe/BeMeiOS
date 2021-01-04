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
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        underTableView.dataSource = self
        underTableView.delegate = self
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



}


extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
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
    
    
    
    
}
