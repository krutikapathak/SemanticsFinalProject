# SemanticsFinalProject

Steps:

1.	Download/Pull full project code from https://github.com/krutikapathak/SemanticsFinalProject
2.	Download TOMCAT server from  https://tomcat.apache.org/download-10.cgi depending on the OS(Project was run on version 9 and 10)
3.	Open Tomcat library file for edit mode apache-tomcat-10.0.5/conf/tomcat-users.xml
4.	Add below roles to the file inside "tomcat-users" tag.  
![alt text](https://github.com/krutikapathak/SemanticsFinalProject/blob/master/referenceimages/tomcat_users_setting.png?raw=true)  
5.	Go to the root directory of tomcat server and make sure bin folder has all read/write permissions.
6.	To add the missing permission for bin folder, run following commands:   
    a.	Mac:  chmod 777 bin from terminal.   
    b.	Windows: Right click on the bin folder of Tomcat -> Security -> Give full control to system by checking "Full control" box.  
7.	Add same permission to the following files if not already given:    
    a.  Mac: chmod 777 catalina.sh      
    b.  Windows: Right click on the Catalina.bat file -> Security -> Give full control to system by checking "Full control" box.     
8.	Go to the bin folder of the server dir in cmd/terminal and run below commands:     
    a.	sh startup.sh (macOS)       
    b.	startup.bat (windows)        
9.	Once the server starts, open any browser (following was tested on Chrome) and open http:localhost:8080
10.	Below window will appear 
![alt text](https://github.com/krutikapathak/SemanticsFinalProject/blob/master/referenceimages/tomcat_home.png?raw=true)
11.	Click on the manager app button as highlighted above and enter the username and password as shown in point 4 (In this case, username= “team4” and password = “password”).
12.	Below page for the WAR file deployment will appear. Select the highlighted button to browse and deploy the WAR file. It will take few seconds to minutes depending on the machine 
![alt text](https://github.com/krutikapathak/SemanticsFinalProject/blob/master/referenceimages/tomcat_upload_war.png?raw=true)
13.	Open new tab and run http://localhost:8080/Project3-Semantics/ 
14.	Enter the path to the “Crashes.owl” file (Eg: /Users/janedoe/Downloads/test.owl).
15.	Enter the Question(optional) and SPARQL query from the Project3_Queries.docx. Click on “Execute” to fetch the results. 
