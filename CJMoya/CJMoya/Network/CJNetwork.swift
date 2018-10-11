//
//  CJNetwork.swift
//  CJMoya
//
//  Created by 陈吉 on 2018/10/11.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import Foundation
import Moya
import Alamofire

typealias Success = (_ data: Data) -> Void
typealias Fail = (_ error: MoyaError) -> Void

class CJNetwork {
    //避免重复请求
    private let barrierQueue = DispatchQueue(label: "cn.Queue.CJNetwork", attributes: .concurrent)
    private var requestKeys = [String]()
    
    @discardableResult
    func request<R: TargetType & MoyaAddable>(_ type: R, success: @escaping Success, fail: Fail? = .none) -> Cancellable? {
        //避免重复请求
        if isSameRequest(type) {
            return nil
        }
        let provider = createProvider(type)
        let cancelLable = provider.request(type) { (response) in
            self.cleanRequest(type)
            switch response {
            case let .success(response):
//                if self.handleResponseData(response.data) {
                    success(response.data)
//                }
            case let .failure(error):
                if let failBlock = fail {
                    failBlock(error)
                }
                MBProgressHUD.showMessage(error.errorDescription ?? "未知错误")
            }
        }
        return cancelLable
        
    }
    
    //解析response
    func handleResponseData(_ data: Data) -> Bool {
        if let response: CJResponse = data.toModel(modelType: CJResponse.self) {
            if handleHttpCode(response.httpCode) {
                return true
            } else {
                MBProgressHUD.showMessage(response.msg)
            }
        }
        return false
    }
    func handleHttpCode(_ code: Int) -> Bool {
        if code == cjResponseCode.successCode {
            return true
        } else {
            return false
        }
    }
}

extension CJNetwork {
    private func isSameRequest<R: TargetType & MoyaAddable>(_ type: R) -> Bool {
        switch type.task {
        case let .requestParameters(parameters, _):
            //这里只对带parameter参数的接口进行判断
            let key = type.path + parameters.description
            var result: Bool!
            barrierQueue.sync(flags: .barrier) {
                result = requestKeys.contains(key)
                if !result {
                    requestKeys.append(key)
                }
            }
            return result
        default:
            return false
        }
    }
    
    //请求结束后清除该请求
    private func cleanRequest<R: TargetType & MoyaAddable>(_ type: R) {
        switch type.task {
        case let .requestParameters(parameters, _):
            let key = type.path + parameters.description
            barrierQueue.sync(flags: .barrier) {
                if let index = requestKeys.index(of:key) {
                    requestKeys.remove(at: index)
                }
            }
        default:
            break
        }
    }
    
    private func createProvider<M: TargetType & MoyaAddable>(_ type: M) -> MoyaProvider<M> {
        let activityPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
            DispatchQueue.main.async {
                switch changeType {
                case .began:
                    if type.isShowHud {
                        MBProgressHUD.showLoading()
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                case .ended:
                    if type.isShowHud {
                        MBProgressHUD.dismiss()
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
        
        let provider = MoyaProvider<M>.init(manager: DefaultAlamofireManager.shareManager, plugins: [activityPlugin, NetworkLoggerPlugin.init(verbose: type.isOpenLog, cURL: type.isOpenLog)])
        return provider
    }
}

final class DefaultAlamofireManager: Alamofire.SessionManager {
    static var shareManager: DefaultAlamofireManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 10
        return DefaultAlamofireManager(configuration: configuration)
    }
}
