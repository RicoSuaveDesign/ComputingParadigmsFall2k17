require_relative 'Command'

class MoveDirectoryCommand < Command 
    
    attr_accessor(:path, :newpath, :thedescription, :can_undo)
        def initialize(origpath, freshpath)
            super()
            self.path = origpath
            self.newpath = freshpath 
            self.thedescription = "Moving: #{@path} -> #{@newpath}" 
        end
    
        def execute()
            if(Dir.exist?(@path) && !Dir.exist?(@newpath))
                FileUtils.mv(@path, @newpath)
                puts "Directory '#{@path}' and its contents moved to #{@newpath}"
                self.can_undo = true
            elsif(!Dir.exist?(@path))
                puts "Directory doesn't exist. There is nothing to move!"
                self.can_undo = false
            elsif(Dir.exist?(@newpath))
                puts "There is already a Directory named '#{@newpath}'. Pick a different name or delete the directory."
                self.can_undo = false
            else
                puts "You managed to do something outside the two main cases. Good job, try again, move failed."
                self.can_undo = false
            end
        end
    
        def undo()
            if(can_undo)
                FileUtils.mv(@newpath, @path)
                puts "File #{@newpath} moved back to #{@path}"
            else
                puts "There is nothing to undo!"
            end
        end
    
    end