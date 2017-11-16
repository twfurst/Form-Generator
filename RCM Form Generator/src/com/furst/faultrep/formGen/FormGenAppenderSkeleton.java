/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.furst.faultrep.formGen;

import java.awt.Color;
import javax.swing.JTextArea;
import org.apache.log4j.AppenderSkeleton;
import org.apache.log4j.Level;
import org.apache.log4j.spi.LoggingEvent;

/**
 *
 * @author tfurst
 */
public class FormGenAppenderSkeleton extends AppenderSkeleton{
    private JTextArea area;
    public FormGenAppenderSkeleton(JTextArea jta)
    {
        this.area = jta;
    }
    @Override
    protected void append(LoggingEvent le) {
//        if(le.getLevel().equals(Level.INFO))
//        {
//            area.append("[INFO] " + le.getMessage().toString());
//        }
        switch(le.getLevel().toInt())
        {
            case Level.INFO_INT:
                area.append("[INFO] " + le.getMessage().toString() + "\n");
                area.setCaretPosition(area.getText().length());
                break;
            case Level.WARN_INT:
                area.setForeground(Color.ORANGE);
                area.append("[WARN] " + le.getMessage().toString() + "\n");
                area.setForeground(new Color(51,204,255));
                area.setCaretPosition(area.getText().length());
                break;
            case Level.ERROR_INT:
                area.setForeground(Color.RED);
                area.append("[ERROR] " + le.getMessage().toString() + "\n");
                area.setForeground(new Color(51,204,255));
                area.setCaretPosition(area.getText().length());
                break;
//            default:
//                area.append(le.getMessage().toString() + "\n");
        }
    }

    @Override
    public void close() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean requiresLayout() {
        return false;
    }
    
}
