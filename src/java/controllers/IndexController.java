/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import models.Referencias;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.AutoresRepo;
import repositorios.CategoriaRepo;
import repositorios.FuenteInfRepo;
import repositorios.ReferenciasRepo;

@Controller
public class IndexController {

    @Autowired
    ReferenciasRepo referenciasRepo;

    @Autowired
    AutoresRepo autoresRepo;

    @Autowired
    FuenteInfRepo fuenteInfRepo;

    @Autowired
    CategoriaRepo categoriasRepo;

    @RequestMapping(value = {"/", "/index"})
    public ModelAndView showIndex() {
        return new ModelAndView("index");
    }

    @RequestMapping(value = {"/index/createOrEditReferencia"})
    public String showCreateOrEditReferencia() {
        return "createOrEditReferencia";
    }

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/index/getReferencias")
    public @ResponseBody
    Map<String, ? extends Object> getReferencias() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", referenciasRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/index/getFuentes")
    public @ResponseBody
    Map<String, ? extends Object> getFuentes() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", fuenteInfRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Secured(value = "Colaborador")
    @ResponseBody
    @RequestMapping(value = "/index/addReferencia")
    public ModelAndView addReferencia(@RequestBody Referencias r, ModelMap map) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        r.setIdUsuario((Usuarios) principal);
        referenciasRepo.saveAndFlush(r);
        map.put("mensaje", "Referencia registrada correctamente");
        map.put("data", r);
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/index/editReferencia")
    public ModelAndView editReferencia(@RequestBody Referencias r, ModelMap map) {
        Referencias r1 = referenciasRepo.findOne(r.getIdReferencia());
        r1.setAutoresList(r.getAutoresList());
        r1.setArcPublication(r.getArcPublication());
        r1.setCategoriaList(r.getCategoriaList());
        r1.setEdition(r.getEdition());
        r1.setEditorial(r.getEditorial());
        r1.setFecha(r.getFecha());
        r1.setFechaMod(r.getFechaMod());
        r1.setIdFuente(r.getIdFuente());
        r1.setInformeInstitution(r.getInformeInstitution());
        r1.setInformeNum(r.getInformeNum());
        r1.setInformeSerie(r.getInformeSerie());
        r1.setInformeTipo(r.getInformeTipo());
        r1.setLugar(r.getLugar());
        r1.setMetadatosAlimentosGList(r.getMetadatosAlimentosGList());
        r1.setNota(r.getNota());
        r1.setNumVol(r.getNumVol());
        r1.setPages(r.getPages());
        r1.setSecclTitle(r.getSecclTitle());
        r1.setTesisUniversidad(r.getTesisUniversidad());
        r1.setTitle(r.getTitle());
        r1.setUrl(r.getUrl());
        r1.setVolumen(r.getVolumen());
        referenciasRepo.saveAndFlush(r1);
        map.put("mensaje", "Referencia editada correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Colaborador")
    @RequestMapping(value = "/index/delete/{idReferencia}", method = RequestMethod.POST)
    public ModelAndView deleteReferencia(@PathVariable Integer idReferencia, ModelMap map) {
        try {
            referenciasRepo.delete(idReferencia);
            map.put("mensaje", "Referencia eliminada correctamente");
        } catch (Exception e) {
            map.put("Error", e);
            map.put("mensaje", "Error al eliminar la referencia");
        }
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

}
