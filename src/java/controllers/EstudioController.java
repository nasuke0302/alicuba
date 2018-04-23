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
import repositorios.CalidadRepo;
import repositorios.EpocasRepo;
import repositorios.FertilizadoRepo;
import repositorios.MesesRepo;
import repositorios.MetadatosAlimentosRepo;
import repositorios.NivelFertRepo;
import repositorios.PaisesRepo;
import repositorios.ProvinciaRepo;
import repositorios.RangoEdadesRepo;

/**
 *
 * @author Tesis
 */
@Controller
public class EstudioController {

    @Autowired
    MetadatosAlimentosRepo metadatosAlimentosRepo;

    @Autowired
    CalidadRepo calidadRepo;

    @Autowired
    EpocasRepo epocasRepo;

    @Autowired
    FertilizadoRepo fertilizadoRepo;

    @Autowired
    MesesRepo mesesRepo;

    @Autowired
    NivelFertRepo nivelFertRepo;

    @Autowired
    PaisesRepo paisesRepo;

    @Autowired
    ProvinciaRepo provinciaRepo;
    
    @Autowired
    RangoEdadesRepo rangoEdadesRepo;

    @RequestMapping(value = "/estudio/gestionar")
    public ModelAndView showEstudio() {
        return new ModelAndView("estudio");
    }

    @RequestMapping(value = "/estudio/getMetadatos")
    public @ResponseBody
    Map<String, ? extends Object> getMetadatos() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", metadatosAlimentosRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getCalidades")
    public @ResponseBody
    Map<String, ? extends Object> getCalidades() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", calidadRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getEpocas")
    public @ResponseBody
    Map<String, ? extends Object> getEpocas() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", epocasRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getFertilizado")
    public @ResponseBody
    Map<String, ? extends Object> getFertilizado() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", fertilizadoRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getMeses")
    public @ResponseBody
    Map<String, ? extends Object> getMeses() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", mesesRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getNivelFert")
    public @ResponseBody
    Map<String, ? extends Object> getNivelFert() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", nivelFertRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getPaises")
    public @ResponseBody
    Map<String, ? extends Object> getPaises() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", paisesRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estudio/getProvincias")
    public @ResponseBody
    Map<String, ? extends Object> getProvincias() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", provinciaRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }
    
    @RequestMapping(value = "/estudio/getRangoEdades")
    public @ResponseBody
    Map<String, ? extends Object> getRangoEdades() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", rangoEdadesRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }
}
