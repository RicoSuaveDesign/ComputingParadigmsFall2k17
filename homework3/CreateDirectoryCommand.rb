require_relative 'Command'

class CreateDirectoryCommand < Command 

    attr_accessor(:directory_name, :thedescription, :can_undo)
    
        def initialize(dirname)
            super()
            self.directory_name = dirname
            self.thedescription = "Creating a directory: #{@directory_name}" 
        end
    
        def execute()
            if(!Dir.exist?(@directory_name))
                file = FileUtils.mkdir_p(@directory_name)
                puts "Directory '#{@directory_name}' created"
                self.can_undo = true
            else
                puts "Directory already exists; try again"
                self.can_undo = false
            end
        end
    
        def undo()
            if(can_undo)
                FileUtils.remove_dir(@directory_name)
                puts "CreateDirectory undone: Directory '#{@directory_name}' has been deleted."
                else 
                    puts "There is nothing to undo!"
                end
        end
    end