require_relative 'Command'
require_relative 'MoveFileCommand'
#Renaming is the same as moving so we're just calling move file to save some time.
class RenameFileCommand < Command 
    
    attr_accessor(:path_to_file, :newpath, :thedescription, :can_undo, :actualfunc)

        def initialize(oldfile, newfile)
            super()
            self.path_to_file = oldfile
            self.newpath = newfile 
            self.thedescription = "Renaming: #{@path_to_file} -> #{@newpath}" 
        end
    
        def execute()
            self.actualfunc = MoveFileCommand.new(@path_to_file, @newpath)
            self.actualfunc.execute()

        end
    
        def undo()
            self.actualfunc.undo()
        end
    
    end