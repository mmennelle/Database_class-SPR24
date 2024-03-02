/*
 * Mitchell Mennelle
 * Dr.Wagner CSCI4125
 * Phase 3 - SQL Insert Generator
 * */

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class SqlInsertion {

    public static void main(String[] args) throws IOException {
        if(args.length !=1){
            System.out.println("Input only one table name.");
            return;
        }
        String tableName = args[0];
        String fileIn = tableName + ".txt";    //input file
        String fileOut = "Output.sql";         //output file

        try (Scanner scanIn = new Scanner(new File(fileIn))) { //scanner in object
            FileWriter scanOut = new FileWriter(fileOut);   //filewriter out object

            while (scanIn.hasNextLine()) {  // conditonal check for next line
                String line = scanIn.nextLine();
                String[] eachPart = line.split(","); //submitting each parsed line into string[]
                ArrayList<String> formattedValues = new ArrayList<>(); // created to store data types as they are processed

                for (String part : eachPart) {      //word for word in each stored String in String[]
                    part = part.trim(); // trim whitespace
                    formattedValues.add(valueFormatForSql(part)); //call valueFormatForSql process method. add to arraylist<>
                }
                String combinedValues = String.join(",", formattedValues); //joins each data type stored in formattedValues using a comma
                String insertStatment = String.format("INSERT INTO %s VALUES(%s);\n", tableName, combinedValues);
                scanOut.write(insertStatment); //Write to scanOut file.
            }
            scanOut.close(); // flush fileWriter buffer. I always forget this part at first.
        }

    }
    private static String valueFormatForSql(String type){ //This method utilizes Integer/Float.parseInt/Float() to
        //determine if a string can be converted to respective data type
        //based on whether the string contains numerical data or not.
        if(type.equalsIgnoreCase("NULL")){
            return "NULL";
        }

        try {
            Integer.parseInt(type);
            return type;
        } catch (NumberFormatException e) {
        }

        try {
            Float.parseFloat(type);
            return type;
        } catch (NumberFormatException e) {
        }

        return "'" + type + "'";
    }
}

