/*
* Mitchell Mennelle
* Database Systems
* Phase 6 task 2 */

import java.io.*;
import java.util.*;

public class DatabasePhase6 {

    public static void main(String[] args) throws FileNotFoundException {

        Part1();
        Part2();
    }

    private static void Part1() throws FileNotFoundException {
        HashMap<String, String> employeeMap = new HashMap<>();
        HashSet<String> addressSet = new HashSet<>();


        Scanner employeeInput = new Scanner(new File("employee.txt"));
        while (employeeInput.hasNextLine()) {
            String line = employeeInput.nextLine();
            String[] parts = line.split(",");

            employeeMap.put(parts[0].trim(), parts[1].trim());
        }
        employeeInput.close();

        Scanner addressInput = new Scanner(new File("address.txt"));
        while (addressInput.hasNextLine()) {
            String line = addressInput.nextLine();
            String[] parts = line.split(",");
            if (parts[1].trim().length() > 0) {
                addressSet.add(parts[0].trim());
            }
        }
        addressInput.close();

        System.out.println("1. Names of all employees with at least one address:\n");
        List<String> batch = new ArrayList<>();
        for (String empId : addressSet) {
            if (employeeMap.containsKey(empId)) {
                batch.add(employeeMap.get(empId));
                if (batch.size() == 10) {
                    printAndClearBatch(batch);
                }
            }
        }

        if (!batch.isEmpty()) {
            printAndClearBatch(batch);
        }
    }

    private static void printAndClearBatch(List<String> batch) {
        System.out.println(String.join(", ", batch));
        batch.clear();
    }

    private static void Part2() throws FileNotFoundException {
        HashMap<String, Float> hoursMap = new HashMap<>();

        Scanner timecardInput = new Scanner(new File("timecard.txt"));
        while (timecardInput.hasNextLine()) {
            String line = timecardInput.nextLine();
            String[] parts = line.split(",");
            String empId = parts[0].trim();
            float hours = Float.parseFloat(parts[2].trim());
            hoursMap.put(empId, hoursMap.getOrDefault(empId, 0f) + hours);
        }
        timecardInput.close();


        System.out.println("\n2. Total hours per Employee ID:");
        List<String> sortedKeys = new ArrayList<>(hoursMap.keySet());
        Collections.sort(sortedKeys);
        for (String empId : sortedKeys) {
            System.out.printf("%s: %.2f hours\n", empId, hoursMap.get(empId));
        }
    }
}
