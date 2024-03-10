/*
* Mitchell Mennelle
* Phase 5 - Task 2
* SQL Output = Project Manager */

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class MaxSalaryPosition {

    public static void main(String[] args) {
        String fileName = "src/position.txt"; // Hardcoded Filepath
        List<String> positionsWithMaxSalary = MaxSalaryPos(fileName);

        for (String position : positionsWithMaxSalary) { // I looped this BC i didnt want to assume always one item output.
            System.out.println(position);
        }
    }

    public static List<String> MaxSalaryPos(String fileName) {
        List<String> positions = new ArrayList<>();
        double maxSalary = Double.MIN_VALUE;

        try (BufferedReader posInput = new BufferedReader(new FileReader(fileName))) {
            String line;

            while ((line = posInput.readLine()) != null) {
                String[] parts = line.split(",");
                String posName = parts[1].trim();
                double salary = Double.parseDouble(parts[2].trim());

                if (salary > maxSalary) {
                    maxSalary = salary;
                    positions.clear();
                    positions.add(posName);
                } else if (salary == maxSalary) {
                    positions.add(posName);
                }
            }
        } catch (IOException e) {
            System.err.println("An error occurred while reading the file.");
            e.printStackTrace();
        }

        return positions;
    }
}
