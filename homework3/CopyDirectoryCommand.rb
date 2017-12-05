require_relative 'Command'

class CopyDirectoryCommand < Command
    attr_accessor(:path, :newpath, :thedescription, :can_undo)
    
    
        def initialize(filepath, new_filepath)
            super()
            self.path = filepath
            self.newpath = new_filepath
            self.thedescription = "Copying a directory: #{@path} -> #{@newpath}" 
        end
        def execute()
            if(Dir.exist?(@path))
                FileUtils.copy_entry(@path, @newpath)
                puts "File '#{@path}' copied to #{@newpath}"
                self.can_undo = true
            elsif(Dir.exist?(@newpath))
                puts "A directory already exists at this destination; try again"
                self.can_undo = false
            elsif(!Dir.exist?(@path))
                puts "There is nothing to copy!"
            else
                puts "How did you mess up this badly??? Try again."
            end
            
        end
    
        def undo()
            if(can_undo)
                FileUtils.remove_dir(@newpath)
            puts "Copy Directory undone: Directory '#{@newpath}' has been deleted."
            else 
                puts "There is nothing to undo!"
            end
        end
    end