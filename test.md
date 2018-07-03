/**
 * Copyright 2013-2016 Automatak, LLC
 *
 * Licensed to Automatak, LLC (www.automatak.com) under one or more
 * contributor license agreements. See the NOTICE file distributed with this
 * work for additional information regarding copyright ownership. Automatak, LLC
 * licenses this file to you under the Apache License Version 2.0 (the "License");
 * you may not use this file except in compliance with the License. You may obtain
 * a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0.html
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package com.automatak.dnp3.mock;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.automatak.dnp3.*;


public class PrintingSOEHandler implements SOEHandler {
	
		
    private static PrintingSOEHandler instance = new PrintingSOEHandler();
    private static Connection con;
    private static HashMap<String, Integer[]> resultMap = new HashMap<String, Integer[]>();
    private static boolean isFirst;
    
    
    public static SOEHandler getInstance() throws Exception {
    	con = DriverManager.getConnection(
		        "jdbc:mysql://guzmanenergy.cnb0l8fplqhl.us-east-1.rds.amazonaws.com:3306/etrm_ge",
		        "bwu",
		        "GuzmanWu&!1234!&");
//    	resultMap.put("ppa_id",new ArrayList<Integer>() );
//    	resultMap.get("ppa_id").add(1);
//		
//    	resultMap.put("data_time",new ArrayList<String>() );
//    	resultMap.get("data_time").add("US/Eastern");
//		
//    	resultMap.put("time_zone",new ArrayList<Integer>() );
//    	resultMap.get("time_zone").add("US/Eastern");
//		

    	resultMap.put("Binary", new Integer[9] );
    	Arrays.fill(resultMap.get("Binary"), null);
    	resultMap.put("Counter",new Integer[10] );
    	Arrays.fill(resultMap.get("Counter"), null);
        resultMap.put("Analog",new Integer[16] );
        Arrays.fill(resultMap.get("Analog"), null);
        isFirst = true;
        return instance;
    }
    
    public static void close() throws Exception{
    	con.close();
    }

    private PrintingSOEHandler(){}

    @Override
    public void start()
    {
        System.out.println("start asdu");
    }

    @Override
    public void end()
    {
        System.out.println("end asdu");
    }

    @Override
    public void processBI(HeaderInfo info, Iterable<IndexedValue<BinaryInput>> values)
    {
        System.out.println(info);
        values.forEach((meas) -> System.out.println(meas));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	    Date resultdate = new Date(System.currentTimeMillis());
		values.forEach((meas) ->{
			if(Integer.parseInt(meas.toString().split(" - ")[0]) == 0 && !isFirst){
				
				String sql = "INSERT INTO dashboard_dnp3_new(ppa_id,data_time,time_zone,binary_0,binary_1,binary_2,binary_3,binary_4,binary_5,binary_6,binary_7,binary_8,"
						+ "counter_0,counter_1,counter_2,counter_3,counter_4,counter_5,counter_6,counter_7,counter_8,counter_9,"
						+ "analog_0,analog_1,analog_2,analog_3,analog_4,analog_5,analog_6,analog_7,analog_8,analog_9,analog_10,"
						+ "analog_11,analog_12,analog_13,analog_14,analog_15) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				try{
					PreparedStatement prep_stmt = con.prepareStatement(sql);
					prep_stmt.setInt(1, 1);   
					prep_stmt.setString(2, sdf.format(resultdate));
					prep_stmt.setString(3, "US/Eastern");
					for(int q =4; q<13 ; q++){
						if(resultMap.get("Binary")[q-4] == null){
							prep_stmt.setNull(q, java.sql.Types.NULL);
						}else{
							prep_stmt.setInt(q,resultMap.get("Binary")[q-4]);
						}
						
					}
					
					for(int q =13; q<23 ; q++){
						if(resultMap.get("Counter")[q-13] == null){
							prep_stmt.setNull(q, java.sql.Types.NULL);
						}else{
						prep_stmt.setInt(q,resultMap.get("Counter")[q-13]);
					}
					}
					
					for(int q =23; q<39 ; q++){
						if(resultMap.get("Analog")[q-23] == null){
							prep_stmt.setNull(q, java.sql.Types.NULL);
						}else{
						prep_stmt.setInt(q,resultMap.get("Analog")[q-23]);
						}
					}
						
						
					prep_stmt.execute();
					Arrays.fill(resultMap.get("Binary"), null);
			    	Arrays.fill(resultMap.get("Counter"), null);
			        Arrays.fill(resultMap.get("Analog"), null);
					
					
					
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			isFirst = false;
			if ((meas.toString().split("\\(")[1].split(", ")[0]).equals("false")){
				resultMap.get("Binary")[Integer.parseInt(meas.toString().split(" - ")[0])] = 0;
				
			}else{
				resultMap.get("Binary")[Integer.parseInt(meas.toString().split(" - ")[0])] = 1;
			}
			
		});
    }

    @Override
    public void processDBI(HeaderInfo info, Iterable<IndexedValue<DoubleBitBinaryInput>> values)
    {
        System.out.println(info);
        values.forEach((meas) -> System.out.println(meas));
        
    }

    @Override
    public void processAI(HeaderInfo info, Iterable<IndexedValue<AnalogInput>> values)
    {
        System.out.println(info);
        values.forEach((meas) -> System.out.println(meas));
        values.forEach((meas) ->{
        	resultMap.get("Analog")[Integer.parseInt(meas.toString().split(" - ")[0])] = Math.round(Float.valueOf(meas.toString().split("\\(")[1].split(", ")[0]));
			
		});
    }

    @Override
    public void processC(HeaderInfo info, Iterable<IndexedValue<Counter>> values)
    {
        System.out.println(info);
        values.forEach((meas) -> System.out.println(meas));
        
        values.forEach((meas) ->{
        	resultMap.get("Counter")[Integer.parseInt(meas.toString().split(" - ")[0])] = Math.round(Float.valueOf(meas.toString().split("\\(")[1].split(", ")[0]));
			
		});
    }

    @Override
    public void processFC(HeaderInfo info, Iterable<IndexedValue<FrozenCounter>> values)
    {
        System.out.println(info);
        values.forEach((meas) -> System.out.println(meas));
    }

    @Override
    public void processBOS(HeaderInfo info, Iterable<IndexedValue<BinaryOutputStatus>> values)
    {
        System.out.println(info);
        values.forEach((meas) -> System.out.println(meas));
    }

    @Override
    public void processAOS(HeaderInfo info, Iterable<IndexedValue<AnalogOutputStatus>> values)
    {
        System.out.println(info);
        values.forEach((meas) -> System.out.println(meas));
    }

    @Override
    public void processDNPTime(HeaderInfo info, Iterable<DNPTime> values)
    {
        System.out.println(info);
        values.forEach((meas) -> System.out.println(meas));
    }
}
