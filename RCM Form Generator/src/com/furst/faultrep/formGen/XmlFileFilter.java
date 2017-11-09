/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.furst.faultrep.formGen;

import java.io.File;
import java.io.FileFilter;

/**
 *
 * @author tfurst
 */
public class XmlFileFilter implements FileFilter
{
    public final String[] exts = new String[]{"xml"};
    @Override
    public boolean accept(File file) {
        for(String ext : exts)
        {
            if(file.getName().toLowerCase().endsWith(ext))
            {
                return true;
            }
        }
        return false;
    }
    
}
