require_relative 'Command'

class CopyFileCommand < Command
    
    attr_accessor(:path_to_file, :newfile, :thedescription, :can_undo)
    
    
        def initialize(filepath, new_file)
            super()
            self.path_to_file = filepath
            self.newfile = new_file
            self.thedescription = "Copying a file: #{@path_to_file} -> #{@newfile}" 
        end
        def execute()
            if(File.exist?(@path_to_file))
                FileUtils.copy_file(@path_to_file, @newfile)
                puts "File '#{@path_to_file}' copied to #{@newfile}"
                self.can_undo = true
            elsif(File.exist?(@newfile))
                puts "File already exists at this destination; try again"
                self.can_undo = false
            elsif(!File.exist?(@path_to_file))
                puts "There is nothing to copy!"
            else
                puts "How did you mess up this badly??? Try again."
            end
            
        end
    
        def undo()
            if(can_undo)
            File.delete(@newfile)
            puts "Copy File undone: File '#{@newfile}' has been deleted."
            else 
                puts "There is nothing to undo!"
            end
        end
    end