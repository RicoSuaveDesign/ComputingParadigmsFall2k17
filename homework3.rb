

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


