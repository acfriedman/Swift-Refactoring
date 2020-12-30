
import Foundation

// Extract and Override Factory Method
// See: Working Effectively W. Legacy Code, Chapter 25, Extract and Override Call

/**
 Steps
 To Extract and Override Factory Method, follow these steps:

 1. Identify an object creation in a constructor.

 2. Extract all of the work involved in the creation into a factory method.

 3. Create a testing subclass and override the factory method in it to avoid dependencies on problematic types under test.
*/

struct StyleTemplate {
    private(set) var type: String
    init(type: String) {
        self.type = type
    }
}

struct StyleMaster {
    var template: StyleTemplate
    init(template: StyleTemplate) {
        self.template = template
    }
}

class PageLayout {
    private(set) var styleMaster: StyleMaster!
    
    
    ///~~~
    ///// Before refactor:
    ///init() {
    ///    styleMaster = StyleMaster(template: StyleTemplate(type: "default"))
    /// }
    ///~~~
    init() {
        styleMaster = makeStyleMaster()
    }
    
    fileprivate func makeStyleMaster() -> StyleMaster {
        return StyleMaster(template: StyleTemplate(type: "default"))
    }
}

class FakePageLayout: PageLayout {
    override func makeStyleMaster() -> StyleMaster {
        return StyleMaster(template: StyleTemplate(type: "FakeLayout"))
    }
}


let layout = FakePageLayout()
assert(layout.styleMaster.template.type == "FakeLayout")


