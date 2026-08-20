package com.vi;

import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.*;
import net.sf.jasperreports.engine.type.HorizontalAlignEnum;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Vivek on 1/5/14.
 */
public class DynamicJasperSample {


    public static void main(String[] args) throws Exception {
        JasperReport jasperReport;
        DynamicJasperSample dynamicJasperSample = new DynamicJasperSample();
        JasperDesign design = dynamicJasperSample.createDesign();

        /*Create jrxml file if you need to see file in iReport or jasper studio.*/
//        jasperReport = JasperCompileManager.compileReport(design);
//        DynamicJasperHelper.generateJRXML(jasperReport, "UTF-8", "report/samplejrxml.jrxml");

        List<Person> personList = new ArrayList<Person>();
        for (int i = 1; i <= 10; i++) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("firstName", "Vivek " + i);
            map.put("lastName", "Yadav " + i);
            map.put("age", 20);
            Person person = new Person(map);
            personList.add(person);
        }
        jasperReport = JasperCompileManager.compileReport(design);
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, new HashMap<String, Object>(), new JRBeanCollectionDataSource(personList));
        JasperExportManager.exportReportToPdfFile(jasperPrint, "report/sample.pdf");

    }

    public JasperDesign createDesign() throws JRException {
        JasperDesign jasperDesign = new JasperDesign();
/*Set basic design of page.*/
        jasperDesign.setName("sampleDynamicJasperDesign");
        jasperDesign.setPageWidth(595); // page width
        jasperDesign.setPageHeight(842); // page height
        jasperDesign.setColumnWidth(515);   // column width of page
        jasperDesign.setColumnSpacing(0);
        jasperDesign.setLeftMargin(40);
        jasperDesign.setRightMargin(40);
        jasperDesign.setTopMargin(20);
        jasperDesign.setBottomMargin(20);

        JRDesignExpression expression = new JRDesignExpression();

        //Set style of page.
        JRDesignStyle normalStyle = new JRDesignStyle();
        normalStyle.setName("Sans_Normal");
        normalStyle.setDefault(true);
        normalStyle.setFontName("DejaVu Sans");
        normalStyle.setFontSize(12);
        normalStyle.setPdfFontName("Helvetica");
        normalStyle.setPdfEncoding("Cp1252");
        normalStyle.setPdfEmbedded(false);
        jasperDesign.addStyle(normalStyle);


        /*
        * Generate field dynamically
        * */

        JRDesignField field = new JRDesignField();
        field.setName("firstName");
        field.setValueClass(String.class);
        jasperDesign.addField(field);

        field = new JRDesignField();
        field.setName("lastName");  // set name for field.
        field.setValueClass(String.class);  // set class for field. Its always depends upon data type which we want to get in this field.
        jasperDesign.addField(field);   // Added field in design.

        field = new JRDesignField();
        field.setName("age");
        field.setValueClass(Integer.class);
        jasperDesign.addField(field);

        JRDesignBand band = new JRDesignBand();

        //Title Band
        band = new JRDesignBand();
        band.setHeight(30);


        JRDesignStaticText staticText = new JRDesignStaticText();
        staticText.setText("Person's Specification");
        staticText.setX(0);
        staticText.setY(0);
        staticText.setHeight(20);
        staticText.setWidth(515);
        staticText.setHorizontalAlignment(HorizontalAlignEnum.CENTER);
        band.addElement(staticText);
        jasperDesign.setTitle(band);


//        Detail Band
        band = new JRDesignBand(); // New band
        band.setHeight(20); // Set band height

        /*Create text field dynamically*/
        JRDesignTextField textField = new JRDesignTextField();
        textField.setX(0);  // x position of text field.
        textField.setY(0);  // y position of text field.
        textField.setWidth(160);    // set width of text field.
        textField.setHeight(20);    // set height of text field.
        JRDesignExpression jrExpression = new JRDesignExpression(); // new instanse of expression. We need create new instance always when need to set expression.
        jrExpression.setText("\"" + "First Name: " + "\"" + "+" + "$F{firstName}"); //  Added String before field in expression.
        textField.setExpression(jrExpression);  // set expression value in textfield.
        band.addElement(textField); // Added element in textfield.

        textField = new JRDesignTextField();
        textField.setX(160);
        textField.setY(0);
        textField.setWidth(160);
        textField.setHeight(20);
        jrExpression = new JRDesignExpression();
        jrExpression.setText("$F{lastName}" + "+" + "\"" + " :Last Name" + "\""); // Added string after field value
        textField.setExpression(jrExpression);
        band.addElement(textField);

        textField = new JRDesignTextField();
        textField.setX(320);
        textField.setY(0);
        textField.setWidth(160);
        textField.setHeight(20);
        jrExpression = new JRDesignExpression();
        String age = "\"" + "<html><font color=" + "\\" + "\"" + "#66FF33" + "\\" + "\"" + ">" + "\"" + "+" + "\"" + "Age is: " + "\"" + "+" + "\"" + "</font><font color=" + "\\" + "\"" + "#6600FF" + "\\" + "\"" + ">" + "\"" + "+" + "$F{age}" + "+" + "\"" + "</font></html>" + "\"";  // added html in text field with different color.
        jrExpression.setText(age);
        textField.setExpression(jrExpression);
        textField.setMarkup("html"); // By Default markup is none, We need to set it as html if we set expression as html.
        band.addElement(textField);
        ((JRDesignSection) jasperDesign.getDetailSection()).addBand(band);


        return jasperDesign;
    }
}