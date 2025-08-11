//
//  String+Base64Decode.swift
//  BabbleBuddyApp
//
//  Created by Noel Hiram Pat Angulo on 8/11/25.
//

import Foundation

extension String {
    func base64DecodedString() -> String? {
        var s = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let pad = 4 - (s.count % 4)
        if pad < 4 { s.append(String(repeating: "=", count: pad)) }
        guard let data = Data(base64Encoded: s) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
