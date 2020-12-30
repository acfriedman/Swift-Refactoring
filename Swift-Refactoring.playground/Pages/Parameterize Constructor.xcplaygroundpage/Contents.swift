
import Foundation

// Parameterize Constructor
// See: Working Effectively W. Legacy Code, Chapter 25, Parameterize Constructor


/**
 Steps To Parameterize Constructor, follow these steps:

 1. Identify the constructor that you want to parameterize and make a copy of it.

 2. Add a parameter to the constructor for the object whose creation you are going to replace. Remove the object creation and add an assignment from the parameter to the instance variable for the object.

 3. If you can call a constructor from a constructor in your language, remove the body of the old constructor and replace it with a call to the old constructor. Add a new expression to the call of the new constructor in the old constructor. If you can’t call a constructor from another constructor in your language, you may have to extract any duplication among the constructors to a new method.
 
**/

class MailReciever {
    
}

class MailChecker {
    private var checkInterval: Int
    private var reciever: MailReciever
    
    /// ~~~
    /// // Before refactor:
    /// init(checkInterval: Int) {
    ///     self.reciever = MailReciever()
    ///     self.checkInterval = checkInterval
    ///}
    /// ~~~
    /// - Parameter checkInterval:
    convenience init(checkInterval: Int) {
        self.init(reciever: MailReciever(), checkInterval: checkInterval)
    }
    
    init(reciever: MailReciever, checkInterval: Int) {
        self.reciever = reciever
        self.checkInterval = checkInterval
    }
}

let checker = MailChecker(checkInterval: 0)

