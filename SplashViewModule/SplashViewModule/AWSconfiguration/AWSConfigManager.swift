import Foundation
import AWSMobileClientXCF

class AWSConfigManager {
    static let shared = AWSConfigManager()

    private init() {}

    func loadConfig() -> [String: Any]? {

        guard let path = Bundle.main.path(forResource: "AWSConfig", ofType: "plist"),
              let data = FileManager.default.contents(atPath: path) else {
            return nil
        }
        do {
            return try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any]
        } catch {
            return nil
        }
    }

    func createAWSConfigurationFile() throws -> URL {
        guard let config = loadConfig(),
              let poolId = config["cognitoPoolId"] as? String,
              let clientId = config["cognitoClientId"] as? String,
              let clientSecret = config["cognitoSecret"] as? String
        else {
            throw NSError(domain: "AWSConfigError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid config"])
        }
        let awsConfig: [String: Any] = [
            "Version": "1.0",
            "CredentialsProvider": [
                "CognitoIdentity": [
                    "Default": [
                        "PoolId": poolId,
                        "Region": "us-east-2"
                    ]
                ]
            ],
            "CognitoUserPool": [
                "Default": [
                    "PoolId": poolId,
                    "AppClientId": clientId,
                    "AppClientSecret": clientSecret,
                    "Region": "us-east-2"
                ]
            ]
        ]

        let fileManager = FileManager.default
        let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = dir.appendingPathComponent("awsconfiguration.json")

        let jsonData = try JSONSerialization.data(withJSONObject: awsConfig, options: .prettyPrinted)
        try jsonData.write(to: fileURL, options: .atomic)

        return fileURL
    }
}
