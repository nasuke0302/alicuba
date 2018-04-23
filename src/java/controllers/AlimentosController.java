/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.Map;
import models.Alimentos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
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

    @RequestMapping(value = "/alimentos/gestionar")
    public ModelAndView showGestionarAlimentos() {
        return new ModelAndView("gestionarAlimentos");
    }

    @RequestMapping(value = "/alimentos/get")
    public @ResponseBody
    Map<String, ? extends Object> getAlimentos(Pageable pageable) {
        Map<String, Object> map = new HashMap<>();
        try {
            map.put("data", alimentosRepo.findAll(pageable).getContent());
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

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

    @ResponseBody
    @RequestMapping(value = "/alimentos/add")
    public ModelAndView addRoles(@RequestBody Alimentos r) {
        alimentosRepo.saveAndFlush(r);
        return showGestionarAlimentos();
    }

    @ResponseBody
    @RequestMapping(value = "/alimentos/edit")
    public ModelAndView editAlimentos(@RequestBody Alimentos r) {
        Alimentos r1 = alimentosRepo.findOne(r.getIdAlimento());
        r1.setIdTipoCuba(r.getIdTipoCuba());
        r1.setIdTipoFao(r.getIdTipoFao());
        r1.setIdTipoNrc(r.getIdTipoNrc());
        r1.setIdUsuario(r.getIdUsuario());
        r1.setNombre(r.getNombre());
        r1.setNombreCient(r.getNombreCient());
        r1.setParte(r.getParte());
        r1.setVariedad(r.getVariedad());
        alimentosRepo.saveAndFlush(r1);
        return showGestionarAlimentos();
    }

    @ResponseBody
    @RequestMapping(value = "/alimentos/delete")
    public ModelAndView deleteAlimento(@RequestBody Alimentos r) {
        alimentosRepo.delete(r);
        return showGestionarAlimentos();
    }
}
