
public class DynamicJasperTemplate {
protected JasperPrint jp;
protected JasperReport jr;
protected Map params = new HashMap();
protected DynamicReport dr;
public void buildReport() throws Exception {
params.put("ReportTitle1", "Report Title");
DynamicReportBuilder drb = new DynamicReportBuilder();
Font font = new Font(10,"Sarif",true);
Style headerStyle = new Style();
headerStyle.setFont(font);
headerStyle.setHorizontalAlign(HorizontalAlign.LEFT);
headerStyle.setVerticalAlign(VerticalAlign.MIDDLE);
font = new Font(8,"Sarif",false);
Style detailStyle = new Style();
detailStyle.setFont(font);
detailStyle.setHorizontalAlign(HorizontalAlign.LEFT);
detailStyle.setVerticalAlign(VerticalAlign.MIDDLE);
for(int i=1; i<=10; i++) {
AbstractColumn column = ColumnBuilder.getInstance();
column.setColumnProperty("Column"+i, String.class.getName());
column.setTitle("Column "+i+" Title").setWidth(200);
column.setStyle(detailStyle).setHeaderStyle(headerStyle).build();
drb.addColumn(column);
}
drb.setUseFullPageWidth(true);
// Pass the JasperReport Template to DynamicJasper
drb.setTemplateFile("D:/DynamicJasperTemplate.jrxml");
DynamicReport dr = drb.build();
JRDataSource ds = getDataSource();
jr = DynamicJasperHelper.generateJasperReport(dr, new ClassicLayoutManager(),params);
if (ds != null) {
jp = JasperFillManager.fillReport(jr, params, ds);
} else {
jp = JasperFillManager.fillReport(jr, params);
}
JasperExportManager.exportReportToPdfFile(jp,"D:/report-out.pdf");
}
protected JRDataSource getDataSource() {
// Generate dummy data to show in the report.
List records = new ArrayList();
for(int i=1; i<10 i="i" span="span">
Map columns = new HashMap();
for (int j=1; j<=10; j++) {
// The HashMap Key must save with ColumnProperty Name
columns.put("Column"+j, "Record "+i+" Column "+j+" data.");
}
records.add(columns);
}
JRDataSource ds = new JRMapCollectionDataSource(records);
return ds;
}
public static void main(String[] args) throws Exception {
DynamicJasperTemplate djt = new DynamicJasperTemplate();
djt.buildReport();
}
}