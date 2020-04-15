package com.olc.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbUtil {

	private static Connection conn=null;
	public static Connection getConnection()
	{
		if(conn !=null) //if there is a connection already return it, otherwise establish one 
			return conn;
		else
		{
			try
			{
				String url = "jdbc:mysql://127.0.0.1/olc";
		       
				String driver = "com.mysql.jdbc.Driver";
				String username= "root";
				String password= "";
				Class.forName(driver);
				conn= DriverManager.getConnection(url,username,password);
			}
			catch (ClassNotFoundException e) 
			{
                e.printStackTrace();
            }
			catch (SQLException e) 
			{
                e.printStackTrace();
		
			}
			return conn;
		}
		
	}
}