//
//  BabiesServiceProtocol.swift
//  BabiesListAndRegistration
//
//  Created by Noel Hiram Pat Angulo on 6/16/25.
//

public protocol BBAServiceProtocol {
    func fetchBabies() async throws -> [BabiesResponseProtocol]

    func createBaby(request: CreateBabyRequestProtocol) async throws -> CreateBabyResponseProtocol
}
