import Foundation
import XCTest
@testable import MessagePack

class ArrayTests: XCTestCase {
    static var allTests = {
        return [
            ("testLiteralConversion", testLiteralConversion),
            ("testPackFixarray", testPackFixarray),
            ("testUnpackFixarray", testUnpackFixarray),
            ("testPackArray16", testPackArray16),
            ("testUnpackArray16", testUnpackArray16),
        ]
    }()

    func testLiteralConversion() {
        let implicitValue: MessagePackValue = [0, 1, 2, 3, 4]
        let payload: [MessagePackValue] = [.uint64(0), .uint64(1), .uint64(2), .uint64(3), .uint64(4)]
        XCTAssertEqual(implicitValue, .array(payload))
    }

    func testPackFixarray() {
        let value: [MessagePackValue] = [.uint8(0), .uint8(1), .uint8(2), .uint8(3), .uint8(4)]
        let packed = Data([0x95, 0x00, 0x01, 0x02, 0x03, 0x04])
        XCTAssertEqual(pack(.array(value)), packed)
    }

    func testUnpackFixarray() {
        let packed = Data([0x95, 0x00, 0x01, 0x02, 0x03, 0x04])
        let value: [MessagePackValue] = [.uint64(0), .uint64(1), .uint64(2), .uint64(3), .uint64(4)]

        let unpacked = try? unpack(packed)
        XCTAssertEqual(unpacked?.value, .array(value))
        XCTAssertEqual(unpacked?.remainder.count, 0)
    }

    func testPackArray16() {
        let value = [MessagePackValue](repeating: nil, count: 16)
        let packed = Data([0xdc, 0x00, 0x10] + [UInt8](repeating: 0xc0, count: 16))
        XCTAssertEqual(pack(.array(value)), packed)
    }

    func testUnpackArray16() {
        let packed = Data([0xdc, 0x00, 0x10] + [UInt8](repeating: 0xc0, count: 16))
        let value = [MessagePackValue](repeating: nil, count: 16)

        let unpacked = try? unpack(packed)
        XCTAssertEqual(unpacked?.value, .array(value))
        XCTAssertEqual(unpacked?.remainder.count, 0)
    }
}
