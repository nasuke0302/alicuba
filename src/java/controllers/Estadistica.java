/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.List;

/**
 *
 * @author Feisy
 */
public class Estadistica {
    
    private List<Float> v;
    private double minimo;
    private double maximo;
         
    
    public Estadistica(List<Float> valores){
        this.v = valores;
        determinar_minANDmax();
    }
    
    private void determinar_minANDmax(){
        minimo = maximo = v.get(0);
        
        for(int i = 1; i < v.size(); i++){
            if (v.get(i) < minimo) {
                minimo = v.get(i);
            }
            if (v.get(i) > maximo) {
                maximo = v.get(i);
            }
        }
    }
    
    public double minimo(){
        return minimo;
    }
    public double maximo(){
        return maximo;
    }
    
    /*
    *Calcula de los valores que contenga un vector de doubles facilitado por el usuario
    *@param v		vector de doubles con los elemento introducidos por el usuario
    *@return 		la media de los valores de v
    *@see #media()
    */
    public double media(){
        double suma=0;
        for(int i=0; i<v.size(); i++){
            suma+=v.get(i);
        }
        return suma/v.size();
    }
    /*
    *Calcula la moda, el valor más repetido, del vector de doubles v introducido por el usuario
    *@param v		vector de doubles con los elemento introducidos por el usuario
    *@return 		valor más repetido del vector
    *@see #moda()
    */
    public double moda(){
        int cont=0;
        double num=0;
        for(int i=0; i<v.size(); i++){
            int aux=0;	
            for(int j=0; j<v.size(); j++){
               if(v.get(i)==v.get(j)) aux++;
            }
            if(aux>=cont){
                cont=aux;
                num=v.get(i);
            } 
        }
        return num;
    }
    /*
    *Calcula la desviacion tipica del vector de doubles v introducido por el usuario
    *@param v		vector de doubles con los elemento introducidos por el usuario
    *@return 		desviacion tipica del vector
    *@see #desviacion_tipica()
    */
    public double desviacion_tipica(){
        double res=Math.sqrt(varianza());
        return res;
    }
    /*
    *Calcula la varianza del vector de doubles v introducido por el usuario
    *@param v vector de doubles con los elemento introducidos por el usuario
    *@return 		la varianza del vector
    *@see #varianza()
    */
    public double varianza(){
        double m=media();
        double sum=0;
        for(int i=0; i<v.size(); i++){
            sum+=Math.pow(v.get(i),2.0);
        }
        return sum/v.size()-Math.pow(m,2.0);	
    }
}
