package edu.bonn.cs.iv.bonnmotion.apps;

import java.io.*;

import edu.bonn.cs.iv.bonnmotion.App;
import edu.bonn.cs.iv.bonnmotion.Scenario;

/** Application to save a certain timeframe from one scenario into a new file. */

public class Cut extends App {
	protected double begin = 0.0;
	protected double end = 0.0;
	protected String source = null;
	protected String destination = null;

	public Cut(String[] args) throws FileNotFoundException, IOException {
		go( args );
	}

	public void go( String[] args ) throws FileNotFoundException, IOException {
		parse(args);
		if ((source == null) || (destination == null) || (end == 0.0)) {
			printHelp();
			System.exit(0);
		}
	
		Scenario s = new Scenario( source ); 

		s.cut(begin, end);
		s.write(destination, new String[0]);
	}

	protected boolean parseArg(char key, String val) {
		switch (key) {
			case 'b': // "begin"
				begin = Double.parseDouble(val);
				return true;
			case 'd':
				destination = val;
				return true;
			case 'e': // "end"
				end = Double.parseDouble(val);
				return true;
			case 's': // "source"
				source = val;
				return true;
			default:
				return super.parseArg(key, val);
		}
	}

	public static void printHelp() {
		App.printHelp();
		System.out.println("Cut:");
		System.out.println("\t-b <beginning of timeframe>");
		System.out.println("\t-d <destination file name>");
		System.out.println("\t-e <end of timeframe>");
		System.out.println("\t-s <source file name>");
	}

	public static void main(String[] args) throws FileNotFoundException, IOException {
		new Cut(args);
	}
}
