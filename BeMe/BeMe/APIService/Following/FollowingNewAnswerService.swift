//
//  LogInService.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/06.
//

import Foundation
import Alamofire

struct FollowingNewAnswerService{
    static let shared = FollowingNewAnswerService()
    
    func getNewData(questionID: Int, completion : @escaping (NetworkResult<Any>) -> (Void) ){
        let url = APIConstants.followingNewAnswerURL
        
        let header : HTTPHeaders = [
            "Content-Type":"application/json",
            "token":UserDefaults.standard.string(forKey: "token")!
        ]
        
        let body : Parameters = [
            "question_id": questionID
        ]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        
        dataRequest.responseData{ response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else{
                    return
                }
                guard let data = response.value else{
                    return
                    
                }
               
                completion(judge(status: statusCode, data: data))
                
                
                
                
                
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
            
        }
        
        
        
    }
    
    private func judge(status : Int, data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<FollowingNewAnswerData>.self, from : data) else{
            
            
            return .pathErr
            
        }
        
        switch status{
        case 200..<300:
           
            print("성공성공")
            
            return .success(decodedData.data)
        case 400..<500 :
            return .requestErr(decodedData.message)
        case 500 :
            return .serverErr
            
        default :
            return .networkFail
            
            
        }
        
        
    }

}
