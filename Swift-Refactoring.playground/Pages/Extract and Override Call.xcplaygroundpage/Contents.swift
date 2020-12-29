import Foundation

// Extract and Override Call
// See: Working Effectively W. Legacy Code, Part III, Chapter 25, Extract and Override Call


/**
Steps To Extract and Override Call, follow these steps:

1. Identify the call that you want to extract. Find the declaration of its method. Copy its method signature so that you can Preserve Signatures (312).

2. Create a new method on the current class. Give it the signature you’ve copied.

3. Copy the call to the new method and replace the call with a call to the new method.
 
**/

struct StyleTemplate {
    
}

struct StyleMaster {
    static func formStyles(_ template: StyleTemplate, _ id: Int) -> [String] {
        return [""]
    }
}

class PageLayout {
    private var id: Int
    private var styles: [String]
    private var template: StyleTemplate
    
    init(id: Int, styles: [String], template: StyleTemplate) {
        self.id = id
        self.styles = styles
        self.template = template
    }
    
    func getStyles() -> [String] {
        return styles
    }
    
    /// Step 1: This originally looked like:
    ///
    /// ~~~
    /// func rebindStyles() {
    ///    styles = StyleMaster.formStyles(template, id)
    /// }
    /// ~~~
    func rebindStyles() {
        styles = formStyles(template, id)
    }
    
    // Step 2 and 3
    // Note: Having fileprivate allows us to hide private method calls from the rest of the project
    // but also create fakable classes within that file to get parts of code under test.
    fileprivate func formStyles(_ template: StyleTemplate, _ id: Int) -> [String] {
        return StyleMaster.formStyles(template, id)
    }
}

class FakePageLayout: PageLayout {
    override func formStyles(_ template: StyleTemplate, _ id: Int) -> [String] {
        return ["Hello World"]
    }
}



var layout = PageLayout(id: 0, styles: [], template: StyleTemplate())

if layout.getStyles() == [] {
    print("A")
}

layout.rebindStyles()
if layout.getStyles() == [""] {
    print("B")
}

var fakeLayout = FakePageLayout(id: 0, styles: [], template: StyleTemplate())

if fakeLayout.getStyles() == [] {
    print("A")
}

fakeLayout.rebindStyles()
if fakeLayout.getStyles() == ["Hello World"] {
    print("B")
}
