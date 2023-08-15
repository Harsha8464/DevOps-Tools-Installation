###################Dependencies java or jre#######

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.79/src/apache-tomcat-9.0.79-src.tar.gz

untar apache-9.0.79

sudo chown -R tomcat:tomcat /opt/tomcat/
sudo chmod -R u+x /opt/tomcat/bin

#To gain access to the Manager and Host Manager pages, you’ll define privileged users in Tomcat’s configuration. You will need to remove the IP address restrictions, which disallows all external IP addresses from accessing those pages.

sudo vim /opt/tomcat/conf/tomcat-users.xml

#Add the following lines before the ending tag:

<role rolename="manager-gui" />
<user username="manager" password="manager_password" roles="manager-gui" />

<role rolename="admin-gui" />
<user username="admin" password="admin_password" roles="manager-gui,admin-gui" />


#To remove the restriction for the Manager page, open its config file for editing:
sudo vim /opt/tomcat/webapps/manager/META-INF/context.xml

Comment out the Valve definition, as shown:

...
<Context antiResourceLocking="false" privileged="true" >
  <CookieProcessor className="org.apache.tomcat.util.http.Rfc6265CookieProcessor"
                   sameSiteCookies="strict" />
<!--  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" /> -->
  <Manager sessionAttributeValueClassNameFilter="java\.lang\.(?:Boolean|Integer|Long|Number|String)|org\.apache\.catalina\.filters\.Csr>
</Context>


#Save and close the file, then repeat for Host Manager:

sudo nano /opt/tomcat/webapps/host-manager/META-INF/context.xml

sudo systemctl daemon-reload

sudo systemctl start tomcat

sudo systemctl status tomcat

sudo systemctl enable tomcat

http://public_IP:8080/
