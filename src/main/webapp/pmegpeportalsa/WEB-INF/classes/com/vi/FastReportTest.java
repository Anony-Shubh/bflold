   /*
2    * DynamicJasper: A library for creating reports dynamically by specifying
3    * columns, groups, styles, etc. at runtime. It also saves a lot of development
4    * time in many cases! (http://sourceforge.net/projects/dynamicjasper)
5    *
6    * Copyright (C) 2008  FDV Solutions (http://www.fdvsolutions.com)
7    *
8    * This library is free software; you can redistribute it and/or
9    * modify it under the terms of the GNU Lesser General Public
10   *
11   * License as published by the Free Software Foundation; either
12   *
13   * version 2.1 of the License, or (at your option) any later version.
14   *
15   * This library is distributed in the hope that it will be useful,
16   * but WITHOUT ANY WARRANTY; without even the implied warranty of
17   *
18   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
19   *
20   * Lesser General Public License for more details.
21   *
22   * You should have received a copy of the GNU Lesser General Public
23   * License along with this library; if not, write to the Free Software
24   *
25   * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
26   *
27   *
28   */
29  
30  package com.vi;
31  
32  
33  import java.util.Date;
34  import java.util.Map;
35  
36  import ar.com.fdvs.dj.domain.DJCalculation;
37  import ar.com.fdvs.dj.domain.DJValueFormatter;
38  import net.sf.jasperreports.view.JasperDesignViewer;
39  import net.sf.jasperreports.view.JasperViewer;
40  import ar.com.fdvs.dj.domain.DynamicReport;
41  import ar.com.fdvs.dj.domain.builders.FastReportBuilder;
42  
43  public class FastReportTest extends BaseDjReportTest {
44  
45  	public DynamicReport buildReport() throws Exception {
46  
47  
48  		/**
49  		 * Creates the DynamicReportBuilder and sets the basic options for
50  		 * the report
51  		 */
52  		FastReportBuilder drb = new FastReportBuilder();
53  		drb.addColumn("State", "state", String.class.getName(),30)
54  			.addColumn("Branch", "branch", String.class.getName(),30)
55  			.addColumn("Product Line", "productLine", String.class.getName(),50)
56  			.addColumn("Item", "item", String.class.getName(),50)
57  			.addColumn("Item Code", "id", Long.class.getName(),30,true)
58  			.addColumn("Quantity", "quantity", Long.class.getName(),60,true)
59  			.addColumn("Amount", "amount", Float.class.getName(),70,true)
60  			.addGroups(2)
61  			.setTitle("November " + getYear() + " sales report")
62  			.setSubtitle("This report was generated at " + new Date())
63  			.setPrintBackgroundOnOddRows(true)			
64  			.setUseFullPageWidth(true);
65  
66          drb.addGlobalFooterVariable(drb.getColumn(4), DJCalculation.COUNT, null, new DJValueFormatter() {
67  
68              public String getClassName() {
69                  return String.class.getName();
70              }
71  
72  
73              public Object evaluate(Object value, Map fields, Map variables,   Map parameters) {
74                  return (value == null ? "0" : value.toString()) + " Clients";
75              }
76          });
77  
78  
79  		DynamicReport dr = drb.build();
80  
81  		return dr;
82  	}
83  
84  	public static void main(String[] args) throws Exception {
85  		FastReportTest test = new FastReportTest();
86  		test.testReport();
87  		test.exportToJRXML();
88  		JasperViewer.viewReport(test.jp);	//finally display the report report
89  		JasperDesignViewer.viewReportDesign(test.jr);
90  	}
91  
92  }