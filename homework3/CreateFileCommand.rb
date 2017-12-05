require_relative 'Command'

class CreateFileCommand < Command
    
    attr_accessor(:path_to_file, :text, :thedescription, :can_undo)
    
    
        def initialize(filepath, content)
            super()
            self.path_to_file = filepath
            self.text = content
            self.thedescription = "Creating a file: #{@path_to_file}" 
        end
    #TODO: check if directory exists too? hmmm how do isolate from filename?
        def execute()
            if(!File.exist?(@path_to_file))
                file = File.open(@path_to_file, "w+")
                file.puts(@text)
                file.close
                puts "File '#{@path_to_file}' created"
                self.can_undo = true
            else
                puts "File already exists; try again"
                self.can_undo = false
            end
            
        end
    
        def undo()
            if(can_undo)
            File.delete(@path_to_file)
            puts "CreateFile undone: File '#{@path_to_file}' has been deleted."
            else 
                puts "There is nothing to uncreate!"
            end
        end
    end