throw DragonError.DragonIsMissing

enum DragonError: ErrorType {
    case DragonIsMissing
    case NotEnoughMana(manaRequired: Int)
    ...
}
