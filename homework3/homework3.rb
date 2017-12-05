require_relative 'CreateFileCommand'
require_relative 'DeleteFileCommand'
require_relative 'RenameFileCommand'
require_relative 'CreateDirectoryCommand'
require_relative 'CopyFileCommand'
require_relative 'DeleteDirectoryCommand'
require_relative 'RenameDirectoryCommand'
require_relative 'CopyDirectoryCommand'
require_relative 'CompositeCommand'

cmp = CompositeCommand.new()
c = CreateFileCommand.new("Buttholes.txt", "********** \n I told you there would be buttholes.")
cmp.AddCommand(c)
d = DeleteFileCommand.new("Buttholes.txt")
cmp.AddCommand(d)
cd = CreateFileCommand.new("Butthole.txt", "* \n Salt my butthole.")
cmp.AddCommand(cd)
dc = DeleteFileCommand.new("Butthole.txt")
cmp.AddCommand(dc)

cmp.description()
puts "stepping 4words"
cmp.StepForward(2)
cmp.execute()
puts "executed"
cmp.StepBackwards(2)
cmp.undo()


