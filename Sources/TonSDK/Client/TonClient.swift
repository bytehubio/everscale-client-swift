//
//  Created by Oleh Hudeichuk on 18.10.2020.
//

import Foundation

public final class TSDKClient {

    private let binding: TSDKBinding
    public var crypto: TSDKCrypto

    public init(config: TSDKClientConfig) {
        self.binding = TSDKBinding(config: config)
        self.crypto = TSDKCrypto(binding: binding)
    }

    public func destroy() {
        binding
    }
}
