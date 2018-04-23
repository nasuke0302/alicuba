/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import models.Alimentos;
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
import repositorios.AlimentosRepo;
import repositorios.TipoCubaRepo;
import repositorios.TipoFaoRepo;
import repositorios.TipoNrcRepo;

/**
 *
 * @author albert
 */
@Controller
public class AlimentosController {

    @Autowired
    AlimentosRepo alimentosRepo;
    @Autowired
    TipoCubaRepo tipoCubaRepo;
    @Autowired
    TipoFaoRepo tipoFaoRepo;
    @Autowired
    TipoNrcRepo tipoNrcRepo;

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/alimentos/gestionar")
    public ModelAndView showGestionarAlimentos() {
        return new ModelAndView("gestionarAlimentos");
    }

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/alimentos/get")
    public @ResponseBody
    Map<String, ? extends Object> getAlimentos() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", alimentosRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/alimentos/getAllTipoCuba")
    public @ResponseBody
    Map<String, ? extends Object> getAllTipoCuba() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", tipoCubaRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/alimentos/getAllTipoFao")
    public @ResponseBody
    Map<String, ? extends Object> getAllTipoFao() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", tipoFaoRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Secured(value = "Colaborador, Editor")
    @RequestMapping(value = "/alimentos/getAllTipoNrc")
    public @ResponseBody
    Map<String, ? extends Object> getallTipoNrc() {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", tipoNrcRepo.findAll());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @Secured(value = "Colaborador")
    @ResponseBody
    @RequestMapping(value = "/alimentos/add")
    public ModelAndView addAlimento(@RequestBody Alimentos r, ModelMap map) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        r.setIdUsuario((Usuarios) principal);
        alimentosRepo.saveAndFlush(r);
        map.put("mensaje", "Alimento insertado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Colaborador, Editor")
    @ResponseBody
    @RequestMapping(value = "/alimentos/edit")
    public ModelAndView editAlimentos(@RequestBody Alimentos r, ModelMap map) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Alimentos r1 = alimentosRepo.findOne(r.getIdAlimento());
        r1.setIdTipoCuba(r.getIdTipoCuba());
        r1.setIdTipoFao(r.getIdTipoFao());
        r1.setIdTipoNrc(r.getIdTipoNrc());
        r1.setNombre(r.getNombre());
        r1.setNombreCient(r.getNombreCient());
        r1.setParte(r.getParte());
        r1.setProceso(r.getProceso());
        r1.setMezcla(r.getMezcla());
        r1.setVariedad(r.getVariedad());
        r1.setIdUsuario((Usuarios) principal);
        alimentosRepo.saveAndFlush(r1);
        map.put("mensaje", "Alimento editado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Colaborador")
    @RequestMapping(value = "/alimentos/delete/{id}", method = RequestMethod.DELETE)
    public ModelAndView deleteAlimento(@PathVariable Integer id, ModelMap map) {
        alimentosRepo.delete(id);
        map.put("mensaje", "Alimento eliminado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
