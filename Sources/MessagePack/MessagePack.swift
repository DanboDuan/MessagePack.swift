import Foundation

/// The MessagePackValue enum encapsulates one of the following types: Nil, Bool, Int, UInt, Float, Double, String, Binary, Array, Map, and Extended.
public enum MessagePackValue {
    case `nil`
    case bool(Bool)
    case int8(Int8)
    case int16(Int16)
    case int32(Int32)
    case int64(Int64)
    case uint8(UInt8)
    case uint16(UInt16)
    case uint32(UInt32)
    case uint64(UInt64)
    case float(Float)
    case double(Double)
    case string(String)
    case binary(Data)
    case array([MessagePackValue])
    case map([MessagePackValue: MessagePackValue])
    case extended(Int8, Data)
}

extension MessagePackValue: CustomStringConvertible {
    public var description: String {
        switch self {
        case .nil:
            return "nil"
        case .bool(let value):
            return "bool(\(value))"
        case .int8(let value):
            return "int8(\(value))"
        case .int16(let value):
            return "int16(\(value))"
        case .int32(let value):
            return "int32(\(value))"
        case .int64(let value):
            return "int64(\(value))"
        case .uint8(let value):
            return "uint8(\(value))"
        case .uint16(let value):
            return "uint16(\(value))"
        case .uint32(let value):
            return "uint32(\(value))"
        case .uint64(let value):
            return "uint64(\(value))"
        case .float(let value):
            return "float(\(value))"
        case .double(let value):
            return "double(\(value))"
        case .string(let string):
            return "string(\(string))"
        case .binary(let data):
            return "data(\(data))"
        case .array(let array):
            return "array(\(array.description))"
        case .map(let dict):
            return "map(\(dict.description))"
        case .extended(let type, let data):
            return "extended(\(type), \(data))"
        }
    }
}

public extension MessagePackValue {
    var rawIntegerValueStringRepresentation: String? {
        switch self {
        case .int8(let value):
            return value.description
        case .int16(let value):
            return value.description
        case .int32(let value):
            return value.description
        case .int64(let value):
            return value.description
        case .uint8(let value):
            return value.description
        case .uint16(let value):
            return value.description
        case .uint32(let value):
            return value.description
        case .uint64(let value):
            return value.description
        default:
            return nil
        }
    }
}

extension MessagePackValue: Equatable {
    public static func ==(lhs: MessagePackValue, rhs: MessagePackValue) -> Bool {
        switch (lhs, rhs) {
        case (.nil, .nil):
            return true
        case (.bool(let lhv), .bool(let rhv)):
            return lhv == rhv
        case (.float(let lhv), .float(let rhv)):
            return lhv == rhv
        case (.double(let lhv), .double(let rhv)):
            return lhv == rhv
        case (.string(let lhv), .string(let rhv)):
            return lhv == rhv
        case (.binary(let lhv), .binary(let rhv)):
            return lhv == rhv
        case (.array(let lhv), .array(let rhv)):
            return lhv == rhv
        case (.map(let lhv), .map(let rhv)):
            return lhv == rhv
        case (.extended(let lht, let lhb), .extended(let rht, let rhb)):
            return lht == rht && lhb == rhb
        default:
            if let lhr = lhs.rawIntegerValueStringRepresentation,
               let rhr = rhs.rawIntegerValueStringRepresentation
            {
                return lhr == rhr
            }
            return false
        }
    }
}

extension MessagePackValue: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }

    public var hashValue: Int {
        switch self {
        case .nil: return 0
        case .bool(let value): return value.hashValue
        case .int8(let value): return value.hashValue
        case .int16(let value): return value.hashValue
        case .int32(let value): return value.hashValue
        case .int64(let value): return value.hashValue
        case .uint8(let value): return value.hashValue
        case .uint16(let value): return value.hashValue
        case .uint32(let value): return value.hashValue
        case .uint64(let value): return value.hashValue
        case .float(let value): return value.hashValue
        case .double(let value): return value.hashValue
        case .string(let string): return string.hashValue
        case .binary(let data): return data.count
        case .array(let array): return array.count
        case .map(let dict): return dict.count
        case .extended(let type, let data): return 31 &* type.hashValue &+ data.count
        }
    }
}

public enum MessagePackError: Error {
    case invalidArgument
    case insufficientData
    case invalidData
}
