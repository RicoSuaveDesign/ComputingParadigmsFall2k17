require 'test/unit'
require_relative 'CreateFileCommand'
require_relative 'DeleteFileCommand'
require_relative 'RenameFileCommand'
require_relative 'CreateDirectoryCommand'
require_relative 'CopyFileCommand'
require_relative 'DeleteDirectoryCommand'
require_relative 'RenameDirectoryCommand'
require_relative 'CopyDirectoryCommand'
require_relative 'CompositeCommand'

class TestSimpleNumber < Test::Unit::TestCase
    attr_accessor(:comp)
    def setup
        puts "Creating Composite Command object for test"
        filename = "composite.txt"
        movename = "../composite.txt"
        rename = "../composited.txt"

        dirname = "./composite"
        dirmove = "../composite"
        redir = "../composited"

        self.comp = CompositeCommand.new()
        puts "Adding commands to the composite"
        c = CreateFileCommand.new(filename, "I was created in a composite command!!\n")
        d = DeleteFileCommand.new(filename)
        cd = CreateFileCommand.new(filename, "Hey I'm back and still in a composite!\n")
        mv = MoveFileCommand.new(filename, movename)
        rn = RenameFileCommand.new(movename, rename)
        cpy = CopyFileCommand.new(rename, filename)
        dir = CreateDirectoryCommand.new(dirname)
        del = DeleteDirectoryCommand.new(dirname)
        undel = CreateDirectoryCommand.new(dirname)
        movdir = MoveDirectoryCommand.new(dirname, dirmove)
        rndir = RenameDirectoryCommand.new(dirmove, redir)
        cpydir = CopyDirectoryCommand.new(redir, dirname)

        self.comp.AddCommand(c)
        self.comp.AddCommand(d)
        self.comp.AddCommand(cd)
        self.comp.AddCommand(mv)
        self.comp.AddCommand(rn)
        self.comp.AddCommand(cpy)
        self.comp.AddCommand(dir)
        self.comp.AddCommand(del)
        self.comp.AddCommand(undel)
        self.comp.AddCommand(movdir)
        self.comp.AddCommand(rndir)
        self.comp.AddCommand(cpydir)

    end

    def teardown
        puts "Cleaning up post-test"
    end

    def test_CreateFile()
      c = CreateFileCommand.new("test.txt", "This is a test.")
      puts c.description()
      c.execute()
      assert_equal(File.exist?("test.txt"), true)
      c.undo()
      assert_equal(!File.exist?("test.txt"), true)  
    end

    def test_DeleteFile()
        filename = "deletetest.txt"
        c = CreateFileCommand.new(filename, "Another test")
        c.execute()
        d = DeleteFileCommand.new(filename)
        puts d.description()
        d.execute()
        assert_equal(!File.exist?(filename), true)
        d.undo()
        assert_equal(File.exist?(filename), true)
        d.execute() #we don't need this file lying around
    end

    def test_CopyFile()
        filename = "copytest.txt"
        copy = "freshcopy.txt"
        content = "Imma get copied\n"
        c = CreateFileCommand.new(filename, content)
        c.execute()
        cpy = CopyFileCommand.new(filename, copy)
        cpy.execute()
        f = File.open(copy)
        cpycontent = f.read
        f.close #system can't close an open file
        assert_equal(File.exist?(copy), true)
        assert_equal(content, cpycontent)
        cpy.undo()
        assert_equal(!File.exist?(copy), true)

        File.delete(filename) #still don't need this just lying around
    end

    def test_MoveFile()
        filename = "fresh.txt"
        newloc = "../fresh.txt"
        content = "Does my content come with me????\n"

        c = CreateFileCommand.new(filename, content)
        c.execute()
        rn = MoveFileCommand.new(filename, newloc)
        puts rn.description()
        rn.execute()

        assert_equal(File.exist?(newloc), true)
        assert_equal(!File.exist?(filename), true)
        f = File.open(newloc)
        movcontent = f.read
        f.close
        assert_equal(content, movcontent)
        rn.undo()

        assert_equal(!File.exist?(newloc), true)
        assert_equal(File.exist?(filename), true)

        File.delete(filename)
    end

    def test_RenameFile()
        #Rename uses Move but I'm not going to lose points for not unit testing this so here ya go
        filename = "refresh.txt"
        newname = "unstale.txt"
        content = "Does my content come with me????\n"

        c = CreateFileCommand.new(filename, content)
        c.execute()
        rn = RenameFileCommand.new(filename, newname)
        puts rn.description()
        rn.execute()

        assert_equal(File.exist?(newname), true)
        assert_equal(!File.exist?(filename), true)
        f = File.open(newname)
        movcontent = f.read
        f.close
        assert_equal(content, movcontent)
        rn.undo()

        assert_equal(!File.exist?(newname), true)
        assert_equal(File.exist?(filename), true)

        File.delete(filename)
    end

    #Directory testing

    def test_CreateDirectory()
        dirname = "./newdirectory"
        c = CreateDirectoryCommand.new(dirname)
        puts c.description()
        c.execute()
        assert_equal(Dir.exist?(dirname), true)
        c.undo()
        assert_equal(!Dir.exist?(dirname), true)  
      end
  
      def test_DeleteDirectory()
          dirname = "./undeleted"
          c = CreateDirectoryCommand.new(dirname)
          c.execute()
          d = DeleteDirectoryCommand.new(dirname)
          puts d.description()
          d.execute()
          assert_equal(!Dir.exist?(dirname), true)
          d.undo()
          assert_equal(Dir.exist?(dirname), true)
          d.execute() #we don't need this directory lying around
      end
  
      def test_CopyDirectory()
          dirname = "./copysrc"
          dircopy = "./copydst"
          c = CreateDirectoryCommand.new(dirname)
          c.execute()
          cpy = CopyDirectoryCommand.new(dirname, dircopy)
          cpy.execute()
          assert_equal(Dir.exist?(dircopy), true)
          cpy.undo()
          assert_equal(!Dir.exist?(dircopy), true)
          FileUtils.remove_dir(dirname) #we dont need this directory lying around
  
      end
  
      def test_MoveDirectory()
          dirname = "./fresh"
          newloc = "../fresh"
  
          c = CreateDirectoryCommand.new(dirname)
          c.execute()
          rn = MoveDirectoryCommand.new(dirname, newloc)
          puts rn.description()
          rn.execute()
  
          assert_equal(Dir.exist?(newloc), true)
          assert_equal(!Dir.exist?(dirname), true)
          rn.undo()
  
          assert_equal(!Dir.exist?(newloc), true)
          assert_equal(Dir.exist?(dirname), true)

          FileUtils.remove_dir(dirname)
      end
  
      def test_RenameDirectory()
          #Rename uses Move but I'm not going to lose points for not unit testing this so here ya go
          dirname = "./refresh"
          newname = "./unstale"
  
          c = CreateDirectoryCommand.new(dirname)
          c.execute()
          rn = RenameDirectoryCommand.new(dirname, newname)
          puts rn.description()
          rn.execute()
  
          assert_equal(Dir.exist?(newname), true)
          assert_equal(!Dir.exist?(dirname), true)
          rn.undo()
  
          assert_equal(!Dir.exist?(newname), true)
          assert_equal(Dir.exist?(dirname), true)

          FileUtils.remove_dir(dirname)
      end

      #CompositeCommand tests!!

    def test_CompositeExecuteandUndo()
            self.comp.description()
            self.comp.execute()

            assert_equal(File.exist?("composite.txt"), true)
            assert_equal(Dir.exist?("./composite"), true)

            assert_equal(File.exist?("../composited.txt"), true)
            assert_equal(File.exist?("../composited"), true)

            self.comp.undo() #honestly I just don't want the junk lying around which is why multi-test

            assert_equal(!File.exist?("composite.txt"), true)
            assert_equal(!Dir.exist?("./composite"), true)

            assert_equal(!File.exist?("../composited.txt"), true)
            assert_equal(!File.exist?("../composited"), true)


    end

    def test_StepForwardAndBack
        self.comp.StepForward(1) #create the file
        assert_equal(File.exist?("composite.txt"), true)
        self.comp.StepForward(1) #delete the file
        assert_equal(!File.exist?("composite.txt"), true)
        self.comp.StepForward(1) # file is back
        assert_equal(File.exist?("composite.txt"), true)
        self.comp.StepForward(1) #file is moved to the parent directory
        assert_equal(File.exist?("../composite.txt"), true)
        self.comp.StepForward(1) #file is renamed while in the parent directory
        assert_equal(File.exist?("../composited.txt"), true)
        self.comp.StepForward(1) #file is copied to orig location (composite.txt in pwd)
        assert_equal(File.exist?("composite.txt"), true)

        self.comp.undo() #go back!!!

        self.comp.StepForward(6) #jk let's redo those 6 steps

        self.comp.StepBackwards(2) # wait hang on a second lets step back. Should be just before rename.
        assert_equal(File.exist?("../composite.txt"), true)

        self.comp.StepForward(3) # ok lets test those directory commands. Create dir
        assert_equal(Dir.exist?("./composite"), true)
        self.comp.StepForward(1) # delete directory
        assert_equal(!Dir.exist?("./composite"), true) 
        self.comp.StepForward(1) # remake the directory
        assert_equal(Dir.exist?("./composite"), true)
        self.comp.StepForward(1) # we moved it to the parent dir
        assert_equal(Dir.exist?("../composite"), true)
        self.comp.StepForward(1) # rename while in parent dir
        assert_equal(Dir.exist?("../composited"), true)
        self.comp.StepForward(1) # copy directory back to pwd
        assert_equal(Dir.exist?("./composite"), true)

        self.comp.undo() # I HATE GARBAGE
    end

    def test_CompositeComposite
        filename = "werk.txt"
        content = "I only just now saw that I have to test subcomposites so hey!\n"
        c = CompositeCommand.new()
        create = CreateFileCommand.new(filename, content)
        destroy = DeleteFileCommand.new(filename)
        recreate = CreateFileCommand.new(filename, content)
        rename = RenameFileCommand.new(filename, "unwerk.txt")

        c.AddCommand(create)
        c.AddCommand(destroy)
        c.AddCommand(recreate)
        c.AddCommand(rename)

        self.comp.AddCommand(c)

        self.comp.execute()
        assert_equal(File.exist?("unwerk.txt"), true)
        self.comp.undo() # get rid o this junk yo
        assert_equal(!File.exist?("unwerk.txt"), true)
    end
end