//
//  BabiesServiceProtocol.swift
//  BabiesListAndRegistration
//
//  Created by Noel Hiram Pat Angulo on 6/16/25.
//

public protocol BBABabiesServiceProtocol {
    func fetchBabies() async throws -> [BabiesResponseProtocol]
    func fetchBaby(with key: String) async throws -> CreateBabyResponseProtocol
    func createBaby(request: CreateBabyRequestProtocol) async throws -> CreateBabyResponseProtocol
    func editBaby(request: EditBabyRequestProtocol) async throws -> Bool
    func deleteBaby(request: DeleteBabyRequestProtocol) async throws -> Bool
}
