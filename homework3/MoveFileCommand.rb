require_relative 'Command'

class MoveFileCommand < Command 

    attr_accessor(:path_to_file, :newpath, :thedescription, :can_undo)
    
        def initialize(oldfile, newplace)
            super()
            self.path_to_file = oldfile
            self.newpath = newplace
            self.thedescription = "Moving: #{@path_to_file} -> #{@newpath}" 
        end
    
        def execute()
            if(File.exist?(@path_to_file) && !File.exist?(@newpath))
                File.rename(@path_to_file, @newpath)
                puts "File '#{@path_to_file}' moved to #{@newpath}"
                self.can_undo = true
            elsif(!File.exist?(@path_to_file))
                puts "File doesn't exist. There is nothing to move!"
                self.can_undo = false
            elsif(File.exist?(@newpath))
                puts "There is already a file named '#{@newpath}'. Pick a different name or delete the file."
                self.can_undo = false
            else
                puts "You managed to do something outside the two main cases. Good job, try again, move failed."
                self.can_undo = false
            end
        end
    
        def undo()
            if(can_undo)
                File.rename(@newpath, @path_to_file)
                puts "File #{@newpath} moved back to #{@path_to_file}"
            else
                puts "There is nothing to undo!"
            end
        end
    
    end