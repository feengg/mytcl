package edu.bonn.cs.iv.bonnmotion.models;

import java.io.*;

import edu.bonn.cs.iv.bonnmotion.*;

/** Application to construct static scenarios. */

public class Static extends Scenario {
	private static final String MODEL_NAME = "Static";

	protected int densityLevels = 1;

	public Static(int nodes, double x, double y, double duration, double ignore, long randomSeed, int densityLevels, double[] aFieldParams) {
		super(nodes, x, y, duration, ignore, randomSeed);
		this.densityLevels = densityLevels;
		this.aFieldParams = aFieldParams;
		generate();
	}

	public Static( String[] args ) {
		go(args);
	}
	
	public void go( String[] args ) {
		super.go(args);
		generate();
	}

	public void generate() {
		preGeneration();

		if (! isTransition) {

			double dx = x / (double)densityLevels;
			double dn = (double)node.length / (double)densityLevels;
			int n = 0;
			for (int l = 1; l <= densityLevels; l++) {
				double hx;
				int hn;
				if (l == densityLevels) {
					hx = x;
					hn = node.length;
				} else {
					hx = dx * (double)l;
					hn = (int)(dn * (double)l + 0.5);
				}
				double xSave = x;
				x = hx;
				for (int i = n; i < hn; i++) {
					Position pos;
					do {
						pos = randomNextPosition();
					} while (pos.x > x); // this may happen because of the attractor field
					if (! (node[i] = new MobileNode()).add(0.0, pos))
						throw new RuntimeException(MODEL_NAME + ".go: error while adding waypoint");
				}
				x = xSave;
				n = hn;
			}
		
		}
		postGeneration();
	}

	protected boolean parseArg(String key, String val) {
		if (key.equals("densityLevels")) {
			densityLevels = Integer.parseInt(val);
		} else return super.parseArg(key, val);
		return true;
	}

	public void write( String _name ) throws FileNotFoundException, IOException {
		String[] p = new String[1];
		p[0] = "densityLevels=" + densityLevels;
		super.write(_name, p);
	}

	protected boolean parseArg(char key, String val) {
		switch (key) {
			case 'l':
				densityLevels = Integer.parseInt(val);
				return true;
			default:
				return super.parseArg(key, val);
		}
	}
	
	public static void printHelp() {
		Scenario.printHelp();
		System.out.println( MODEL_NAME + ":" );
		System.out.println("\t-l <no. density levels>");
	}
}
