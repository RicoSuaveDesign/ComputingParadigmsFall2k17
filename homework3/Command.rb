require 'FileUtils'

class Command 

    # these are all empty because each command will have diff impls of these funcs

    def initialize()
    end

    def execute()
    end

    def undo()
    end

    def description()
        @thedescription # description will always return itself
    end
end