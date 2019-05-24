This file is written the 23rd of May 2019. This file is organized as below:

1.Pre-requisite
2.Compare 2 CSV files script
3.Compare 2 CSV files with conversion rules script
4.How to read the report file
5.Contact

##1.Pre-requisite

- This script has been written to work on Windows using Windows PowerShell V1.0 
- The user needs to be able run PowerShell script ( to be able to run the PowerShell script, the user can type "Set-ExecutionPolicy Unrestricted -Scope Currentuser" in PowerShell consol)
- The user needs to create a folder "C:\Result\" (This folder will be used to stored the timestamp result file) 
- If the script with conversion rules is execute, The user needs to create a folder"C:\Data\" (This folder will be used to stored the staging files "corrected reference object"and "corrected difference object" after applying the conversion rules)
- Remove space in the name of your file

##2.Compare 2 CSV files script

The goal of this test script is to compare 2 csv files and create a report file with the result of the comparaison. 

The test script is composed of 2 sections:
- Get the Data
- Compare and result report creation

### Get the Data
The script asks for the path of the file A and the file B that need to be compared.
The path of the files are stored in the variable fileA (reference object) and fileB (difference object).

### Compare and result report creation
The file A (reference object) and the file B (difference object) are compared.
If the compare operation found a difference between the 2 files display "file are different" in the consol and export the result in a timestamp csv file located under "C:\Result\"
Else display "File are the same"in the consol and export the result in a timestamp csv file located under "C:\Result\"
Then the script asks the user to press Enter to close the script.

##3.Compare 2 CSV files with conversion rules script

The goal of this test script is to clean 2 csv files by applying conversion rules, compare the 2 files and create a report file with the result of the comparaison.

The test script is composed of 3 sections:
- Get the Data
- Conversion
- Compare and result report creation

### Get the Data
The script asks for the path of the file A and the file B that need to be compared.
The path of the files are stored in the variable fileA (reference object) and fileB (difference object).

### Conversion
This section needs of the script needs to be updated according to your needs.
Some examples of conversion/data cleaning are by default in this section.

Note: By default, the script use TAB as delimiter. 

The script import the file A (reference object) perform the conversion rules defined for each object and create a new file (file C) stored in the variable fileC (corrected reference object)
This file is located under "C:\Data\Staging_fileC.csv"

The script import the file B (reference object) perform the conversion rules defined for each object and create a new file (file D) stored in the variable fileD (corrected difference object)
This file is located under "C:\Data\Staging_fileD.csv"

### Compare and result report creation
The file C (corrected reference object) and the file D (corrected difference object) are compared.
If the compare operation found a difference between the 2 files display "file are different" in the consol and export the result in a timestamp csv file located under "C:\Result\"
Else display "File are the same"in the consol and export the result in a timestamp csv file located under "C:\Result\"

Note: 
The staging files file C ("C:\Data\Staging_fileC.csv") and file D ("C:\Data\Staging_fileD.csv") are not deleted when the script closed.
The staging files file C ("C:\Data\Staging_fileC.csv") and file D ("C:\Data\Staging_fileD.csv") will be replaced by new updated files each time you will execute the script.

##4.How to read the report file

The files are compared using the powershell Compare-Object cmdlet. 

If "==" is displayed in the "SideIndicator" column the rows are the same in both files.
If "=>" or "<=" is displayed in the "SideIndicator" column the rows are different. ("<=" is displayed in the row of the reference object (file A) and "=>" is displayed in the row of the difference object(file B))

For more information regarding the powershell Compare-Object cmdlet, check the link below:
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/compare-object?view=powershell-6

##5.Contact

Alexandre DOUDELET - adoudelet@protonmail.com