$PSDefaultParameterValues['*:Encoding'] = 'utf8'                                                                                   #Allow Powershell to manage special characters 

######## GET THE DATA #############################################################################################################

$fileA = Get-ChildItem -Path (Read-Host -Prompt 'Path of the file A')                                              #Define the reference file location

$fileB = Get-ChildItem -Path (Read-Host -Prompt 'Path of the file B')                                              #Define the difference file location

######### CONVERSION ###############################################################################################################Conversion needs to be perform for the data coming from the system 1

Import-Csv $fileA -Delimiter "`t" -Encoding UTF8 | ForEach-Object {                                                                #Import the reference file location using TAB as delimiter    

###Example - User cleaning
                                                                                                                                   #If the value of the username have been modified, replace the value by the value in the new system
if ($_."modifiedBy" -eq 'user1a') {$_."modifiedBy" = 'user1'}  
if ($_."createdBy" -eq 'user1a') {$_."createdBy" = 'user1'}  
 
###Example - Versionning cleansing
#######Versionning cleansing       
    if ($_."Version" -like "*.0") 
    {                                                                                                                              #If the value in the column "Version" contains the strings ".0"
       $_."Version" = $_."Version" -replace "\.0",""                                                                               #Replace ".0" by "" in the Version column
    }
    if ($_."Version" -like "*.") 
    {                                                                                                                              #If the value in the column "Version" contains the strings "."
        $_."Version" = $_."Version" -replace "\.","#"                                                                              #Replace "." by "#" in the Version column
    }
#######Versionning cleansing - Remove special characters
    if ($_."Version" -eq "_") 
    {                                                                                                                             #If the value in the column "Version" equals the strings "_"
        $_."Version" = $_."Version" -replace "_","0"                                                                               #Replace "_" by "0" in the Version column
    }
    if ($_."Version" -like "*_*") 
    {                                                                                                                             #If the value in the column "Version" contains the strings "_"
        $_."Version" = $_."Version" -replace "_",""                                                                               #Replace "_" by "" in the Version column
    }  
    if ($_."Version" -like "*?*") 
    {                                                                                                                              #If the value in the column "Version" contains the strings "?"
        $_."Version" = $_."Version" -replace "\?",""                                                                               #Replace "?" by "" in the Version column
    }
        if ($_."Version" -like "*)*") 
    {                                                                                                                              #If the value in the column "Version" contains the strings ")"
        $_."Version" = $_."Version" -replace "\)",""                                                                               #Replace ")" by "" in the Version column
    }   
        if ($_."Version" -like "*(*") 
    {                                                                                                                              #If the value in the column "Version" contains the strings "("
        $_."Version" = $_."Version" -replace "\(",""                                                                               #Replace "(" by "" in the Version column
    }
    if ($_."Version" -like "*-*") 
    {                                                                                                                              #If the value in the column "Version" contains the strings "-"
        $_."Version" = $_."Version" -replace "\-",""                                                                               #Replace "-" by "" in the Version column
    }                                                                                                                                          
         $_
} |

Export-Csv -Path C:\Data\Staging_fileC.csv -Force -NoTypeInformation -Encoding UTF8                                     #Save the old environment modified/converted file

$fileC = "C:\Data\Staging_fileC.csv"                                                                                    #Define the old environment modified/converted file location


Import-Csv $fileB -Delimiter "`t" -Encoding UTF8 | ForEach-Object {                                                                #Import the new system (file B) file using TAB as a delimiter

#######Example - Number cleaning
    if ($_."Number" -like "*_SE") 
    {                                                                                                                              #If the value in the column "Number" finish by the strings "_SE"
        $_."Number" = $_."Number" -replace "_SE",""                                                                                #Replace "_SE" by "" in the number column
    }
    if ($_."Number" -like "*_") 
    {                                                                                                                              #If the value in the column "Number" finish by the string "_"
    $_."Number" = $_."Number".Substring(0,$_."Number".Length-1)                                                                    #Remove the last character from the string ("_") in the number column
    }
         $_                                                                                                                        #No operation is performed, the script only convert the csv to make sure the Format/Encoding is the same 
} |
Export-Csv -Path C:\Data\Staging_fileD.csv -Force -NoTypeInformation -Encoding UTF8                                     #Save the new environment converted file

$fileD = "C:\Data\Staging_fileD.csv"                                                                                    #Define the new environment converted file location


######### COMPARE AND RESULT REPORT CREATION ######################################################################################

if(Compare-Object -ReferenceObject $(Get-Content $fileC) -DifferenceObject $(Get-Content $fileD))                                  #Compare the old environment  modified/converted file to the new environment converted file

 {"Files are different" 
 Compare-Object -ReferenceObject $(Get-Content $fileC) -DifferenceObject $(Get-Content $fileD) -IncludeEqual| Export-Csv -Path C:\Result\CompareResult-NOK-$(get-date -f yyyy-MM-dd-HH-mm).csv } 
                                                                                                                                   #if the compare operation found a difference between the 2 files display "file are different" in the consol and export the result in a timestamp csv file

Else {"Files are the same"
Compare-Object -ReferenceObject $(Get-Content $fileC) -DifferenceObject $(Get-Content $fileD) -IncludeEqual | Export-Csv -Path C:\Result\CompareResult-OK-$(get-date -f yyyy-MM-dd-HH-mm).csv} 
                                                                                                                                   #Else display "File are the same"in the consol and export the result in a timestamp csv file

Read-Host 'Press Enter to close…' | Out-Null                                                                                       #Ask the user to press "Enter" to finish the script