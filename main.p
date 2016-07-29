{ttAllFiles.i &name="ttAllFiles"}
{ttAllFiles.i &name="ttIncludesHasChanged"}
{ttAllFiles.i &name="ttMakeList"}
{ttXREF.i &name="ttXREF"}

define variable vLine as character no-undo.
def var vDir as char no-undo.

/* List all files to be checked */
input through value("CMD.EXE /C DIR ~"C:\Users\skornejevas\Desktop\MakeList\branch\4uzd\*.p~" ~"C:\Users\skornejevas\Desktop\MakeList\branch\4uzd\*.cls~" ~"C:\Users\skornejevas\Desktop\MakeList\branch\4uzd\*.i~" /S /B") no-echo.
repeat:
    create ttAllFiles.
    import unformatted ttAllFiles.pathAndFile.
    put unformatted ttAllFiles.pathAndFile skip.
end.
input close.

/* Check if file which can be compiled was changed, if yes, then move it to ttMakeList  */

def var vBranchDir as char no-undo.
def var vTrunkDir as char no-undo.
def var i as int no-undo init 0.
def var vCompared as char no-undo.
for each ttAllFiles where
         ttAllFiles.pathAndFile contains ".p" or
         ttAllFiles.pathAndFile contains ".cls":
         
    vBranchDir = ttAllFiles.pathAndFile.
    vTrunkDir = replace(vBranchDir, "branch","trunk").
    
    input through value(substitute("cmd.exe /C C:\Users\skornejevas\Desktop\code\DOS\test.bat &1 &2",vBranchDir,vTrunkDir)) no-echo.
    repeat:
        import unformatted vCompared.
            if vCompared <>"same" then do:
                create ttMakeList.
                ttMakeList.pathAndFile = vCompared.
            end.
    end.
    
end.
input close.
/*for each ttAllFiles where                     */
/*         ttAllFiles.pathAndFile contains ".i":*/
/*create ttIncludesHasChanged.                              */
/*ttIncludesHasChanged.pathAndFile = ttAllFiles.pathAndFile.*/

for each ttMakeList:
    message ttMakeList.pathAndFile view-as alert-box.
end.