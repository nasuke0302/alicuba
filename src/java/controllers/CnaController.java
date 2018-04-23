/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import models.Referencias;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.MetadatosAlimentosRepo;
import repositorios.ReferenciasRepo;
import repositorios.TablaCnaGeneralRepo;

/**
 *
 * @author albert
 */
@Controller
public class CnaController {

    @Autowired
    ReferenciasRepo referenciasRepo;

    @Autowired
    MetadatosAlimentosRepo metadatosAlimentosRepo;

    @Autowired
    TablaCnaGeneralRepo tablaCnaGeneralRepo;

    
    @RequestMapping(value = "/cna/gestionar")
    public ModelAndView showCna() {
        return new ModelAndView("cna");
    }

    @RequestMapping(value = "/cna/getLastReferencia")
    public @ResponseBody
    Map<String, ? extends Object> getLastReferencia() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", referenciasRepo.findTopByOrderByIdReferenciaDesc());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/cna/getEstudioPorReferencia/{idReferencia}")
    public ModelAndView getEstudioPorReferencia(@PathVariable Integer idReferencia, ModelMap map) {
        Referencias r = referenciasRepo.findOne(idReferencia);
        map.put("data", metadatosAlimentosRepo.findEstudioByReferencia(r));
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @RequestMapping(value = "/cna/getAllEstudios")
    public @ResponseBody
    Map<String, ? extends Object> getAllEstudios() {
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
