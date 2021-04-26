package edu.csulb.semantics.project3;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.jena.ontology.OntModelSpec;
import org.apache.jena.query.QueryExecution;
import org.apache.jena.query.QueryExecutionFactory;
import org.apache.jena.query.QueryFactory;
import org.apache.jena.query.QuerySolution;
import org.apache.jena.query.ResultSet;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.util.FileManager;

public class SparqlerQueryProcessor {

	public static String sparql(String mQueryText, Model model) {
		ResultSet results = null;
		String output = "";
		
			// Execute query
		try (QueryExecution queryExecution = QueryExecutionFactory.create(QueryFactory.create(mQueryText), model)) {
			results = queryExecution.execSelect();
			List<String> columnNames = results.getResultVars();

			// Prepare output to display in UI
			output += "<tr>";
			if (!results.hasNext()) {
				// Handle empty result set for a query
				output += "<td>" + "No results found for entered query!" + "</td>";
				output += "</tr>";
			} else {
				for (String column : columnNames) {
					output += "<th>" + column + "</th>";
				}
				output += "</tr>";

				while (results.hasNext()) {
					output += "<tr>";
					QuerySolution row = results.nextSolution();
					for (int i = 0; i < columnNames.size(); i++) {
						String columnName = columnNames.get(i);
						String value = row.getLiteral(columnName).getString();
						output += "<td>" + value + "</td>";
					}
					output += "</tr>";
				}
			}
		} catch (Exception e) {
			// Handle invalid query
			output += "<tr>";
			output += "<td>" + "Please enter a valid query!" + "</td>";
			output += "</tr>";
			e.printStackTrace();
		}
		return output;
	}

	static Model model;

	public static Model init(String path) {
		
		model = ModelFactory.createOntologyModel(OntModelSpec.OWL_DL_MEM_RULE_INF);
		if (path == null)
			path = "";
		// Open owl file to read the content for the path entered by user
		InputStream modelStream = FileManager.get().open(path);

		if (modelStream == null) {
			throw new RuntimeException("Can't find ontology file");
		}
		// Build model for the given owl file
		model.read(modelStream, null);
		try {
			modelStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return model;
	}
}