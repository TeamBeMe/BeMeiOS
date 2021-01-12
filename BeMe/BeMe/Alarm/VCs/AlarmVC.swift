//
//  AlarmVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/12.
//

import UIKit

class AlarmVC: UIViewController {

    @IBOutlet weak var alarmTableView: UITableView!
    
    private var page: Int = 1
    
    private var currentPage: Int = 1
    
    private var alarmArray: [Alarm] = [] {
        didSet {
            self.alarmTableView.reloadData()
        }
    }
    
    //MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Alarm 화면 들어옴")
        getAlarms()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func dismissButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Private Method
extension AlarmVC {
    
    private func getAlarms() {
        
        AlarmService.shared.getAlarm { (result) in
            switch result {
            case .success(let data):
                guard let dt = data as? GenericResponse<AlarmData> else { return }
                if let ad = dt.data {
                    self.page = ad.pageLen
                    
                    if self.currentPage == 1 {
                        self.alarmArray = ad.activities
                    } else {
                        self.alarmArray.append(contentsOf: ad.activities)
                    }
                    
                }
                
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "통신 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                
            case .pathErr: print("path")
            case .serverErr:
                let alertViewController = UIAlertController(title: "통신 실패", message: "서버 오류", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                print("networkFail")
                print("serverErr")
            case .networkFail:
                let alertViewController = UIAlertController(title: "통신 실패", message: "네트워크 오류", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
                print("networkFail")
            }
        }
    }
}

extension AlarmVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if currentPage < page {
                return alarmArray.count + 1
            } else {
                return alarmArray.count
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let title = tableView.dequeueReusableCell(withIdentifier: AlarmTitleTVC.identifier, for: indexPath) as? AlarmTitleTVC else { return UITableViewCell() }
            
            return title
        } else {
            if currentPage < page {
                if indexPath.row == alarmArray.count {
                    guard let more = tableView.dequeueReusableCell(withIdentifier: AlarmMoreTVC.identifier, for: indexPath) as? AlarmMoreTVC else { return UITableViewCell() }
                    
                    more.delegate = self
                    return more
                } else {
                    guard let alarm = tableView.dequeueReusableCell(withIdentifier: AlarmTVC.identifier, for: indexPath) as? AlarmTVC else { return UITableViewCell() }
                    
                    alarm.setInformations(type: alarmArray[indexPath.row].type, profileImg: alarmArray[indexPath.row].profileImg, question: alarmArray[indexPath.row].questionTitle, nickName: alarmArray[indexPath.row].userNickname)
                    return alarm
                }
            } else {
                guard let alarm = tableView.dequeueReusableCell(withIdentifier: AlarmTVC.identifier, for: indexPath) as? AlarmTVC else { return UITableViewCell() }
                
                alarm.setInformations(type: alarmArray[indexPath.row].type, profileImg: alarmArray[indexPath.row].profileImg, question: alarmArray[indexPath.row].questionTitle, nickName: alarmArray[indexPath.row].userNickname)
                return alarm
            }
        }
    }
}

extension AlarmVC: UITableViewButtonSelectedDelegate {
    func exploreMoreAnswersButtonDidTapped() {
        currentPage += 1
        getAlarms()
    }
}

extension AlarmVC: UITableViewDelegate {
    
}