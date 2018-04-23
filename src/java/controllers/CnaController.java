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
import repositorios.ReferenciasRepo;

/**
 *
 * @author albert
 */
@Controller
public class CnaController {

    @Autowired
    ReferenciasRepo referenciasRepo;
    
    @RequestMapping(value = "/cna/gestionar")
    public ModelAndView showCna() {
        return new ModelAndView("cna");
    }
    
    @RequestMapping(value = "/cna/getLastReferencia")
   public @ResponseBody Map<String, ? extends Object> getLastReferencia() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", referenciasRepo.findTopByOrderByIdReferenciaDesc());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

}
