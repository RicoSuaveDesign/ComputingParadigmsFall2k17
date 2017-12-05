require_relative 'Command'

class DeleteFileCommand < Command 
    
    attr_accessor(:path_to_file, :text, :thedescription, :can_undo)
        def initialize(filepath)
            super()
            self.path_to_file = filepath
            self.thedescription = "Deleting a file: #{@path_to_file}"
        end
    
        def execute()
            if(File.exist?(@path_to_file))
                file = File.open(@path_to_file, "rb")
                self.text = file.read
                file.close
                File.delete(@path_to_file)
                puts "File '#{@path_to_file}' deleted"
                self.can_undo = true
            else
                puts "File doesn't exist; there is nothing to delete!"
                self.can_undo = false
            end
        end
    
        def undo()
            if(can_undo)
                file = File.open(@path_to_file, "w+")
                file.puts(@text)
                file.close
                puts "DeleteFile undone: File '#{@path_to_file}' has been recreated."
            else 
                puts "There is nothing to undelete!"
            end
        end
    
    end