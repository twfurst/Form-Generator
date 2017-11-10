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
public class ATRReviewer {
    
    private String name;
    
    public ATRReviewer(String name)
    {
        this.name = name;
    }
    
    public String getName()
    {
        return this.name;
    }
    
    @Override
    public String toString()
    {
        return this.name;
    }
}
