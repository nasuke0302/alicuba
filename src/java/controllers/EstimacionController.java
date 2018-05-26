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
import models.Variables;
import org.nfunk.jep.JEP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
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
    Map<String, ? extends Object> parseExp(@RequestBody Formulas formula) {
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
}
