package edu.bonn.cs.iv.bonnmotion.apps;

import java.io.*;

import edu.bonn.cs.iv.bonnmotion.*;
import edu.bonn.cs.iv.bonnmotion.models.DisasterArea;

/** Application that creates a movement file for ns-2. */

public class NSFile extends App {
	/** Add border around the scenario to prevent ns-2 from crashing. */
	public static final double border = 10.0;

	String routingprotocol = new String();
	int[] mcastgroups = null;

	protected String name = null;

	public NSFile(String[] args) {
		go( args );
	}

	public void go( String[] args ) {
		parse(args);

		Scenario s = null;
		if ( name == null ) {
			printHelp();
			System.exit(0);
		}

		try {
			s = new Scenario(name);
		} catch (Exception e) {
			App.exceptionHandler( "Error reading file", e);
		}

		if(s.getModelName().equals(DisasterArea.MODEL_NAME)){
			MobileNode[] node = s.getNode();
			System.out.println("count of nodes: "+node.length);
			//CatastropheNode[] node = s.getCatastropheNode();

			PrintWriter settings = openPrintWriter(name + ".ns_params");
			settings.println("set val(x) " + (s.getX() + 2 * border));
			settings.println("set val(y) " + (s.getY() + 2 * border));
			settings.println("set val(nn) " + node.length);
			settings.println("set val(duration) " + s.getDuration());
			settings.close();

			try{
				//System.out.println("Here we are again2");
				//String allmovements = s.read(name);
				String allmovements = s.movements;
				if (allmovements == null) {
					allmovements = s.read(name);
				}
				//System.out.println("Here we are again3");

				//System.out.println(allmovements);
				String[] m = allmovements.split("\n");
				//System.out.println(m[0]);
				//System.out.println("Here "+m.length);
				//String towrite = new String();
				PrintWriter movements_ns = openPrintWriter(name + ".ns_movements");
				//System.out.println("Here open file");			
				//one entry of m contains all movement and status information for one node
				for(int i = 0; i < m.length; i++){
					//System.out.println(m[i]);
					String[] oneWaypoint = m[i].split(" ");
					
					StringBuilder towriteBuilder = new StringBuilder();
					towriteBuilder.append("$node_(");
					towriteBuilder.append(i);
					towriteBuilder.append(")");
					towriteBuilder.append(" set X_ ");
					towriteBuilder.append(oneWaypoint[2]);
					towriteBuilder.append("\n");
					towriteBuilder.append("$node_(");
					towriteBuilder.append(i);
					towriteBuilder.append(")");
					towriteBuilder.append(" set Y_ ");
					towriteBuilder.append(oneWaypoint[3]);
					movements_ns.println(towriteBuilder.toString());
					//System.out.println("First Write to file");			

					for(int j = 4; j < oneWaypoint.length-1; j=j+4){
						Double time = new Double(oneWaypoint[j+1]);
						Double newx = new Double(oneWaypoint[j+2]);
						Double newy = new Double(oneWaypoint[j+3]);
						Double status = new Double(oneWaypoint[j+4]);
						Double oldtime = new Double(oneWaypoint[j-3]);
						Double oldx = new Double(oneWaypoint[j-2]);
						Double oldy = new Double(oneWaypoint[j-1]);
						Position newWaypoint = new Position(newx.doubleValue(), newy.doubleValue());
						Position oldWaypoint = new Position(oldx.doubleValue(), oldy.doubleValue());
						//System.out.println("drin steht time " + time + " newx " + newx + " newy " + newy + " status " + status + " oldtime " + oldtime + " oldx " + oldx + " oldy " + oldy);
						double dist = newWaypoint.distance(oldWaypoint);

						towriteBuilder = new StringBuilder();
						towriteBuilder.append("$ns_ at ");
						towriteBuilder.append(time.doubleValue());
						towriteBuilder.append(" \"");
						towriteBuilder.append("$node_(" + i + ")");
						towriteBuilder.append(" setdest ");
						towriteBuilder.append(newx.doubleValue() + border);
						towriteBuilder.append(" ");
						towriteBuilder.append(newy.doubleValue() + border);
						towriteBuilder.append(" ");
						towriteBuilder.append((dist / (time.doubleValue() - oldtime.doubleValue())));
						towriteBuilder.append(" ");
						towriteBuilder.append(status.doubleValue());
						towriteBuilder.append("\"");
						//System.out.println(towrite);
						movements_ns.println(towriteBuilder.toString());
						if(status.doubleValue() == 2.0){
							String towrite;
							towrite = "set RoutingAgent [$node_(" + i + ") agent 255]";
							movements_ns.println(towrite);
							towrite = "$ns_ at " + time.doubleValue() + " \"$RoutingAgent deactivate\"" ;
							movements_ns.println(towrite);
						}
						if(status.doubleValue() == 1.0){
							String towrite;
							towrite = "set RoutingAgent [$node_(" + i + ") agent 255]";
							movements_ns.println(towrite);
							towrite = "$ns_ at " + time.doubleValue() + " \"$RoutingAgent activate\"" ;
							movements_ns.println(towrite);
						}
					}
				}
				movements_ns.close();
			}
			catch(Exception e){
				System.out.println("Error in NSFile, while reading node movements");
				System.exit(0);
			}
			return;
		}


		MobileNode[] node = s.getNode();
		System.out.println("movement string " + node[0].movementString());

		PrintWriter settings = openPrintWriter(name + ".ns_params");
		settings.println("set val(x) " + (s.getX() + 2 * border));
		settings.println("set val(y) " + (s.getY() + 2 * border));
		settings.println("set val(nn) " + node.length);
		settings.println("set val(duration) " + s.getDuration());
		settings.close();

		PrintWriter movements_ns = openPrintWriter(name + ".ns_movements");
		for (int i = 0; i < node.length; i++) {
			String[] m = node[i].movementStringNS("$node_(" + i + ")", border);
			for (int j = 0; j < m.length; j++){
				movements_ns.println(m[j]);
				System.out.println(m[j]);
			}
		}
		movements_ns.close();
	}

	protected boolean parseArg(char key, String val) {
		switch (key) {
		case 'f':
			name = val;
			return true;
		default:
			return super.parseArg(key, val);
		}
	}

	public static void printHelp() {
		System.out.println();
		App.printHelp();
		System.out.println("NSFile:");
		System.out.println("\t-f <filename>");
	}

	public static void main(String[] args) throws FileNotFoundException, IOException {
		new NSFile(args);
	}
}
