/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.furst.faultrep.menus;

import java.awt.GridLayout;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.swing.JCheckBox;
import javax.swing.JComponent;
import net.sourceforge.jdatepicker.impl.JDatePanelImpl;
import net.sourceforge.jdatepicker.impl.JDatePickerImpl;
import net.sourceforge.jdatepicker.impl.UtilDateModel;


/**
 *
 * @author tfurst
 */
public class DatePickerPanel extends javax.swing.JPanel{
    private UtilDateModel mod = new UtilDateModel();
    private JDatePanelImpl dp; 
    private JDatePickerImpl jdp;
    private GridLayout layout = new GridLayout(0,1);
    private boolean chooseToday = true;
    private final String pattern = "MM/dd/yyyy";
    private SimpleDateFormat sdf = new SimpleDateFormat(pattern);
    
    public DatePickerPanel()
    {
        setLayout();
        mod.setSelected(chooseToday);
        dp = new JDatePanelImpl(mod);
        jdp = new JDatePickerImpl(dp);
        this.add(jdp);
    }
    
    private void setLayout()
    {
        this.setLayout(layout);
    }
    
    public String getDate()
    {
        Date date = (Date)jdp.getModel().getValue();
        return sdf.format(date);
    }
    
    public void setDate(int yr, int month, int day)
    {
        UtilDateModel model = (UtilDateModel)jdp.getModel();
        model.setDate(yr, month, day);
        model.setSelected(true);
    }
}
