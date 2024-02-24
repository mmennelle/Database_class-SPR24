import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class Ph4SqlInsertion {

    public static void main(String[] args) throws IOException {
        for(String tableName : args) {
            String fileIn = tableName + ".txt";
            String fileOut = tableName + ".sql";

            try (Scanner scanIn = new Scanner(new File(fileIn)); FileWriter scanOut = new FileWriter(fileOut)) {

                while (scanIn.hasNextLine()) {
                    String line = scanIn.nextLine();
                    String[] eachPart = line.split(",");
                    ArrayList<String> formattedValues = new ArrayList<>();

                    for (String part : eachPart) {
                        part = part.trim();
                        formattedValues.add(valueFormatForSql(part));
                    }
                    String combinedValues = String.join(",", formattedValues);
                    String insertStatement = String.format("INSERT INTO %s VALUES(%s);\n", tableName, combinedValues);
                    scanOut.write(insertStatement);
                }
                scanOut.write("commit;\n");
            }
        }
    }
    private static String valueFormatForSql(String type) {
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

        return "'" + type.replace("'", "''") + "'";
    }
}
