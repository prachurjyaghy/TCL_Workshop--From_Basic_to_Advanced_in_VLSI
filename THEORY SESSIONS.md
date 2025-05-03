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
#### Scenw2 : .csv file does not exist

#### scene3: -help to find out usage







