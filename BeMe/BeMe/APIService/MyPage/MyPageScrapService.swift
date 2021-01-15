//
//  MyPageScrapService.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/13.
//

import Foundation
import Alamofire

struct MyPageScrapService {
    static let shared = MyPageScrapService()
    
    // getMyAnswer - overLoading Method : 쿼리 개수에 따라서 매개변수 개수가 바뀜
    func getMyScrap(availability: String?, category: Int?, query: String?, page: Int, completion : @escaping (NetworkResult<Any>) -> (Void)){
     
        let category = category == nil ? "" : String(category!)
        let availability = availability == nil ? "" : String(availability!)
        let query = query == nil ? "" : String(query!)
        
        
        let url = APIConstants.myPageScrapURL
        
        let params: Parameters = [
            "public": "\(availability)",
            "category": "\(category)",
            "page": "\(page)",
            "query": "\(query)"
        ]
        
        print("getMyScrap URll")
        print(url)
        
        let header : HTTPHeaders = [
            "Content-Type":"application/json",
            "token":UserDefaults.standard.string(forKey: "token")!
        ]
        
        let dataRequest = AF.request(url, method: .get, parameters: params, headers: header)
        
        
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
        guard let decodedData = try? decoder.decode(GenericResponse<MyScrap>.self, from : data) else{
            print("디코딩 실패")
            return .pathErr
        }
        
        switch status{
        case 200..<300:
            print("통신 성공")
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

