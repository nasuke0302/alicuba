/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Formulas;
import models.Usuarios;
import models.Variables;
import org.nfunk.jep.JEP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.FormulasRepo;
import repositorios.MetadatosAlimentosRepo;
import repositorios.ReferenciasRepo;
import repositorios.VariablesRepo;

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

    @Autowired
    FormulasRepo formulasRepo;

    @Autowired
    VariablesRepo variablesRepo;

    JEP parser = new JEP();

    @RequestMapping(value = "/estimacion/gestionar")
    public ModelAndView showEstimacion() {
        return new ModelAndView("estimacionValores");
    }

    @RequestMapping(value = "/estimacion/getFormulas")
    public @ResponseBody
    Map<String, ? extends Object> getFormulas() {
        Map<String, Object> map = new HashMap<>();
        List<Formulas> allFormulas = formulasRepo.findAll();
        try {
            map.put("data", allFormulas);
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }

    @RequestMapping(value = "/estimacion/parseExp")
    public @ResponseBody
    Map<String, ? extends Object> parseExp(@RequestBody Formulas formula, @AuthenticationPrincipal Usuarios principal) {
        Map<String, Object> map = new HashMap<>();
        parser.setImplicitMul(true);
        parser.setAllowUndeclared(true);

        Formulas f1 = formula;
        parser.parseExpression(f1.getFormula());
        if (parser.hasError()) {
            map.put("mensaje", parser.getErrorInfo());
            map.put("success", Boolean.FALSE);
            return map;
        } else {
            formula.setIdUsuario(principal);
            formulasRepo.saveAndFlush(f1);
            map.put("mensaje", "Expresion correcta");
            map.put("success", Boolean.TRUE);
        }
        return map;
    }

    @RequestMapping(value = "/estimacion/addVariables")
    public @ResponseBody
    Map<String, ? extends Object> addVariables(@RequestBody List<Variables> variablesList) {
        Map<String, Object> map = new HashMap<>();
        map.put("data", variablesRepo.save(variablesList));
        return map;
    }

    @Secured(value = "Colaborador")
    @RequestMapping(value = "/estimacion/deleteFormulas/{id}", method = RequestMethod.DELETE)
    public ModelAndView deleteFormula(@PathVariable Integer id, ModelMap map) {
        Formulas formulaEliminar = formulasRepo.findOne(id);
        variablesRepo.delete(formulaEliminar.getVariablesList());
        formulasRepo.delete(id);
        map.put("mensaje", "Fórmula eliminada correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
