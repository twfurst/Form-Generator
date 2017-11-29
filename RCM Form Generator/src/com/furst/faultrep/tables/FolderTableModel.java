/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.furst.faultrep.tables;

import com.furst.faultrep.formGen.DataModuleObject;
import java.util.ArrayList;
import java.util.List;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author tfurst
 */
public class FolderTableModel extends AbstractTableModel{
    private String[] colNames = {"Data Module Code","Boiler Plate Exists","PDF Exists"};
    private List<DataModuleObject> dmods;
    
    public FolderTableModel(List<DataModuleObject> modules)
    {
        this.dmods = modules;
    }
    
    @Override
    public int getRowCount() {
        return dmods.size();
    }

    @Override
    public String getColumnName(int col)
    {
        return colNames[col];
    }
    
    @Override
    public int getColumnCount() {
        return colNames.length;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        Object value = "??";
        DataModuleObject dm = dmods.get(rowIndex);
        
        switch(columnIndex)
        {
            case 0:
                value = dm.getBaseDmc();
                break;
            case 1:
                value = dm.isHasBoiler();
                break;
            case 2:
                value = dm.isHasPdf();
                break;
        }
        
        return value;
    }
    
//    @Override
//    public void setValueAt(Object o, int row, int col)
//    {
//        DataModuleObject dmo = (DataModuleObject)o;
//        switch(col)
//        {
//            case 0:
//                dmo.getBaseDmc();
//                break;
//            case 1:
//                dmo.isHasBoiler();
//                break;
//            case 2:
//                dmo.isHasPdf();
//                break;
//        }
//    }
    
    @Override
    public Class getColumnClass(int col)
    {
        return getValueAt(0,col).getClass();
    }
    
    public List<DataModuleObject> getAllMods()
    {
        return dmods;
    }
    
    public DataModuleObject getDmod(int row)
    {
        return dmods.get(row);
    }
    
    public void removeRow(int row)
    {
        fireTableRowsDeleted(row,row);
        dmods.remove(row);
    }
}
