# THEORY
## DAY 1: Introduction to TCL and VSDSYNTH Toolbox Usage
### INTRODUCTION
Agenda is to perform a task
  Build excel sheet as an input and output as a user interface
    Excel has top level design name, output dir, netlist direc( behavioral data in this), Early and late lib paths and constraints files
    The TCL BOX will take this as an input and give output as timing data. The CSV is acting like input, the TCL BOX as a processor and the timing rsults are shown as outputs

Excel sheet opener software to open the input file  
![image](https://github.com/user-attachments/assets/086f84b5-eca1-45f6-a9c3-87e62106cf18)
![image](https://github.com/user-attachments/assets/4b6394c0-663a-4540-8631-2ee43d937b56)


VSD SYNTH is a shell script, will openup the TOOL BOX. the same will consist of toolbox. Then pass the CSV file to this proc using ./vsdsynth
The output will give all the input and output file . It will run the synthesis and give the timing result as output. It will also dump the sdcs after processing the constraints. 
The final will be the synthesized netlist and the timing reports will be shown.
![image](https://github.com/user-attachments/assets/f218696f-c413-4593-8f50-1bdd46f0de44)
![image](https://github.com/user-attachments/assets/cea6cc47-01ce-40d2-91d9-fdeb749df6a1)


### SUB TASK and tool needed
TOP DOWN approach
 1. Crrate cmd csdsynth and pass .csv from unix shell to TCL script
 ![image](https://github.com/user-attachments/assets/12bd4d4c-c551-49a0-8158-c2621fab58d9)
 This will be a command that will be passing the csv file
 ![image](https://github.com/user-attachments/assets/3ce78454-23d5-47e7-a294-7d10741ca5e4)

 2. COnvert all the inputs to format[1] and SDC format and pass to synthesis tool Yosys
   ![image](https://github.com/user-attachments/assets/635b8582-ac60-43d8-93f3-302b2e452428)
This will be fed to Yosys for processing the above inputs
![image](https://github.com/user-attachments/assets/8729852e-d9d8-416c-a7b9-6dc608ff8844)
    2a. This consist of table for the constraints needs to be converted to SDC(output) as below
![image](https://github.com/user-attachments/assets/919c7eff-347d-40df-8ee5-2b67c8c55278)

3. Convert format[1] and SDC to format[2] and pass to timing tool 'Opentimer' (used to create th data sheet, only accepts data in certain format for processing in fromat[2]
    Below commands is used
   ![image](https://github.com/user-attachments/assets/263078fc-35b0-48ab-bb46-6866bf1856be)
   -> lib paths
   -> verilog path
   -> timing - constraints processed from the csv
   -> ![image](https://github.com/user-attachments/assets/8e040a23-6f7b-4835-8a63-49ac5f6fc0f8)
   The timing contraints in a processable format
   7-bit bus fragmented and identified from the RTL netlist and the inputs from the excel sheet
4. Generate output report:
   ![image](https://github.com/user-attachments/assets/cf339a8c-2b9e-4de1-998f-dfc48bc21ad6)

### VSDDYNTH Toolbox usage scenarios
#### Scenario 1: User does not provide and input CSV file
 
![image](https://github.com/user-attachments/assets/bcf52e60-4461-4b43-8570-1d34c2f98d5d)
Inform the user that the input file is not procided
![image](https://github.com/user-attachments/assets/bc0fc474-c86b-489a-a5fd-886d695f4dd2)
The csv file is an arguement and need to use $arg to access the value
$#argv is the number of arguemnts. If we only let 1 arguemtn to accept , then need to provide the !==1 so it does not let it go forward
![image](https://github.com/user-attachments/assets/0413c1d7-4d16-4af4-8ff3-c1cb59917906)
Create the new file as per your design as per the below file with the lines
![image](https://github.com/user-attachments/assets/f375f6e9-d555-4372-9352-3d090ef0b11c)
gGive executive access - chmod -R 777

#### Scene2 and 3 : .csv file does not exist and "-help" to find out usage
  1.  $argv[1] is given as my.csv
  ![image](https://github.com/user-attachments/assets/6421468f-2fc5-4d86-9381-37684aeaca93)
The || sign helps to enter the loop to check the arguments provided with the provided csv file
This will stop the script due to exit 1
The below is how it will be displayed if the arguements fulfill and echo the comment provided.
![image](https://github.com/user-attachments/assets/e0817c22-b3dd-438e-a439-2ae6a0619122)

#### scene3: -help to find out usage
For the -help option, it has echo messages provided for the user
![image](https://github.com/user-attachments/assets/29e2e665-7d9d-4ba5-8d9c-c17946955b9f)
User provides
![image](https://github.com/user-attachments/assets/cadd4529-a3b0-4b9a-8441-4f7d38a34c1d)

DEMO:
![image](https://github.com/user-attachments/assets/66268da2-97a8-4f29-8398-c54c24ef24f2)
This will give the user information for reading and execute the command that is going to execute the TOOL.
You can give your email for support required for the user to understand the flow


## DAY 2 : Variable Creation and Processing Constraints from CSV
### Sub-Task Two : From CSV to format[1] and SDC - Variable Creation
#### Tasks involved in format conversion
  1. Create Variables for the corresponding inputs provided in the excel sheet
     ![image](https://github.com/user-attachments/assets/2696ae6f-05a9-4cca-b5a8-80344bb2221e)
  2. Check if dirc and files mentioned in .,csv exists or not
     ![image](https://github.com/user-attachments/assets/76bf59a3-9f05-4e6e-a50f-871a25179b02)
  3. This will help the user to correct any input paths or files provided is the above loop is unable to find them as the tool will exit with prompt and the reason. If path is found it will also inform the user.
  4. "puts" function is to echo in the shells and is like prointing any statements that is required to be conveyed
  5. Next is Read "COnstraints FIle" for the .csv and convert to SDC format(Universal constraint caled Synopsys Design COnstraint) to be used by PNR and STA tool
     ![image](https://github.com/user-attachments/assets/221abc29-51b7-47b6-b9b8-0cc38c0f0cbe)
  6. Read all files in "Netlist Directory"
     ![image](https://github.com/user-attachments/assets/39cd03d4-fe7d-48f2-a5fe-c63a3857d26a)
  7. Create main synthesis script in format[2] for the "Yosys" tool to be used
     ![image](https://github.com/user-attachments/assets/b39cb160-6210-4175-922e-ec4ebdd0e73b)
  8. Pass this script to Yoysys
     ![image](https://github.com/user-attachments/assets/41654bd7-dcc9-4002-b3f9-eed1b0e384b4)
  9. Variables helps to brigde and make a very streemlined flow so it reads inputs

#### Auto-Create variables using matrix and arrays
  1. Pass csv file to the tcl
     ![image](https://github.com/user-attachments/assets/d1487625-0180-4c55-adc2-78490b5ac34d)
  2. The arguements will be passed from the vsdsynth file to the .tcl file to access the each value using index[x]. The ndexes help to add more arguements as per requirement. Inside the sq brack needs to be executed. The set filename will now be the value from the [lindex $argv0]
     ![image](https://github.com/user-attachments/assets/dca7a03e-8e93-4994-8701-164ff4f5d341)
     ![image](https://github.com/user-attachments/assets/fa602a4d-0150-4497-88c9-7fb6fd9248c4)
  3. Auto creating variable. Will help to be independent of the files/ directory location.
  4. 2x6 matrix is used and converted to array
   ![image](https://github.com/user-attachments/assets/750b1a4a-f8ed-46fa-88a9-07f3660cdea7)
  5. Now processing the array is easy as it acts like a address for the data to be addressed. Own logic can be used for the varaibale auto creation
   ![image](https://github.com/user-attachments/assets/7362ab6a-5ab4-4fa1-bbc7-e0d56d4ee930)
  6. set  the new variable name and link it to the array. This linking will help the tool to access the original value that is provided in the .csv file which is the csv filename
   ![image](https://github.com/user-attachments/assets/1cec1f04-c3a6-4db3-af91-dc3ce8b2ed2d)
  7. Loop through the remaining array variables

#### Initialize variables for auto-creation variables task
![image](https://github.com/user-attachments/assets/5a9d9e85-1693-42c3-9538-3f83ecdfb4bf)

  1. Package for csv and matrix to be installed
  2. The struct::matrix object will be used to store the values in a matrix form.
  3. Open is file attribute to open the filename and stores in variable
  4. csv (comma separated value) - the file will look like beofw in vim
     ![image](https://github.com/user-attachments/assets/13c97425-b136-4a83-965f-60d42790f662)
  5. The "," will be used to sepaerat the values into the matrix and identify the size also
  6. csv::read2matrix is commands from the cpackages to exectue the intruction
  7. close $f will close the file
  8. Column and row values will taken. Instead of $columns or $row, if value is directly given then the respective columns and rows will be created
  9. Then link my_arr will convert this colunxrow format into array. THe array will act like a coordinate to extract and store data
  10. A counter increment is required to access all the data using a loop

#### Auto creation of the first variable - DesignName and Completion 
  1. Variables set to for the filename, matrix , columns , rows and counter
     ![image](https://github.com/user-attachments/assets/f43aae70-677d-46a3-a8eb-acb6eae1981b)
  2. Enter into a loop. Put a meessage for the array value. With each increment of the value i, the array data will be displayed for the user. (\n is new line)
    ![image](https://github.com/user-attachments/assets/d180b262-b484-4d3e-8e33-98bf88eb267b)
  3. In the first step, chars inside [] like the string map {_PS _TCL} learn_PS -> learn_TCL 
    ![image](https://github.com/user-attachments/assets/c4552114-91dd-427a-bde8-f9d24c9df1a3)
  4. In our file, we will be replacing the space with "_" using the string map
  5. DesignName is the frst valriable set , when given, $DesignName will give out the file name
  6. tcl command [expr {$i+1}] the expr is expression. it will evaluate the values inside the {} brackets.
  7. Now the "i" value as passed on the top to the while condition
  8. For DesignName, the output directory will be shown
  ![image](https://github.com/user-attachments/assets/c611a1a7-d430-4138-9083-c353a699c093)
  9. Now in the else loop, the variable and the value also is another command to be processed
  ![image](https://github.com/user-attachments/assets/24bd3c56-6437-4a5b-a8a4-40b960cf6162)
  10. Now the normalize is another set of sommand to process the absolute value for the directory
  ![image](https://github.com/user-attachments/assets/417fd2e5-599d-4688-8b61-a9b1997a6175)
  11. Now this will be saved in the OutPutDirectory as an absolute value
  ![image](https://github.com/user-attachments/assets/1be11230-8b62-425f-b2ee-7c990188d1ff)
  12. Now if we increment the "i" value, then the array address is updated and the coressponding value is assigned to it for the rest of the path values from the .csv file
  ![image](https://github.com/user-attachments/assets/df268191-e967-4cd7-9d64-d6cf75c84145)
  13. Data will be assigned as below
  ![image](https://github.com/user-attachments/assets/f3c450cc-6bc3-4f6e-a75d-211672f60bbb)




### Sub-Task Two : From CSV to format[1] and SDC - Processing constraints, CSV
#### Checking the existence of files and folders mentioned in design_details.csv 
  ![image](https://github.com/user-attachments/assets/c5b1587d-6411-436b-b2c3-ce498237fc62)
  1. If the conditions fulfil in if, then it will create directory
  2. Else it will display the output directory path
     ![image](https://github.com/user-attachments/assets/9822981a-1196-45f4-9b83-667386965038)
  3. In this the if else has covered conditions for the user, however for the netlist dorectory, that information is mandatory to move forward, so the information will be passed to user to correct and update the required files and the command will exit
  ![image](https://github.com/user-attachments/assets/aed0eb89-d536-4590-bc60-9be49c7debd2)
  4. As the above was checking the directory, it was using isdirectory check. Now to check file for the lib files, it needs to check using "exists"
  ![image](https://github.com/user-attachments/assets/f098babd-780e-4cc5-ae4a-50c5bea42587)
  
#### Convert constraints.csv file to a matrix object
  ![image](https://github.com/user-attachments/assets/03fa6e85-996e-4be3-87c3-272fd648567a)
  1. The data can be in bus format, in that case have to go to the netlist and check the data
  ![image](https://github.com/user-attachments/assets/06f306da-302a-4be6-b45a-a80ea2703045)
  2. Dumping of SDC constriants and read from the csv file above and create the rows and columns as per the "," characters
  3. chan is an identifier for the file opening the csv file
  4. 

#### Compute row number using complex matrix processing
  1. Inside square commands becomes a tcl command
  2. contraints is the name of the matrix and the rows and columns for the matrix will be read. The struct::matrix contraints object is the name given to the matrix
  3. In future, if required, $rows and $columns can be used
     ![image](https://github.com/user-attachments/assets/064bdad1-64f8-42b7-9509-59e39e275130)
  4. Process the clock, inputs and outputs separately
  5. "search all" is from the package and check the character "CLOCKS"
     ![image](https://github.com/user-attachments/assets/d3c20efd-449a-47ab-9806-7fab3667f857)
  6. Breakdown of lists that comes in {}
  7. Check for inputs. Will start with 4
     ![image](https://github.com/user-attachments/assets/a6ae0351-20d3-4360-9b9a-8477c6325497)
  8. Similarly for outputs. Will startt with 27
     ![image](https://github.com/user-attachments/assets/3860b027-da2d-4320-97d0-ed596ce670be)
     ![image](https://github.com/user-attachments/assets/2a0c0eba-8a7b-4139-b483-985e9bace63f)
  9. The start point is to be defined in order for the data to be separated and retrieve from the csv file


## DAY 3: Processing Clock and Input Constraints
### Sub-Task Two - From CSV to format[1] and SDC - Processing clock constraints

#### Algorithm to identify the column number for clock latency constraints
![image](https://github.com/user-attachments/assets/e15d3a41-27e4-435c-ad54-53bb1dfc8820)
  1. Basic algorithm is to find the column number for early_rise_delay and loop it
     ![image](https://github.com/user-attachments/assets/6b0f1d05-1593-4066-84aa-459ed16b8408)
  2. While going through the loop, need to fill the values
  3. Finally display the contents of the cell
     ![image](https://github.com/user-attachments/assets/12dfff65-5bca-4f57-bd80-688535d671dc)
  4. Will break the command to small pieces. [] are tcl commands. Search the csv for the respective column for a small area of the file
     ![image](https://github.com/user-attachments/assets/85efdeb2-edcb-41cd-b9c7-a77c15a23ce7)
  5. Ex: The expr inside {} is 11 - 1 for evaluation. The search space is restricted, so the starting value with check the rect that it will start from the CLOCK section only and check for columns with only early_rise_delay file
  6. ![image](https://github.com/user-attachments/assets/7124ed01-e3d6-4f8e-a7c8-d6bd7472efd6)
  7. Now if we access the 0th index of this list, we wll get the clock_early_rise_delay_start = 3
  8. Now we can continue to loop through the entirely
     ![image](https://github.com/user-attachments/assets/12bc99dd-b400-4be7-8161-23c4270f862e)

#### Start writing clock latemcy contraints in SDC file
  ![image](https://github.com/user-attachments/assets/5acd071e-4f9b-4c54-8253-b7a2a6e73127)
  1. In the loop, check if the entire clock constraints are read
     ![image](https://github.com/user-attachments/assets/07cb1282-5fe3-4c8c-8fa6-df3259f70240)
  2. This line will now create the command for clock latency by getting the values from the constraints file
  3. The newLine command with -nonewline will print one by one as the loop proceeds
  4. Now evaluate the values from the matrix and print it for 3,1 matrix location
     ![image](https://github.com/user-attachments/assets/cc94ee0f-eb77-4cbf-b471-81314f006824)
  5. To differ between the tcl [] and this command is using "\"
     ![image](https://github.com/user-attachments/assets/3214ab31-d466-4b78-a548-5e0d1515173a)
     ![image](https://github.com/user-attachments/assets/2764bbe8-619d-4e48-b5e3-6906771b50ee)

#### Complete clock latency constraints and clock slew constraints in SDC file
  1. Now complete the early_fall_delay. Update the rect value
     ![image](https://github.com/user-attachments/assets/9e9dad91-6920-4ca9-b108-9e5455ae3f95)
  2. Add the remaining lines by changing the contraint value
     ![image](https://github.com/user-attachments/assets/5bd16eb9-5323-4d08-8f5b-4d3fdcf51b8f)
  3. The slew values can also be updated for keyword update
     ![image](https://github.com/user-attachments/assets/e9d1dbc8-f838-42a6-92c7-5acea6db26fd)
     ![image](https://github.com/user-attachments/assets/debd3040-ac78-431a-9d42-8810ff45dc6c)
  4. For slew, clock_transtion wil be required for the command to be used
     ![image](https://github.com/user-attachments/assets/293e1c08-a497-4079-a4aa-3115c042ba40)


#### Code to create clock constraints with clock period and duty cycle
![image](https://github.com/user-attachments/assets/24c83c9d-fda2-4434-9ee4-c3b2d320b974)
  1. To get the clock name from file, can use this ![image](https://github.com/user-attachments/assets/5780dbe5-d746-440d-8f1f-60b206330e4e) or hardcode the value in the command
  2. For the waveform have to be formulated as per the duty cycle of the clock period
     ![image](https://github.com/user-attachments/assets/24212ef8-9afa-43ec-a005-d631a27c7910)
  3. The expr use from the matrix for the cell values, will give us the waveform. As duty cycle is 50%, the first expression will give 1500 and the second gives 50. The arithmetic calculation will give the value. Once the i is incremented, it will update for the rest
  ![image](https://github.com/user-attachments/assets/2e2f501c-b8e7-42e6-8c59-a9959ec538dd)
  4. File open in write mode for sdc, the below command will be consolidated
    ![image](https://github.com/user-attachments/assets/48be5057-e709-4b4b-b7b3-aa398ef0f0ae)


NOTE: for the command to understand the {} as character, "\" is used before


### Sub-Task Two - From CSV to format[1] and SDC - Processing input constraints
#### Introduction to the task of differentiating between bits and a bus
Ex: ![image](https://github.com/user-attachments/assets/09917a87-23d7-4165-9662-52aec8d3e8ab)
  1. The inputs are mostly bus values, i.e they are mutibit.
  2. Need to identify these multibits data for EDA tool to process
  3. In n-bit bus, '*' is added so that this will be taken for all the bits
  4. This will open the verilog file and take the data from top level

  ![image](https://github.com/user-attachments/assets/1f103a2d-73e3-4fea-99e0-50bffe955b6d)
   Input spaced by multiple characters
   String element count
   ![image](https://github.com/user-attachments/assets/c7fdc1b0-08a0-4f9e-8d32-98c420f02557)



#### Algorithm to categorize input ports as bits and bussed
  1. Globing - identifying the wildcards in directories by searching and get all the .v files in the directory. Similar to ls -lrt
     ![image](https://github.com/user-attachments/assets/769a1b3e-4c65-4d7c-a4e1-da25a041528a)
  2. tmp file created and is destroyed after use ![image](https://github.com/user-attachments/assets/1d1f4ed0-2e02-45b4-942d-7935a45ad1f4)
  3. The space separated path in the netlist directory will be assigned to the "f" variable in the foreach loop.
     NOTE: If no "w" is given the default file will be opened in read mode
  4. The while loop will read every line till the end of line. (-1) refers to end of line ![image](https://github.com/user-attachments/assets/1971589a-2360-40c1-8d74-0c36a11674bb)
  5. "" is used for pattern creation. As .v file has an extension of ";" , so adding it in the pattern ![image](https://github.com/user-attachments/assets/0b390513-79a1-4fb6-a0b0-b861cdc6f3e6)

#### File access and pattern creation steps
  1. regexp is regular expression trying to find the pattern in each line from the netlist that it is reading from
  2. If the pattern is not found in one file, it will move ahead to the next file
     ![image](https://github.com/user-attachments/assets/d768bcd8-17f2-486e-a504-2affa8de91c3)
  3. The "\S+" to get multiple spaces and get the elements around the spaces in the pattern2
  4. The new string pattern will be created and get inside the loop
     ![image](https://github.com/user-attachments/assets/9f7d498e-c72f-42b5-b5fc-fa8c04b0536f)
  5. The count is < 2, so no * is added at the end
  6. Now added this to the temp file without the multiple spaces for easier evaluation
  7. regsub having multiple spaces will now evaluate and put it in the temp file with a new string name ![image](https://github.com/user-attachments/assets/30e3ea6a-a256-4dbf-ae66-83e5774037da)
  8. Close the netlist and the temp file and the temp file should have the data
     ![image](https://github.com/user-attachments/assets/9ebb2535-a663-4497-85be-8f94bac82fc0)
     -> Need to sort this repeated values

#### Regular expression and regular substitute to get fixed space strings
Check the data LAB part on how the regexp help to remove the extra spaces between them

#### Read, split, uniquify, sort and join input ports to remove duplication
  1. The created tmp file will be read which contains the output data from all the verilog  files. Since $i is till 5, only the cou_en will be displayed and dumped.
  2. Now open another tmp2 file in write mode
     ![image](https://github.com/user-attachments/assets/1eda392e-51e6-4b5c-841e-f61b66e95161)
  3. Now for data to be dumped in tmp2 file:
      a. Read  contents of tmp1 and split them with "\n" as delimiter as the data is pronted   in newlines.
     ![image](https://github.com/user-attachments/assets/8d75f220-6c16-4dca-9525-23d97260643f)
      b. Since \n was dumped in the tmp1 as the 1st element, the output will have {} as the start. ![image](https://github.com/user-attachments/assets/1ca8ce4d-51f5-46a5-a5cd-d1aa3eee0911)
      c. Uniquify the element in the same list and sort it. ![image](https://github.com/user-attachments/assets/df52c448-b6f0-4a1d-9f21-39eaeffe4e99)
      d. Now join them as "\n" delimiter. ![image](https://github.com/user-attachments/assets/8a311861-a347-4c6d-b326-80616418db33)
      e. There will be no duplication and unique data will be saved in tmp2 file
      f. Now if the $i is > 5, the multi bit data will be taken.
         i. NOw there will be more elements in the data that is finally dumped in tmp2
          ![image](https://github.com/user-attachments/assets/92cb182f-d063-4499-87e4-fb14a6bd615a)
      g. Close the tmp and tmp2 files ![image](https://github.com/user-attachments/assets/e5bf3fb6-afd5-49e3-93b1-7d12b09e254e)


#### Evaluate the length of the string
  1. Open the tmp2 file in read mode which was closed after the unique daat was dumped
     ![image](https://github.com/user-attachments/assets/099d2579-3609-4b19-9fe1-daf0e2994f43)
  2. The cound with get the lngth of the lines in tmp2
  3. Concat the data if > 2 , i.e. Multibit data
     ![image](https://github.com/user-attachments/assets/353cf962-23b4-46a8-aa9f-f79d3e8e3438)
   
   NOTE: TCL can read the file only once. So commented out after use.

   4. Step by step the process can be shown and be visible in LAB sections. Be it reading, sorting, uniquifying and joining the data.
   5. This will show the content of the tmp2 file.
   6. NOw concat the multibit data by putting * at the end


#### Input constraints generation
![image](https://github.com/user-attachments/assets/a4212cbc-69ed-43f0-89d3-4bdb9d88e434)
  1. 


## DAY 4: Complete Scripting and Yosys Synthesis Introduction
### Full script for download and Conclusion
#### Constraints generation logic for the output port and Conclusion
  1. Similar to input constraints
     ![image](https://github.com/user-attachments/assets/24413375-c05c-4540-93bd-619def6e5182)
  2. Now need to update the rect for searching the cells in the constraints matrix
  3. Since now the search area will start from the output cell and end in the final row number. The search rect now will require the number of rows as end point for the data to be read
  4. The output will only contain delays and load. It does not consists the slew/ transition data. These are standard constraints for the input and output for the SDC format creation
![image](https://github.com/user-attachments/assets/a6da11e9-2981-46c0-8230-35e7df35275d)
  5. With this the TCL first part is concluded for the SDC creation as per the standard format

### Introduction to Yosys synthesis tool usage
#### Example of a memory module RTL description  
  1. Now will pass the SDC created previously to 'Yosys' tool
  2. Ex: The memory module creation with CLK, ADDR, DIN, DOUT
    ![image](https://github.com/user-attachments/assets/75719571-633d-4f6c-a74b-8f4fea7077d1)
      a. The word sze changes will determine the bit size. Input and output can be updated for the behaviotal code
      b. This will now create a gate level netlist
      ![image](https://github.com/user-attachments/assets/710b51c8-f982-4e83-996e-35f29da2eab6)
      c. Tool has command called "show command" to show the implemented code
      d. The module will look like this. If WordSize is 1, then it can store 1 bit data in 0 and 1. ![image](https://github.com/user-attachments/assets/a465b720-a5f4-42e2-931a-51f2c14d77f6)
      e. Convert the binary to decimal to resolve the address size of memory
      ![image](https://github.com/user-attachments/assets/dec4a744-a544-4951-ba14-f5b5ae88cc43)
      f. Clock input port parameters are based on the edge change of the clock period

     
#### Memory functionality and Synthesis using Yosys
  1. Process memory for the posedge of the clock. mem[ADDR] wll direct to the address of the memory
     ![image](https://github.com/user-attachments/assets/3688694d-bc58-494a-b7b2-5dd0bf790528)
  2. For the second clock edge, it is same and DIN data will be updated. So for DOUT <= mem[ADDR] is din value as it is assigned
  3. For addr[0] & [1], the functionality changes. DIN will go and sit in the memory

  4. Add the memory verilog code in memory.v
  5. Create a yosys file for the behavioural process for Yosys
     ![image](https://github.com/user-attachments/assets/b0623fe2-c83d-4515-8dc5-749a4fdfecf0)

  6. RTL Gate level Synthesis will be visible at the last for the memory module
     ![image](https://github.com/user-attachments/assets/d42d4ad7-e010-4b43-8923-5f8e7aedf6d5)


#### Components and Gate level netlist description of Synthesiszed memory
  1. Real Gates to be fed with right inputs
       a. set ADDR[0] to access data in the address
       b. In each mem[], X is put (undefined)
  2. INV, NAND, OAI(OR,AND,INV), NOR - truth table is used
  3. Diamond shaped representation of mem refers to a bus
#### Memory Write operation discussed in detail

#### Memory Read operation and TCL scripting agenda


### Hierarchy check and error handling script creation for Yosys
#### Script to do a hierarchy check

#### Error handling script for hierarchy check


## DAY 5:
### Synthesis main file scripting and output file editing
### Need and script to edit Yosys output netlist


### World of 'Procs'
#### Redirect stdout proc and demo of TCL array command
  ![image](https://github.com/user-attachments/assets/063bb882-284c-4035-8ed7-83edbd7634d9)
  1. Close the std screen log and open new file in write mode. Any new puts statement added will be dumped in this file
  2. For multicpu threading: ![image](https://github.com/user-attachments/assets/576e77b3-e6c4-47cf-8052-cfc32b63e9ec) . Used for distribution in EDA tools
     ![image](https://github.com/user-attachments/assets/36d35d74-3917-401c-aeb0-a191e949e0a4)
     a. Using the args and values of the args, the same will be activated with options for user. It can include details for the user to correct and execute the proc
     b. array set option work as variable and its corresponding value ![image](https://github.com/user-attachments/assets/2506ba4f-dc60-4880-99f4-89f5ea3ced83)
     c. "-help" is "null"
     d. As per this:
     ![image](https://github.com/user-attachments/assets/6a66beb6-351f-4b56-81a8-1c622113f9bb)
       i. Will be able to map to args and give the options
       ![image](https://github.com/user-attachments/assets/9145928f-6c0f-4757-a0f3-a6ccf7c2c348)


#### 'set_multi_cpu_usage' proc
Ex: for arg = 8
  1. ![image](https://github.com/user-attachments/assets/c7c37efe-4795-44ea-aa1a-76ede7c313b4)
  2. The arg value will be mapped for the value provided in the arg
  3. The switch is the options that the user wants to provide for use
  4. "-glob" will try to take the 0th element from the array
     ![image](https://github.com/user-attachments/assets/707ea9bb-dac8-49ae-b25e-7ed878e4428d)
     ![image](https://github.com/user-attachments/assets/aee5f38a-440d-4b6d-b8df-2f511e1a57e8)
  5. Now when both the option is used, the llength 3 is updated
     ![image](https://github.com/user-attachments/assets/6f87d322-7b94-4faf-bb40-ad84b48264b1)
  6. Options is an array and the variables and the value for the array as string is the options that we are providing
  7. Need to convert this proc to be understood by EDA tools
  8. As the value null has no options/ switch for the usage, it comes out of the loop

#### read_lib and read_verilog proc demo
  ![image](https://github.com/user-attachments/assets/03799bae-7b29-4df9-ba38-10bfbac93066)

#### Read SDC file and replace square brackets by 'null'
  ![image](https://github.com/user-attachments/assets/1e18cc6d-4ced-4b2f-9518-9b2f24e6ac70)


#### Evaluate clock period and clock port name from processed SDC
  ![image](https://github.com/user-attachments/assets/065b04e3-e289-48e9-8362-801a4bbd3863)

  1. Converting create_clock constraints
  ![image](https://github.com/user-attachments/assets/f1f55136-fc4d-484e-b8c2-585fe82d7d01)
  2. Elements mapped to index
     ![image](https://github.com/user-attachments/assets/83bfaff5-6145-49c8-82b7-9da7770e2bc7)
     ![image](https://github.com/user-attachments/assets/adb156ac-7454-4a85-a330-ba8853ff3cfe)
  3. Waveform calculation
     ![image](https://github.com/user-attachments/assets/d8e93323-5cc6-48eb-b913-635946a1c7d1)


#### Evaluate duty cycle and create clock in opentimer format

  1. Clock period and calculate using the duty cycle calculation
     ![image](https://github.com/user-attachments/assets/261cd027-4059-4627-bede-6b53f3262ba8)
  2. The expression will use the waveform creation for the selected ports
     ![image](https://github.com/user-attachments/assets/b4be2ddb-4e9f-470f-8087-4a3775351c0f)
     ![image](https://github.com/user-attachments/assets/5cc12554-9703-4afd-959d-40ad78bc9420)
  3. This will be able to be used in the openTimer tool
  4. The space separated line is put into a list
  5. Since there are 2 clocks, the create_clock is created like this:
     ![image](https://github.com/user-attachments/assets/fd5e88fe-d2a8-4c29-bf95-2285b42e8488)
  6. This format will be used by the tool
     ![image](https://github.com/user-attachments/assets/0ec9bd5a-15a3-431e-bd33-f969d1b307b0)


### read_sdc proc - interpret IO delays and transition constraints
#### Grep clock latency and port name from SDC file
  1. Similar to create clock constraints, create the file for opentimer
     ![image](https://github.com/user-attachments/assets/42336675-e2d9-429e-909a-8f36d07c9c26)
  2. Intermediate file to be used ![image](https://github.com/user-attachments/assets/9f4eb092-a4a8-4c14-9a5c-88bf3490db13)
  3. Dummy port name to reduce the repeated lines to reduce runtime
  4. Go through each and every element of the lines
    ![image](https://github.com/user-attachments/assets/897466d6-e180-4df7-8bfe-30728800df4c)
  5. Check the port name from the list, if it does not match, the loop will continue. This sets dummy port name to current port name. Append them in single line using join
     ![image](https://github.com/user-attachments/assets/51418c41-20d4-4d10-b296-e6768c1a99dd)
     

#### Convert set_clock_latency SDC to opentimer format
  1. Need to get the list for the delay
     ![image](https://github.com/user-attachments/assets/d0d4248d-1f19-4d56-849a-07c4eb90feda)
  2. Move through each element as per the {} characters which is 4. Now need to loop through each and every one
  3. Delay value will be taken as per the get_clocks, by which we can navigate it using the index. Append the value from the list
     ![image](https://github.com/user-attachments/assets/9085a8ac-d5b2-4f44-8ec0-4ed954832a14)
  4. Repeat this for all the elements in the loop
  5. Arrange the values ![image](https://github.com/user-attachments/assets/6a51a407-e26e-40a1-a2ac-79fde7581bc1)
  6. For the second clock, the new port name and the current name is same
     ![image](https://github.com/user-attachments/assets/8661f6e0-e989-4e5c-8b78-790e59e85a57)
  7. So it will not enter into the loop as the value will be same and give a null value
  8. Close the tmp file


#### Script for convert transtion and input delay to opentimer format
![image](https://github.com/user-attachments/assets/d2ffd8f1-d080-42a5-8d92-339e03f42245)
  1. Similar to the previous ones, only it has updated the slew from arrival to set_input_transition

#### Script for convert output delay to opentimer format
![image](https://github.com/user-attachments/assets/24d063b9-39be-419e-89b6-7c4ba2038305)
  1. Model the load for the output capacitance
  2. It is a single value that needs to be set
     ![image](https://github.com/user-attachments/assets/de82fac0-328a-4954-87dd-a3f37ef1b90d)
  3. Only the search pattern changes, others remain the same
     ![image](https://github.com/user-attachments/assets/1abe5c3d-3d0d-4c32-bf31-5b6c46a9ca74)

### Process bussed ports and configuration file creation
#### Script to expand bussed input ports for arrival time constraints


#### Script to convert all bussed constraints to bit-blasted
![image](https://github.com/user-attachments/assets/392cb5e4-3b14-4c30-9c16-8bec1a9ebce5)
  1. The load also needs to be added for bit-blasted data
  2. Output will be visible like this:
     ![image](https://github.com/user-attachments/assets/0ff91aa0-679b-4593-9690-f8965d1a4640)


#### Opentimer configuration file creation
  1. This format is required by Opentimer tool to execute the timing reports
     ![image](https://github.com/user-attachments/assets/ef96a6ea-ba6b-42fd-bf4f-ee228af7de9f)
  2. The .conf file will be input to the tool to generate STA data
  3. Will be creating spefs for sampling to the tool
     ![image](https://github.com/user-attachments/assets/f4ff7436-4eed-4417-93be-67ae80b40b00)
       a. This will create a blank SPEF using the data
       b. Then will append in the .conf file. Using appnd mode, it will add new data in the existing file
       c. Add the new commands for analysis for the deisgn
       d. Parasitics will give output like this:
       ![image](https://github.com/user-attachments/assets/dfd71e78-005a-4255-8947-017a1030d62a)
       e. The further commands appends are added at the last
       ![image](https://github.com/user-attachments/assets/a1eb73f1-698c-4803-9744-4842a605c228)


### Quality of results (QoR) generation algorithm
#### Script to obtain STA runtime
  1. As per EDA vendors, there are different formats
     ![image](https://github.com/user-attachments/assets/5b355a51-243e-4587-b1ec-89241c073809)
  2. For runtime extraction for opentimer tool. Same can be done for entier flow as well. It depends on the CPU , memory availablity
  3. 'time" is a tcl command to check the time in micro-seconds (us)
  4. Now need to convert it to preferred format
     ![image](https://github.com/user-attachments/assets/962aca2f-5989-4ba4-9181-3472cd6928cc)
  5. Print the puts command for information to the user to understand
  6. Since we are redirecting the whole opentimer command to the .results area, we are displaying for the user to check for warnings and errors in the file
     ![image](https://github.com/user-attachments/assets/7ea9e5f9-b71a-4f52-a25f-47a87c76a5a6)

#### Script to obtain WNS and FEP for reg2out violations
  1. Results that will be displayed for the STA
     ![image](https://github.com/user-attachments/assets/c27c2e8c-9aca-49c6-8d50-4d919de29052)

  2. RAT will display the slack data. SO this keyword in the results file will have all the slack data. So to calculate, the worst RAT / WNS, will be able to check easily
  ![image](https://github.com/user-attachments/assets/88277481-4080-441a-9e01-0b5725e1018e)
  3. Need a while loop to check the worst value
     ![image](https://github.com/user-attachments/assets/6d184ac7-b55d-41e3-b103-29faeb625bc9)
     a. If there are no violations, need to pront "-"
     b. Check for the regexp for the RAT in the file that is being read
     c. Print the RAT in "ns"
     d. Read the line for RAT, increment the count for the while loop
     ![image](https://github.com/user-attachments/assets/f72cbf65-2e9b-4e95-a623-05d8c3d5862f)

#### Script for instance count, WNS and FEP for setup and hold
  1. Same loop can be used by reading the results file as per the pattern
     Instance count:
     ![image](https://github.com/user-attachments/assets/61f5f2b7-10f7-4624-8af2-619108eebca1)
     Setup violations:
     ![image](https://github.com/user-attachments/assets/3bae3875-6b40-4c18-81a6-e79fe46661f6)
     Hold Violations:
     ![image](https://github.com/user-attachments/assets/e9a60708-ed4a-4093-ad99-d4e9160c02cb)

#### Script for report formatting
  ![image](https://github.com/user-attachments/assets/b727272d-574f-46f8-8eb6-52e276112e8e)
  1. %15s is a conversion specifier. FOr string, %s is string and 15 is spacing
  2. Now align the data as list and feed it to the table
     ![image](https://github.com/user-attachments/assets/15253e4b-d337-4aa3-be84-9f985afa9a23)
  3. Use the string separator as per the headings
     ![image](https://github.com/user-attachments/assets/aa5d29a8-0bae-4e1b-b8c3-01cb0a792d0a)
     ![image](https://github.com/user-attachments/assets/27849bd3-1e94-469e-aa1d-08204c32e6e0)












     




     

























  


































