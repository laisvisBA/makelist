
/*------------------------------------------------------------------------
    File        : ttAllFiles.i
    Purpose     : 
  ----------------------------------------------------------------------*/


/* ***************************  Main Block  *************************** */

def temp-table {&name} no-undo
    field pathAndFile as char
    field ID as int init 0
    index pathAndFile is word-index pathAndFile.