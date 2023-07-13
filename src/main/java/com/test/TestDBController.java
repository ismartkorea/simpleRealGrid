package com.test;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test/test.do")
public class TestController {
	@Autowired private DataSource dataSource;
	
	@RequestMapping
	public void db(){
		Connection conn = null;
		try{
			conn = dataSource.getConnection();
			System.out.println(conn);
		}catch(SQLException e){
			System.out.println("db connection is not obtained");
			e.printStackTrace();
		}finally{
			if(conn != null) try{conn.close();} catch(SQLException e){};
		}
	}
}