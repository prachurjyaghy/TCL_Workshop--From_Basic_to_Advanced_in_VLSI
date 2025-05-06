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

#### Algorithm to categorize input ports as bits and bussed


#### File access and pattern creation steps

#### Regular expression and regular substitute to get fixed space strings

#### Read, split, uniquify, sort and join input ports to remove duplication

#### Evaluate the length of the string

#### 



































