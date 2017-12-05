require_relative 'Command'
require_relative 'MoveDirectoryCommand'

class RenameDirectoryCommand < Command 
    
    attr_accessor(:path, :newpath, :thedescription, :can_undo, :actualfunc)

        def initialize(origpath, freshname)
            super()
            self.path = origpath
            self.newpath = freshname 
            self.thedescription = "Renaming: #{@path} -> #{@newpath}" 
        end
    
        def execute()
            self.actualfunc = MoveDirectoryCommand.new(@path, @newpath)
            self.actualfunc.execute()
        end
    
        def undo()
            self.actualfunc.undo()
        end
    
    end