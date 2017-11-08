/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.furst.faultrep.formGen;

/**
 *
 * @author tfurst
 */
public class DataModuleObject {
    private String baseDmc;
    private boolean hasBoiler;
    private boolean hasPdf;
    
    public DataModuleObject(String dmc, boolean bp, boolean pdf)
    {
        this.baseDmc = dmc;
        this.hasBoiler = bp;
        this.hasPdf = pdf;
    }

    /**
     * @return the baseDmc
     */
    public String getBaseDmc() {
        return baseDmc;
    }

    /**
     * @return the hasBoiler
     */
    public boolean isHasBoiler() {
        return hasBoiler;
    }

    /**
     * @param hasBoiler the hasBoiler to set
     */
    public void setHasBoiler(boolean hasBoiler) {
        this.hasBoiler = hasBoiler;
    }

    /**
     * @return the hasPdf
     */
    public boolean isHasPdf() {
        return hasPdf;
    }

    /**
     * @param hasPdf the hasPdf to set
     */
    public void setHasPdf(boolean hasPdf) {
        this.hasPdf = hasPdf;
    }
}
