/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import repositorios.MetadatosAlimentosRepo;
import repositorios.ReferenciasRepo;

/**
 *
 * @author Tesis
 */
@Controller
public class EstimacionController {
    
    @Autowired
    ReferenciasRepo referenciasRepo;
    
    @Autowired
    MetadatosAlimentosRepo metadatosAlimentosRepo;
    
    @RequestMapping(value = "/estimacion/gestionar")
    public ModelAndView showEstimacion() {
        return new ModelAndView("estimacionValores");
    }
    
    @RequestMapping(value = "/estimacion/getAllReferencias")
    public @ResponseBody
    Map<String, ? extends Object> getAllReferencias() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", referenciasRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }
    
    @RequestMapping(value = "/estimacion/getAllMetadatos")
    public @ResponseBody
    Map<String, ? extends Object> getAllMetadatos() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", metadatosAlimentosRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }
}
