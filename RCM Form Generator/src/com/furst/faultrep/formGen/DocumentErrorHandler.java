/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.furst.faultrep.formGen;

import java.io.PrintStream;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 *
 * @author c79460
 */
public class DocumentErrorHandler implements ErrorHandler
{
    private final static PrintStream OUTSTREAM = System.err;
    
    private void log(String type, SAXParseException e)
    {
        OUTSTREAM.println("SAX PARSE EXECEPTION " + type);
        OUTSTREAM.println("PUBLIC ID: " + e.getPublicId());
        OUTSTREAM.println("SYSTEM ID: " + e.getSystemId());
        OUTSTREAM.println("LINE: " + e.getLineNumber());
        OUTSTREAM.println("COLUMN: " + e.getColumnNumber());
        OUTSTREAM.println("MESSAGE: " + e.getMessage());
    }
    
    @Override
    public void error(SAXParseException e) throws SAXException
    {
        log("ERROR ", e);
    }
    
    @Override
    public void fatalError(SAXParseException e) throws SAXException
    {
        log("FATAL ERROR ", e);
    }
    
    @Override
    public void warning(SAXParseException e) throws SAXException
    {
        log("WARNING ", e);
    }
}
