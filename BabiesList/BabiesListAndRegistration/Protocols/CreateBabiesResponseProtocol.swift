//
//  CreateBabiesResponseProtocol.swift
//  BabiesListAndRegistration
//
//  Created by Noel Hiram Pat Angulo on 7/9/25.
//

public protocol CreateBabyResponseProtocol: Decodable {
    var partitionKey: String { get }
    var rangeKey: String { get }
    var title: String { get }
    var babyDescription: String { get }
    var metadata: String { get }
    var type: String { get }
    var created: String { get }
    var modified: String { get }
    var status: String { get }
}
