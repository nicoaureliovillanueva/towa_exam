//
//  TowaTestHelper.swift
//  towa-examTests
//
//  Created by Nico Aurelio Villanueva on 7/10/22.
//


import Foundation
import Nimble
import ObjectMapper
import towa_exam


final class TowaTestHelper {
    
    class func loadJSON(withName name: String) throws -> Data {
        
        let bundle = Bundle(for: TowaTestHelper.self)
        guard let readablePath = bundle.path(forResource: name, ofType: "json") else {
            throw CocoaError(.fileNoSuchFile)
        }
        
        let path = URL(fileURLWithPath: readablePath)
        
        let data = try Data(contentsOf: path)
        return data
    }
    
    class func mapModelFromJSON<T: Mappable>(filename: String, model: T.Type) -> T? {
        let bundle = Bundle(for: TowaTestHelper.self)

        if let path = bundle.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                return T(JSON: result ?? [:])
            } catch {
                print("\(filename): ", error.localizedDescription)
                return nil
            }
        }

        return nil
    }

    class func loadCodableFromJSON<T: Codable>(withName name: String) throws -> T {
        let decoder = JSONDecoder()
        let data = try loadJSON(withName: name)
        let model = try decoder.decode(T.self, from: data)
        
        return model
    }
    
    class func loadJSONArray<T: Codable>(withName name: String) throws -> [T] {
        let decoder = JSONDecoder()
        let data = try loadJSON(withName: name)
        let model = try decoder.decode([T].self, from: data)
        
        return model
    }
    
    // MARK: Resource<T> case check
    class func beNone<T>() -> Predicate<Resource<T>> {
        return Predicate.define("be <none>") { expression, message in
            if let actual = try expression.evaluate(), case .none = actual {
                return PredicateResult(status: .matches, message: message)
            }
            return PredicateResult(status: .fail, message: message)
        }
    }
    
    class func beEmpty<T>() -> Predicate<Resource<T>> {
        return Predicate.define("be <empty>") { expression, message in
            if let actual = try expression.evaluate(), case .empty = actual {
                return PredicateResult(status: .matches, message: message)
            }
            return PredicateResult(status: .fail, message: message)
        }
    }
    
    class func beLoading<T>() -> Predicate<Resource<T>> {
        return Predicate.define("be <loading>") { expression, message in
            if let actual = try expression.evaluate(), case .loading = actual {
                return PredicateResult(status: .matches, message: message)
            }
            return PredicateResult(status: .fail, message: message)
        }
    }
    
    class func beSuccess<T>(dataCheck: @escaping (T) -> Void = { _ in }) -> Predicate<Resource<T>> {
        return Predicate.define("be <success>") { expression, message in
            if let actual = try expression.evaluate(),
                case let .success(data) = actual {
                dataCheck(data)
                return PredicateResult(status: .matches, message: message)
            }
            return PredicateResult(status: .fail, message: message)
        }
    }
    
    class func beError<T>(_ errorMessage: String) -> Predicate<Resource<T>> {
        return Predicate.define("be <error>") { expression, message in
            if let actual = try expression.evaluate(),
                case let .error(msg) = actual,
                msg == errorMessage {
                return PredicateResult(status: .matches, message: message)
            }
            return PredicateResult(status: .fail, message: message)
        }
    }
}

