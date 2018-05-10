/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import models.Alimentos;
import models.Roles;
import models.Usuarios;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
    Map<String, ? extends Object> getAlimentos(@AuthenticationPrincipal Usuarios principal) {
        Map<String, Object> map = new HashMap<>();
        try {
            if ("Colaborador".equals(principal.getIdRol().toString())) {
                map.put("data", alimentosRepo.findAllByIdUsuario(principal));
            } else {
                map.put("data", alimentosRepo.findAll());
            }
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
            map.put("error", e);
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
    public ModelAndView addAlimento(@RequestBody Alimentos r, ModelMap map, @AuthenticationPrincipal Usuarios principal) {
        r.setIdUsuario(principal);
        alimentosRepo.saveAndFlush(r);
        map.put("mensaje", "Alimento insertado correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }

    @Secured(value = "Colaborador, Editor")
    @ResponseBody
    @RequestMapping(value = "/alimentos/edit")
    public ModelAndView editAlimentos(@RequestBody Alimentos r, ModelMap map) {
        Alimentos r1 = alimentosRepo.findOne(r.getIdAlimento());
        r1 = r;
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
