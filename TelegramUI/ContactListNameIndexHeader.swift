import Display

final class ContactListNameIndexHeader: Equatable, ListViewItemHeader {
    let id: Int64
    let theme: PresentationTheme
    let letter: unichar
    let stickDirection: ListViewItemHeaderStickDirection = .top
    
    let height: CGFloat = 29.0
    
    init(theme: PresentationTheme, letter: unichar) {
        self.theme = theme
        self.letter = letter
        self.id = Int64(letter)
    }
    
    func node() -> ListViewItemHeaderNode {
        return ContactListNameIndexHeaderNode(theme: self.theme, letter: self.letter)
    }
    
    static func ==(lhs: ContactListNameIndexHeader, rhs: ContactListNameIndexHeader) -> Bool {
        return lhs.id == rhs.id
    }
}

final class ContactListNameIndexHeaderNode: ListViewItemHeaderNode {
    private var theme: PresentationTheme
    private let letter: unichar
    
    private let sectionHeaderNode: ListSectionHeaderNode
    
    init(theme: PresentationTheme, letter: unichar) {
        self.theme = theme
        self.letter = letter
        
        self.sectionHeaderNode = ListSectionHeaderNode(theme: theme)
        
        super.init()
        
        if let scalar = UnicodeScalar(letter) {
            self.sectionHeaderNode.title = "\(Character(scalar))"
        }
        
        self.addSubnode(self.sectionHeaderNode)
    }
    
    override func layout() {
        self.sectionHeaderNode.frame = CGRect(origin: CGPoint(), size: self.bounds.size)
    }
}
