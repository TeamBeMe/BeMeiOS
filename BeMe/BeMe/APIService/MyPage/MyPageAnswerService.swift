//
//  MyPageAnswerService.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/13.
//

import Foundation
import Alamofire

struct MyPageAnswerService {
    static let shared = MyPageAnswerService()
    
    // getMyAnswer - overLoading Method : 쿼리 개수에 따라서 매개변수 개수가 바뀜 
    func getMyAnswer(availability: String?, category: Int?, query: String?, page: Int, completion : @escaping (NetworkResult<Any>) -> (Void) ){
        
        var availability = availability == nil ? "all" : availability
//        var category = availability == nil ? "all" : availability
//        var query = availability == nil ? "all" : availability
        var page = availability == nil ? -1 : page
        
        // page deault -> 0
        let url = APIConstants.myPageAnswerURL+"?page="+String(page)
        
        let header : HTTPHeaders = [
            "Content-Type":"application/json",
//            "token":UserDefaults.standard.string(forKey: "token")!
            "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjA5Nzc3ODg2LCJleHAiOjE2MzU2OTc4ODYsImlzcyI6ImJlbWUifQ.34mc263uDc9vYq9N8BVzfqVdsgKzL51Ld03kB0afcSQ"
        ]

        
        let dataRequest = AF.request(url,
                                     method: .get,
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
        guard let decodedData = try? decoder.decode(GenericResponse<MyAnswer>.self, from : data) else{
            print("디코딩 실패")
            return .pathErr
        }
        
        switch status{
        case 200..<300:
            print("통신 성공")
//            print(decodedData.message)
            print(decodedData.data?.answers[0].isScrapped)
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

