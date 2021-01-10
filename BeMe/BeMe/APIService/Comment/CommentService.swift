//
//  CommentService.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/10.
//

import Foundation
import Alamofire

struct CommentService {
    static let shared = CommentService()
    
    func postComment(answerId: Int, content: String, parentId: Int?, isPublic: Bool, completion: @escaping (NetworkResult<Any>) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token") ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjEwMDk5MjQwLCJleHAiOjE2MzYwMTkyNDAsImlzcyI6ImJlbWUifQ.JeYfzJsg-kdatqhIOqfJ4oXUvUdsiLUaGHwLl1mJRvQ"
        
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "token": token
        ]
        
        var params: Parameters = [:]
        
        if let pi = parentId {
            params = [
                "answer_id" : 1,
                "content": content,
                "is_public" : isPublic,
                "parent_id" : pi
            ]
        } else {
            params = [
                "answer_id" : 1,
                "content": content,
                "is_public" : isPublic
            ]
        }
        
        let url = APIConstants.answerCommentURL
        
        print(url)
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: params,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest
            .validate(statusCode: 200..<500)
            .responseData { (response) in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let value = response.value else { return }
                    
                    let networkResult = self.judge(by: statusCode, value)
                    
                    completion(networkResult)
                case .failure: completion(.networkFail)
                }
            }
    }
    
    private func judge(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()

        guard let decodedData = try? decoder.decode(GenericResponse<Comment>.self, from : data) else { return .pathErr }
        
        switch statusCode {
        case 200..<300: return .success(decodedData)
        case 400..<500: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}

