//: [Previous](@previous)

import Foundation

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

