/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.furst.faultrep.menus;

import java.awt.event.ActionListener;
import org.pushingpixels.flamingo.api.common.JCommandButton.CommandButtonKind;
import org.pushingpixels.flamingo.api.common.icon.ResizableIcon;
import org.pushingpixels.flamingo.api.ribbon.RibbonApplicationMenuEntryPrimary;

/**
 *
 * @author tfurst
 */
public class AppMenuPrimaryEntry extends RibbonApplicationMenuEntryPrimary
{
    public AppMenuPrimaryEntry(ResizableIcon icon, String text, ActionListener mainActionListener, CommandButtonKind entryKind)
    {
        super(icon, text, mainActionListener, entryKind);
    }
    
    
}
