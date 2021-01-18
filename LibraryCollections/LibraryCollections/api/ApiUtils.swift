import Foundation
import Moya
import RxSwift

public protocol IApiCallback {
    func onSuccess<T>(par1:T)
    func onFail<T>(par1:T)
    func onFinally()
}

public class ApiUtils {
    
    // MARK: - Properties
    public static let API_ERROR_RETRY_COUNT = 3
    
    // MARK: - API Body Handling
    public static func getBodyParams<Type:Codable>(obj:Type) -> [String:Any] {
        var dict: Dictionary<String, Any>? = nil
        
        do {
            let encoder = CommonUtils.getJsonEncoder()
            let data = try encoder.encode(obj)
            
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
        } catch {
            print(error)
        }
        
        return dict ?? [:]
    }
    
    private static func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data //fallback to original data if it cant be serialized
        }
    }
    
    // MARK: - API request
    public static func requestApi<ApiType:TargetType, ResponseType:Codable>(apiType:ApiType
        , manager: Manager = MoyaProvider<Target>.defaultAlamofireManager()
        , responseType:ResponseType.Type
        , onSuccess: @escaping (ResponseType) -> ()
        , onFail:@escaping (NSError) -> ()
        , onFinally:@escaping () -> ()
        , retryCount:Int = ApiUtils.API_ERROR_RETRY_COUNT) -> Disposable {
        
        let apiProvider = MoyaProvider<ApiType>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)], manager: manager)
        var retryCount = retryCount
        
        return privider.rx
            .request(apiType)
            .filterSuccessfulStatusAndRedirectCodes()
            .map(responseType)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { data in
                onSuccess(data)
                onFinally()
            }, onError: { error in
                let moyaError = error as! MoyaError
                var nsError = moyaError.errorUserInfo[NSUnderlyingErrorKey] as! NSError
                
                guard let cfNetworkError = CFNetworkErrors(rawValue: Int32(nsError.code)) else {
                    onFail(nsError)
                    onFinally()
                    return
                }
                
                if retryCount > 0 {
                    retryCount = retryCount - 1
                    let _ = requestApi(apiType: apiType,
                                       responseType: responseType,
                                       onSuccess: onSuccess,
                                       onFail: onFail,
                                       onFinally: onFinally,
                                       retryCount: retryCount)
                } else {
                    var errDomain:String
                    
                    switch cfNetworkError.rawValue {
                    case 302, -1009:
                        errDomain = "Network connection is lost, please check and retry."
                    case -1001:
                        errDomain = "Network connection is unstable, please check and retry."
                    case -2000...1:
                        errDomain = "Unknown network error, please check and retry."
                    default:
                        errDomain = "Service error, please retry again."
                    }

                    nsError = NSError(domain: errDomain, code: -1, userInfo: nil)
                    onFail(nsError)
                    onFinally()
                }
            })
    }
}
