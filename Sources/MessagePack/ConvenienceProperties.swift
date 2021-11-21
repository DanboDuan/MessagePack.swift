import Foundation

public extension MessagePackValue {
    /// The number of elements in the `.Array` or `.Map`, `nil` otherwise.
    var count: Int? {
        switch self {
        case .array(let array):
            return array.count
        case .map(let dict):
            return dict.count
        default:
            return nil
        }
    }

    /// The element at subscript `i` in the `.Array`, `nil` otherwise.
    subscript(i: Int) -> MessagePackValue? {
        switch self {
        case .array(let array):
            return i < array.count ? array[i] : Optional.none
        default:
            return nil
        }
    }

    /// The element at keyed subscript `key`, `nil` otherwise.
    subscript(key: MessagePackValue) -> MessagePackValue? {
        switch self {
        case .map(let dict):
            return dict[key]
        default:
            return nil
        }
    }

    /// True if `.Nil`, false otherwise.
    var isNil: Bool {
        switch self {
        case .nil:
            return true
        default:
            return false
        }
    }

    // MARK: Signed integer values

    /// The signed 8-bit integer value if `.int` or an appropriately valued
    /// `.uint`, `nil` otherwise.
    var int8Value: Int8? {
        if let raw = rawIntegerValueStringRepresentation {
            return Int8(raw)
        }
        return nil
    }

    /// The signed 16-bit integer value if `.int` or an appropriately valued
    /// `.uint`, `nil` otherwise.
    var int16Value: Int16? {
        if let raw = rawIntegerValueStringRepresentation {
            return Int16(raw)
        }
        return nil
    }

    /// The signed 32-bit integer value if `.int` or an appropriately valued
    /// `.uint`, `nil` otherwise.
    var int32Value: Int32? {
        if let raw = rawIntegerValueStringRepresentation {
            return Int32(raw)
        }
        return nil
    }

    /// The signed 64-bit integer value if `.int` or an appropriately valued
    /// `.uint`, `nil` otherwise.
    var int64Value: Int64? {
        if let raw = rawIntegerValueStringRepresentation {
            return Int64(raw)
        }
        return nil
    }

    // MARK: Unsigned integer values

    /// The unsigned 8-bit integer value if `.uint` or an appropriately valued
    /// `.int`, `nil` otherwise.
    var uint8Value: UInt8? {
        if let raw = rawIntegerValueStringRepresentation {
            return UInt8(raw)
        }
        return nil
    }

    /// The unsigned 16-bit integer value if `.uint` or an appropriately valued
    /// `.int`, `nil` otherwise.
    var uint16Value: UInt16? {
        if let raw = rawIntegerValueStringRepresentation {
            return UInt16(raw)
        }
        return nil
    }

    /// The unsigned 32-bit integer value if `.uint` or an appropriately valued
    /// `.int`, `nil` otherwise.
    var uint32Value: UInt32? {
        if let raw = rawIntegerValueStringRepresentation {
            return UInt32(raw)
        }
        return nil
    }

    /// The unsigned 64-bit integer value if `.uint` or an appropriately valued
    /// `.int`, `nil` otherwise.
    var uint64Value: UInt64? {
        if let raw = rawIntegerValueStringRepresentation {
            return UInt64(raw)
        }
        return nil
    }

    /// The contained array if `.Array`, `nil` otherwise.
    var arrayValue: [MessagePackValue]? {
        switch self {
        case .array(let array):
            return array
        default:
            return nil
        }
    }

    /// The contained boolean value if `.Bool`, `nil` otherwise.
    var boolValue: Bool? {
        switch self {
        case .bool(let value):
            return value
        default:
            return nil
        }
    }

    /// The contained floating point value if `.Float` or `.Double`, `nil` otherwise.
    var floatValue: Float? {
        switch self {
        case .float(let value):
            return value
        case .double(let value):
            return Float(exactly: value)
        default:
            return nil
        }
    }

    /// The contained double-precision floating point value if `.Float` or `.Double`, `nil` otherwise.
    var doubleValue: Double? {
        switch self {
        case .float(let value):
            return Double(exactly: value)
        case .double(let value):
            return value
        default:
            return nil
        }
    }

    /// The contained string if `.String`, `nil` otherwise.
    var stringValue: String? {
        switch self {
        case .binary(let data):
            return String(data: data, encoding: .utf8)
        case .string(let string):
            return string
        default:
            return nil
        }
    }

    /// The contained data if `.Binary` or `.Extended`, `nil` otherwise.
    var dataValue: Data? {
        switch self {
        case .binary(let bytes):
            return bytes
        case .extended(_, let data):
            return data
        default:
            return nil
        }
    }

    /// The contained type and data if Extended, `nil` otherwise.
    var extendedValue: (Int8, Data)? {
        if case .extended(let type, let data) = self {
            return (type, data)
        } else {
            return nil
        }
    }

    /// The contained type if `.Extended`, `nil` otherwise.
    var extendedType: Int8? {
        if case .extended(let type, _) = self {
            return type
        } else {
            return nil
        }
    }

    /// The contained dictionary if `.Map`, `nil` otherwise.
    var dictionaryValue: [MessagePackValue: MessagePackValue]? {
        if case .map(let dict) = self {
            return dict
        } else {
            return nil
        }
    }
}
