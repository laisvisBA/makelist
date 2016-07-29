{ttAllFiles.i &name="ttAllFiles"}
{ttAllFiles.i &name="ttIncludesHasChanged"}
{ttAllFiles.i &name="ttMakeList"}
{ttXREF.i &name="ttXREF"}

define variable vLine as character no-undo.
def var vDir as char no-undo.

/* List all files to be checked */
input through value("CMD.EXE /C DIR ~"C:\Users\skornejevas\Desktop\MakeList\branch\1uzd\*.p~" ~"C:\Users\skornejevas\Desktop\MakeList\branch\1uzd\*.cls~" ~"C:\Users\skornejevas\Desktop\MakeList\branch\1uzd\*.i~" /S /B") no-echo.
repeat:
    create ttAllFiles.
    import unformatted ttAllFiles.pathAndFile.
    put unformatted ttAllFiles.pathAndFile skip.
end.
input close.

/* Check if file was changed */
def var vBranchDir as char no-undo.
def var vTrunkDir as char no-undo.
def var i as int no-undo init 0.
def var vCompared as char no-undo.

for each ttAllFiles where
         ttAllFiles.pathAndFile contains ".p" or
         ttAllFiles.pathAndFile contains ".cls" or
         ttAllFiles.pathAndFile contains ".i":
         
    vBranchDir = ttAllFiles.pathAndFile.
    vTrunkDir = replace(vBranchDir, "branch","trunk").
    
    input through value(substitute("cmd.exe /C C:\Users\skornejevas\Desktop\code\DOS\test.bat &1 &2",vBranchDir,vTrunkDir)) no-echo.
    repeat:
        import unformatted vCompared.
        
            /* If file was changed */
            if vCompared <> "same" then do:

                /* Check if File is an include */
                if substring(ttAllFiles.pathAndFile, length(ttAllFiles.pathAndFile) - 1, 2) = ".i" then do:
                    create ttIncludesHasChanged.
                    ttIncludesHasChanged.pathAndFile = ttAllFiles.pathAndFile.
                    delete ttAllFiles.
                end.
                
                /* File is not an include */
                else do:
                    create ttMakeList.
                    ttMakeList.pathAndFile = ttAllFiles.pathAndFile.
                    delete ttAllFiles.
                end.
            end.
    end.
end.
input close.

for each ttMakeList:
    message "Make List: "ttMakeList.pathAndFile view-as alert-box.
end.

for each ttAllFiles:
message "ttAllFiles: "ttAllFiles.pathAndFile view-as alert-box.
end.

for each ttIncludesHasChanged:
message "Include: " ttIncludesHasChanged.pathAndFile view-as alert-box.
end.