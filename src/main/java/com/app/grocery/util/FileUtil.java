package com.app.grocery.util;

import java.io.*;
import java.util.*;

public class FileUtil {
    public static List<String> readLines(String path) {
        List<String> lines = new ArrayList<>();
        File file = new File(path);
        if (!file.exists()) return lines; // Return empty if file doesn't exist

        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = br.readLine()) != null) lines.add(line);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return lines;
    }


    public static void writeLines(String path, List<String> lines) {
        try {
            File file = new File(path);
            System.out.println("Writing to: " + file.getAbsolutePath());

            // Create parent directories if needed
            File parent = file.getParentFile();
            if (parent != null && !parent.exists()) {
                parent.mkdirs();
            }

            // Create the file if it doesn't exist
            if (!file.exists()) {
                file.createNewFile();
            }

            // Write data
            try (BufferedWriter bw = new BufferedWriter(new FileWriter(file))) {
                for (String line : lines) {
                    bw.write(line);
                    bw.newLine();
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

