enum GraphEnum {
    case increase
    case decrease
    case all
    
    var imageName: String {
        switch self {
        case .increase:
            return "increaseChart"
        case .decrease:
            return "decreaseChart"
        case .all:
            return "chartMix"
        }
    }
}
