/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import models.ListadoTablaGeneradas;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import repositorios.AlimentosRepo;
import repositorios.ListadoTablaGeneradasRepo;
import models.Alimentos;
import models.MetadatosAlimentosG;
import models.MetadatosAlimentosTabla;
import models.Region;
import repositorios.MetadatosAlimentosRepo;
import repositorios.MetadatosAlimentosTablaRepo;
import repositorios.RegionRepo;
import services.Trazable;

/**
 *
 * @author Feisy
 */
@Controller
public class GenerarTablaController {
    
    @Autowired
    ListadoTablaGeneradasRepo listadoTablaGeneradasRepo;
    
    @Autowired
    AlimentosRepo alimentosRepo;
    
    @Autowired
    RegionRepo regionRepo;
    
    @Autowired
    MetadatosAlimentosRepo metadatosAlimentosRepo;
    
    @Autowired
    MetadatosAlimentosTablaRepo metadatosAlimentosTablaRepo;
    
    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
    
    @Trazable(accion = "listar", listar = true, nombre = "listarTablasGeneradas", timeLine = "", claseEntidad = "TablasGeneradas")
    @RequestMapping(value = "/tablasgeneradas/gestionar")
    public ModelAndView showGestionarAlimentos() {
        return new ModelAndView("gestionarTablasGeneradas");
    }
    
    @RequestMapping(value = "/categorias/getTablasGeneradas")
    public @ResponseBody
    Map<String, ? extends Object> getTablasGeneradas( ) {
        Map<String, Object> map = new HashMap<>();
        try {
            //map.put("data", ListadoTablaGeneradasRepo.findAllOrderByIdListadoTablaGeneradasDesc());
            map.put("data", listadoTablaGeneradasRepo.findAll());
            map.put("success", Boolean.TRUE);
            
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
        }
        return map;
    }
    
    
    @RequestMapping(value = "/categorias/generarTabla")
    @ResponseBody
    public ModelAndView generarTabla(@RequestBody ListadoTablaGeneradas lis, ModelMap map){
        
        //listadoTablaGeneradasRepo.saveAndFlush(lis);
        
        ListadoTablaGeneradas TablaCreada = listadoTablaGeneradasRepo.saveAndFlush(lis);
        //Integer IdListadoTablaGenerada = TablaCreada.getIdListadoTablaGeneradas();
        
        List<Alimentos> lista_alimentos = alimentosRepo.findAll();//seleccionar todos los alimentos                        
        /*List list_tmp = new LinkedList(lista_alimentos);//LinkedList es para poder recorrer la lista        
        Iterator caso = list_tmp.iterator();
        while (caso.hasNext()) {//Evaluar por alimentos
            Alimentos alimento_actual = (Alimentos) caso.next();            
            String id_alimento = alimento_actual.getIdAlimento().toString();
        }/**/
        
        List<Region> ListadoRegiones = regionRepo.findAll();
        
        for(int i = 0; i < lista_alimentos.size(); i++){
            int id_alimento = lista_alimentos.get(i).getIdAlimento();
            
           for(int reg = 0; reg < ListadoRegiones.size(); reg++){
               int id_region = ListadoRegiones.get(reg).getIdRegion();
               
               List<MetadatosAlimentosG> chequeo_metadatos = metadatosAlimentosRepo.metadatosAlimentosDeLaRegion(id_alimento, id_region);
               
               if(chequeo_metadatos.size() == 1){
                   //Agregar este metadatos en la tabla metadatos_alimentos_tabla
                   MetadatosAlimentosTabla metadato_actual = null;
                   metadato_actual.setIdAlimento(chequeo_metadatos.get(0).getIdAlimento());
                   metadato_actual.setIdRegion(chequeo_metadatos.get(0).getIdRegion());
                   metadato_actual.setIdEpoca(chequeo_metadatos.get(0).getIdEpoca());
                   metadato_actual.setIdNivelFert(chequeo_metadatos.get(0).getIdNivelFert());
                   metadato_actual.setIdRangoEdades(chequeo_metadatos.get(0).getIdRangoEdades());
                   metadato_actual.setRiego(chequeo_metadatos.get(0).getRiego());
                   metadato_actual.setN(chequeo_metadatos.get(0).getN());
                   metadato_actual.setNpk(chequeo_metadatos.get(0).getNpk());
                   metadato_actual.setEdad(chequeo_metadatos.get(0).getEdad());
                   metadato_actual.setCorte(chequeo_metadatos.get(0).getCorte());
                   metadato_actual.setTecnolog(chequeo_metadatos.get(0).getTecnolog());
                   metadato_actual.setTratamiento(chequeo_metadatos.get(0).getTratamiento());
                   metadato_actual.setPresentation(chequeo_metadatos.get(0).getPresentation());
                   metadato_actual.setCalidad(chequeo_metadatos.get(0).getCalidad());
                   metadato_actual.setImport1(chequeo_metadatos.get(0).getImport1());
                   metadato_actual.setFertilizado(chequeo_metadatos.get(0).getFertilizado());
                   metadato_actual.setIdListadoTablaGeneradas(TablaCreada);
                   
                  metadatosAlimentosTablaRepo.saveAndFlush(metadato_actual);
               }
               if(chequeo_metadatos.size() > 1){
                   //
               }
           } 
        }
        
        map.put("mensaje", "Tabla generada con nombre: "+lis.getNombre());
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
