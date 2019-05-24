$PSDefaultParameterValues['*:Encoding'] = 'utf8'                                                                                   #Allow Powershell to manage special characters 

######## GET THE DATA #############################################################################################################

$fileA = Get-ChildItem -Path (Read-Host -Prompt 'Path of the file A')                                              #Define the reference file location

$fileB = Get-ChildItem -Path (Read-Host -Prompt 'Path of the file B')                                              #Define the difference file location

######### COMPARE AND RESULT REPORT CREATION ######################################################################################

if(Compare-Object -ReferenceObject $(Get-Content $fileA) -DifferenceObject $(Get-Content $fileB))                                  #Compare the old environment  modified/converted file to the new environment converted file

 {"Files are different" 
 Compare-Object -ReferenceObject $(Get-Content $fileA) -DifferenceObject $(Get-Content $fileB) -IncludeEqual| Export-Csv -Path C:\Result\CompareResult-NOK-$(get-date -f yyyy-MM-dd-HH-mm).csv } 
                                                                                                                                   #if the compare operation found a difference between the 2 files display "file are different" in the consol and export the result in a timestamp csv file

Else {"Files are the same"
Compare-Object -ReferenceObject $(Get-Content $fileB) -DifferenceObject $(Get-Content $fileB) -IncludeEqual | Export-Csv -Path C:\Result\CompareResult-OK-$(get-date -f yyyy-MM-dd-HH-mm).csv} 
                                                                                                                                   #Else display "File are the same"in the consol and export the result in a timestamp csv file

Read-Host 'Press Enter to close…' | Out-Null                                                                                       #Ask the user to press "Enter" to finish the script