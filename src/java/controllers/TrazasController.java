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
import repositorios.TrazaRepo;

/**
 *
 * @author albert
 */
@Controller
public class TrazasController {

    @Autowired
    TrazaRepo trazaRepo;

    @RequestMapping(value = "/trazas/gestionar")
    public ModelAndView showGestionarTrazas() {
        return new ModelAndView("gestionarTrazas");
    }
    
    @RequestMapping(value = "/trazas/getTrazas")
    public @ResponseBody
    Map<String, ? extends Object> getTrazas() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", trazaRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
            map.put("error", e);
        }
        return map;
    }
}
