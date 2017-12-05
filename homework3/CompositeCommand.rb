require_relative 'Command'

class CompositeCommand < Command
    attr_accessor(:commandarray, :currentstep)
    
    def initialize()
        super()
        self.commandarray = Array.new()
        self.currentstep = 0
    end

    def AddCommand(thecommand)
        self.commandarray << thecommand
    end

    def execute()
        StepForward(@commandarray.length - currentstep)
    end

    def undo()
        StepBackwards(currentstep)
    end

    def StepForward(steps)
        @currentstep.upto((@currentstep + (steps - 1))) do |command|
            #puts "hey buddy, we on step #{currentstep}"
            #puts @commandarray[command].description()
            @commandarray[command].execute() 
            self.currentstep += 1
        end
    end

    def StepBackwards(steps)
        (@currentstep-1).downto((@currentstep - steps)) do |command|  
            #puts "hey buddy we went backwords once, from #{currentstep}"
            #puts @commandarray[command].description()
            @commandarray[command].undo()
            self.currentstep -= 1
        end
    end

    def description()
        commandarray.each() do |command|
            puts command.description()
        end
    end
end