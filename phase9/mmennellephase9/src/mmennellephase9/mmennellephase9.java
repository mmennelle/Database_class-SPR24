package mmennellephase9;

import java.sql.*;
import java.util.Scanner;

public class mmennellephase9 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("What is the employee number? ");
        String employeeId = scanner.nextLine(); 

        //DB Connection
        String url = "jdbc:oracle:thin:@localhost:1521:Oracle21c"; 
        String user = "********";
        String password = "************";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            //employee name
            String employeeQuery = "SELECT e_name FROM employee WHERE e_id = ?";
            try (PreparedStatement rptCard = conn.prepareStatement(employeeQuery)) {
                rptCard.setString(1, employeeId);
                ResultSet resultSet = rptCard.executeQuery();
                if (!resultSet.next()) {
                    System.out.println("No report card to generate!");
                    return;
                }
                String employeeName = resultSet.getString("e_name");
                System.out.println("Report Card for " + employeeId + ": " + employeeName);
                System.out.println(String.format("%-12s %-50s %s", "CourseID", "Course Name", "Grade"));
                System.out.println("------------------------------------------------------------------------");

                //course details
                String courseQuery = "SELECT c.c_id, c.c_name, e.enroll_grade FROM course c, enrollment e WHERE c.c_id = e.enroll_c_id AND e.enroll_e_id = ?";
                try (PreparedStatement pstmtCourse = conn.prepareStatement(courseQuery)) {
                    pstmtCourse.setString(1, employeeId);
                    ResultSet rsCourse = pstmtCourse.executeQuery();

                    int totalGradePoints = 0;
                    int courseCounter = 0;
                    while (rsCourse.next()) {
                        String courseCode = rsCourse.getString("c_id");
                        String courseTitle = rsCourse.getString("c_name");
                        String courseGrade = rsCourse.getString("enroll_grade").trim();
                        System.out.println(String.format("%-9s %-50s  %s", courseCode, courseTitle, courseGrade));

                        int gradePoints = switch (courseGrade) {
                            case "A" -> 4;
                            case "B" -> 3;
                            case "C" -> 2;
                            case "D" -> 1;
                            default -> 0;
                        };

                        totalGradePoints += gradePoints;
                        courseCounter++;
                    }

                    //GPA
                    if (courseCounter > 0) {
                        float calculatedGpa = (float) totalGradePoints / courseCounter;
                        System.out.printf("Total GPA: %.2f\n", calculatedGpa);
                    } else {
                        System.out.println("No report card to generate!");
                    }
                }
            }
        } catch (SQLException ex) {
            System.out.println("Uh-Oh Connection Failed!");
            ex.printStackTrace();
        } finally {
            scanner.close(); 
        }
    }
}
