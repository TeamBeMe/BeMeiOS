//
//  AnswerModifyService.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/08.
//

import Foundation
import Alamofire

struct AnswerModifyService {
    static let shared = AnswerModifyService()
    
    func modify(answerID: Int,content: String,commentBlocked: Bool,isPublic:Bool,
               completion : @escaping (NetworkResult<Any>) -> (Void) ){
        let url = APIConstants.answerModifyURL
        
        let header : HTTPHeaders = [
            "Content-Type":"application/json",
            "token":UserDefaults.standard.string(forKey: "token")!
        ]
        
        let body : Parameters = [
            "answer_id" : answerID,
            "content": content,
            "is_comment_blocked" : commentBlocked,
            "is_public": isPublic
            
        ]
        
        let dataRequest = AF.request(url,
                                     method: .put,
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
        guard let decodedData = try? decoder.decode(GenericResponse<Int>.self, from : data) else{
            
            
            return .pathErr
            
        }
        
        switch status{
        case 200..<300:
            print("답변 수정 성공")
            NotificationCenter.default.post(name: .answerPop, object: nil)
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
