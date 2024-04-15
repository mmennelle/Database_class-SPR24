/*
* Mitchell Mennelle
* Dr.Wagner CSCI4125
* Phase 1 - Java Review
* */
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class JavaReview {

    public static void main(String[] args) throws IOException {
        String fileIn = "src/phase1_spring2024.txt";    //input file
        String fileOut = "Output.csv";                  //output file

        try (Scanner scanIn = new Scanner(new File(fileIn))) { //scanner in object
            FileWriter scanOut = new FileWriter(fileOut);   //filewriter out object

            while (scanIn.hasNextLine()) {  // conditonal check for next line
                String line = scanIn.nextLine();
                String[] eachPart = line.split(","); //submitting each parsed line into string[]
                ArrayList<String> dataTypes = new ArrayList<>(); // created to store data types as they are processed

                for (String part : eachPart) {      //word for word in each stored String in String[]
                    part = part.trim(); // trim whitespace
                    dataTypes.add(DataTypeProcessing(part)); //call to data type process method. add to arraylist<>
                }
                String combinedDataTypes = String.join(",", dataTypes); //joins each data type stored in dataTypes using a comma
                scanOut.write(combinedDataTypes + "\n"); //Write to scanOut file.
            }
            scanOut.close(); // flush fileWriter buffer. I always forget this part at first.
        }

    }
    private static String DataTypeProcessing(String Type){ //This method utilizes Integer/Float.parseInt/Float() to
                                                           //determine if a string can be converted to respective data type
                                                           //based on whether the string contains numerical data or not.
        try {
            Integer.parseInt(Type);
            return "Integer";
        } catch (NumberFormatException e) {
        }

        try {
            Float.parseFloat(Type);
            return "Float";
        } catch (NumberFormatException e) {
        }

        return "String";
    }
    }

