
import Foundation

// Replace Global Reference with Getter
// See: Working Effectively W. Legacy Code, Chapter 25, Replace Global Reference with Getter


/**
 Steps To Replace Global Reference with Getter, do the following:

 1. Identify the global reference that you want to replace.

 2. Write a getter for the global reference. Make sure that the access protection of the method is loose enough for you to be able to override the getter in a subclass.

 3. Replace references to the global with calls to the getter.

 4. Create a testing subclass and override the getter.
 
**/

struct Item {
    var name: String
}

class Inventory {
    static let shared = Inventory()
    fileprivate init() { }
    
    func itemFor(_ barcode: String) -> Item {
        return Item(name: "Inventory: \(barcode)")
    }
}

class RegisterSale {
    var items: [Item] = []
    
    /// ~~~
    /// // Before refactor
    /// func addItem(barcode: String) {
    ///    let item = Inventory.shared.itemFor(barcode)
    ///    items += [item]
    /// }
    /// ~~~
    /// - Parameter barcode: the barcode
    func addItem(barcode: String) {
        let item = inventory.itemFor(barcode)
        items += [item]
    }
    
    fileprivate var inventory: Inventory {
        return Inventory.shared
    }
}

class FakeInventory: Inventory {
    override func itemFor(_ barcode: String) -> Item {
        return Item(name: "FakeInventory: \(barcode)")
    }
}

class FakeRegisterSale: RegisterSale {
    override var inventory: Inventory {
        return FakeInventory()
    }
}

let register = RegisterSale()
