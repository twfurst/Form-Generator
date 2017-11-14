/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.furst.faultrep.formGen;

import org.apache.fop.events.Event;
import org.apache.fop.events.EventFormatter;
import org.apache.fop.events.EventListener;
import org.apache.fop.events.model.EventSeverity;

/**
 *
 * @author tfurst
 */
public class SysOutEventListener implements EventListener
{
    @Override
    public void processEvent(Event event)
    {
        String message = EventFormatter.format(event);
        EventSeverity severity = event.getSeverity();
//        
//        if(severity == EventSeverity.INFO)
//        {
//            System.out.println("[INFO]:" + message);
//        }
//        else 
        if(severity == EventSeverity.WARN)
        {
            System.out.println("[WARNING]:" + message);
        }
        else if(severity == EventSeverity.ERROR)
        {
            System.err.println("[ERROR]:" + message);
        }
        else if(severity == EventSeverity.FATAL)
        {
            System.err.println("[FATAL]:" + message);
        }
        else
        {
            assert false;
        }
    }
}
