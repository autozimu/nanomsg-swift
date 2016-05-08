import CNanomsg

public extension Socket {

    enum OptLevel: CInt {
        case SOL = 0
    }

    enum OptEnum: CInt {
        case LINGER = 1
        case SNDBUF = 2
        case RCVBUF = 3
        case SNDTIMEO = 4
        case RCVTIMEO = 5
        case RECONNECT_IVL = 6
        case RECONNECT_IVL_MAX = 7
        case SNDPRIO = 8
        case RCVPRIO = 9
        case SNDFD = 10
        case RCVFD = 11
        case DOMAIN = 12
        case PROTOCOL = 13
        case IPV4ONLY = 14
        case SOCKET_NAME = 15
        case RCVMAXSIZE = 16
    }

    func getopt(_ opt: OptEnum) -> CInt {
        var value: CInt = -1
        var size = sizeof(CInt)
        nn_getsockopt(socketid,
            OptLevel.SOL.rawValue, opt.rawValue,
            &value, &size)
        return value
    }

    func setopt(_ opt: OptEnum, _ newValue: CInt) {
        var newValue = newValue
        nn_setsockopt(socketid,
            OptLevel.SOL.rawValue, opt.rawValue,
            &newValue, sizeof(CInt))
    }

    var linger: CInt {
        get { return getopt(OptEnum.LINGER) }
        set { setopt(OptEnum.LINGER, newValue) }
    }

    var sndbuf: CInt {
        get { return getopt(OptEnum.SNDBUF)  }
        set { setopt(OptEnum.SNDBUF, newValue) }
    }

    var rcvbuf: CInt {
        get { return getopt(OptEnum.RCVBUF) }
        set { setopt(OptEnum.RCVBUF, newValue) }
    }

    var rcvmaxsize: CInt {
        get { return getopt(OptEnum.RCVMAXSIZE) }
        set { setopt(OptEnum.RCVMAXSIZE, newValue) }
    }

    var sndtimeo: CInt {
        get { return getopt(OptEnum.SNDTIMEO) }
        set { setopt(OptEnum.SNDTIMEO, newValue) }
    }

    var rcvtimeo: CInt {
        get { return getopt(OptEnum.RCVTIMEO) }
        set { setopt(OptEnum.RCVTIMEO, newValue) }
    }

    var reconnect_ivl: CInt {
        get { return getopt(OptEnum.RECONNECT_IVL) }
        set { setopt(OptEnum.RECONNECT_IVL, newValue) }
    }

    var reconnect_ivl_max: CInt {
        get { return getopt(OptEnum.RECONNECT_IVL_MAX) }
        set { setopt(OptEnum.RECONNECT_IVL_MAX, newValue) }
    }

    var sndprio: CInt {
        get { return getopt(OptEnum.SNDPRIO) }
        set { setopt(OptEnum.SNDPRIO, newValue) }
    }

    var rcvprio: CInt {
        get { return getopt(OptEnum.RCVPRIO) }
        set { setopt(OptEnum.RCVPRIO, newValue) }
    }

    var ipv4only: CInt {
        get { return getopt(OptEnum.IPV4ONLY) }
        set { setopt(OptEnum.IPV4ONLY, newValue) }
    }

    var name: String {
        get {
            var sz = 100
            let value = UnsafeMutablePointer<CChar>(allocatingCapacity: sz)
            nn_getsockopt(socketid,
                OptLevel.SOL.rawValue, OptEnum.SOCKET_NAME.rawValue,
                value, &sz)
            return String(cString: value)
        }
        set {
            let sz = newValue.characters.count + 1
            nn_setsockopt(socketid,
                OptLevel.SOL.rawValue, OptEnum.SOCKET_NAME.rawValue,
                newValue, sz)
        }
    }

    // TODO
    // var sndfd

    // TODO
    // var rcvfd
}
