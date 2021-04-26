<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="edu.csulb.semantics.project3.*"%>
<%@ page import="org.apache.jena.query.*"%>
<%@ page import="org.apache.jena.rdf.model.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.nio.file.Paths"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="HomeStyle.css"/>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Semantic Data Generation</title>
<script type="text/javascript">
	/* UI validations and creating local cache  */
	function saveComment() {
		var query = document.getElementById("sparqlQuery").value;
		var question = document.getElementById("question").value;
		var path = document.getElementById("myfile").value;
		if (path == "") {
			alert("Please enter OWL file path to continue.");
			return false;
		}
		if (query == "") {
			alert("Please enter a SPARQL query to continue.");
			return false;
		}
		localStorage.setItem("query", query);
		localStorage.setItem("question", question);
		localStorage.setItem("path", path);
		return true;
	}

	/* Preload data from local cache if available to display in UI */
	function loadMe() {
		var results = document.getElementById("resultsdiv");
		var cache = localStorage.getItem("query");
		var question = localStorage.getItem("question");
		var path = localStorage.getItem("path");
		document.getElementById("sparqlQuery").value = cache;
		document.getElementById("question").value = question;
		document.getElementById("myfile").value = path;
		localStorage.removeItem("query");
		localStorage.removeItem("question");
		localStorage.removeItem("path");
		if (cache != null) {
			results.style.display = 'block';
			results.scrollIntoView({
				behavior : 'smooth'
			});
		}
	}
</script>
</head>
<body onload="loadMe();">
	<%
	// Fetch parameters for file path and query
	String file = request.getParameter("myfile");
	Model model = (Model) session.getAttribute("model");
	if (file != null) {
		// Create model only once if file path is different from the previous file path
		String path = (String) session.getAttribute("path");
		if (path == null || !file.equalsIgnoreCase(path) || model == null) {
			session.setAttribute("path", file);
			model = SparqlerQueryProcessor.init(file);
			session.setAttribute("model", model);
		}
	}
	// Run the entered query
	String mQueryText = request.getParameter("sparqlQuery");
	String output = "";
	if (mQueryText != null) {
		output = SparqlerQueryProcessor.sparql(mQueryText, model);
	}
	%>

		<div class="container">
		
			<div class="header">
				<img src="calstateuniv-longbeach-01.jpg" class="img">
				<h1>
					<b>SPARQL Query Editor</b>
				</h1>
			</div>
			<form method="post" name="resultForm" action="Home.jsp" onSubmit="return saveComment();">
			
			<div class="col-85">
				<label for="file"><b>OWL File <font color="red">*</font></b></label>
				<input type="text" id="myfile" name="myfile"
					placeholder="Enter path to .owl file. (Eg: /Users/janedoe/Downloads/test.owl)" />
			</div>
			
			<br> <br> <br> <br> <br> <br>
			
			<div class="col-85">
				<label for="question"><b>Question</b></label> <input type="text"
					id="question" name="question" placeholder="Enter Question">
			</div>
			
			<br> <br> <br> <br> <br> <br>
			
			<div class="col-85">
				<label for="sparqlquery"><b>SPARQL Query<font
						color="red">*</font></b></label>
				<textarea name="sparqlQuery" id="sparqlQuery"
					placeholder="Enter SPARQL Query"></textarea>
				<center>
					<input type="submit" Value="Execute" class="button" />
					<button type="reset" class="button"
						onclick="localStorage.removeItem('query'); document.getElementById('resultsdiv').style.display= 'none';">Clear</button>
				</center>
			</div>
			
			</form>
			
			<br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br><br>
			
			<div class="col-85" style="display: none;" id="resultsdiv">
				<label for="results"><b>Results</b></label>
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0" border="1" style="border-collapse: collapse;">
					<%= output%>
				</table>
			<br> <br>
			</div>
		</div>
</body>
</html>