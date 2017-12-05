require_relative 'Command'

class DeleteDirectoryCommand < Command 
    
    attr_accessor(:directory_name, :thedescription, :can_undo)
    
        def initialize(dirname)
            super()
            self.directory_name = dirname
            self.thedescription = "Deleting a directory: #{@directory_name}" 
        end
    
        def execute()
            if(Dir.exist?(@directory_name))
                FileUtils.remove_dir(@directory_name)
                puts "Directory '#{@directory_name}' deleted"
                self.can_undo = true
            else
                puts "Directory doesn't exist; try again"
                self.can_undo = false
            end
        end
    
        def undo()
            if(can_undo)
                FileUtils.mkdir_p(@directory_name)
                puts "DeleteDirectory undone: Directory '#{@directory_name}' has been restored."
                else 
                    puts "There is nothing to undo!"
                end
        end
    end