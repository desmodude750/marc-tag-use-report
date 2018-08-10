# MARC Tag Usage Report
Takes as input a collection of MARCXML files and produces:
- a CSV report `Marcreport.csv` on all tag and subfields in the input
- a MARCXML `MarcInputTestFile_AllFieldsInData.xml` with all of the used tags and subfields

Supports use cases: 
- Performing data migrations from MARC to other data formats
- Development of software or processes supporting specific uses of MARC

# Usage
Run the transform with any xsl process you like or use perl shell `MARCMarkupReport_FileCollection.pl` included.

Input MARC XML files are assumed to reside in a `marcfiles` folder. Obviously you can alter as you wish.

