/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.AlimentoEvaluado;
import models.ListadoTablaGeneradas;
import org.springframework.beans.factory.annotation.Autowired;
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
import models.Nutrientes;
import models.Region;
import models.TablaCnaFinal;
import models.TablaCnaGeneral;
import models.TablaCnaGeneralPK;
import models.Usuarios;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMethod;
import repositorios.AlimentoEvaluadoRepo;
import repositorios.MetadatosAlimentosRepo;
import repositorios.MetadatosAlimentosTablaRepo;
import repositorios.NutrientesRepo;
import repositorios.RegionRepo;
import repositorios.TablaCnaFinalRepo;
import repositorios.TablaCnaGeneralRepo;
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
    
    @Autowired
    AlimentoEvaluadoRepo alimentoEvaluadoRepo;
    
    @Autowired
    NutrientesRepo nutrientesRepo;
    
    @Autowired
    TablaCnaGeneralRepo cnaGeneralRepo;
    
    @Autowired
    TablaCnaFinalRepo cnaFinalRepo;
        
    DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	
	private List<Nutrientes> ListaNutrientes;
    
    @PreAuthorize(value = "hasAuthority('Editor')")
    @RequestMapping(value = "/tablasgeneradas/gestionar")
    public ModelAndView showGestionarAlimentos() {
        return new ModelAndView("gestionarTablasGeneradas");
    }
    
    @PreAuthorize(value = "hasAuthority('Editor')")
    @RequestMapping(value = "/tablasgeneradas/getTablasGeneradas")
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
    }/**/
    
    /**
     *
     * @param lis
     * @param map
     * @param principal
     * @return 
     */
    @PreAuthorize(value = "hasAuthority('Editor')")//hasAnyAuthority('Colaborador', 'Editor')
    @RequestMapping(value = "/tablasgeneradas/generarTabla")
    @ResponseBody
    public ModelAndView generarTabla(@RequestBody ListadoTablaGeneradas lis, ModelMap map,
            @AuthenticationPrincipal Usuarios principal){
        
        //Obtener sólo los nutrientes que esten en uso
        /*
        SELECT Sum(tabla_cna_general.id_nutriente) AS SumaDeid_nutriente, tabla_cna_general.id_nutriente
        FROM tabla_cna_general
        GROUP BY tabla_cna_general.id_nutriente;
        */
        ListaNutrientes = nutrientesRepo.findAll();
        
        lis.setIdUsuario(principal);
        lis.setFechaHora(dateFormat.format(new Date()));
        //Aquí se obtiene el Id de la id_listado_tabla_generadas
        ListadoTablaGeneradas TablaCreada = listadoTablaGeneradasRepo.saveAndFlush(lis);
        
        List<Alimentos> lista_alimentos = alimentosRepo.findAll();//seleccionar todos los alimentos                        
                
        List<Region> ListadoRegiones = regionRepo.findAll();
        
        for(int i = 0; i < lista_alimentos.size(); i++){
            Alimentos id_alimento = lista_alimentos.get(i);
            
           for(int reg = 0; reg < ListadoRegiones.size(); reg++){
               Region id_region = ListadoRegiones.get(reg);
               
               List<MetadatosAlimentosG> chequeo_metadatos = metadatosAlimentosRepo.metadatosAlimentosDeLaRegion(id_alimento, id_region);
               
               if(chequeo_metadatos.size() == 1){
                   
                    //No hay que preguntar si el aliemnto esté evaluado pq existe un sólo alimento de este tipo
                   
                   //Agregar este metadatos en la tabla metadatos_alimentos_tabla
                   MetadatosAlimentosTabla metadato_actual = new MetadatosAlimentosTabla();
                   metadato_actual.setIdAlimento(chequeo_metadatos.get(0).getIdAlimento());
                   metadato_actual.setIdRegion(chequeo_metadatos.get(0).getIdRegion());
                   metadato_actual.setIdEpoca(chequeo_metadatos.get(0).getIdEpoca());
                   metadato_actual.setIdNivelFert(chequeo_metadatos.get(0).getIdNivelFert());
                   metadato_actual.setRiego(chequeo_metadatos.get(0).getRiego());
                   metadato_actual.setN(chequeo_metadatos.get(0).getN());
                   metadato_actual.setNpk(chequeo_metadatos.get(0).getNpk());
                   metadato_actual.setIdRangoEdades(chequeo_metadatos.get(0).getIdRangoEdades());
                   metadato_actual.setCorte(chequeo_metadatos.get(0).getCorte());
                   metadato_actual.setTecnolog(chequeo_metadatos.get(0).getTecnolog());
                   metadato_actual.setTratamiento(chequeo_metadatos.get(0).getTratamiento());
                   metadato_actual.setPresentation(chequeo_metadatos.get(0).getPresentation());
                   metadato_actual.setCalidad(chequeo_metadatos.get(0).getCalidad());
                   metadato_actual.setImport1(chequeo_metadatos.get(0).getImport1());
                   metadato_actual.setFertilizado(chequeo_metadatos.get(0).getFertilizado());
                   metadato_actual.setIdListadoTablaGeneradas(TablaCreada);
                   
                  MetadatosAlimentosTabla metadatoAgregado = metadatosAlimentosTablaRepo.saveAndFlush(metadato_actual);
                  
                  GenerarTablaCasoActual(chequeo_metadatos, metadatoAgregado);
                  
               }
               if(chequeo_metadatos.size() > 1){
                    
                    for(int met = 0; met < chequeo_metadatos.size(); met++){
                        //Preguntar si el alimento fue evaluado
                        List<AlimentoEvaluado> alimentoEval;
                        alimentoEval = alimentoEvaluadoRepo.MetadatosEvaluado(chequeo_metadatos.get(met).getIdMetadatosAlimentosG());
                        if(alimentoEval.isEmpty()){

                           //Agregar este metadatos en la tabla metadatos_alimentos_tabla
                           MetadatosAlimentosTabla metadato_actual = new MetadatosAlimentosTabla();
                           metadato_actual.setIdAlimento(chequeo_metadatos.get(met).getIdAlimento());
                           metadato_actual.setIdRegion(chequeo_metadatos.get(met).getIdRegion());
                           metadato_actual.setIdEpoca(chequeo_metadatos.get(met).getIdEpoca());
                           metadato_actual.setIdNivelFert(chequeo_metadatos.get(met).getIdNivelFert());
                           metadato_actual.setRiego(chequeo_metadatos.get(met).getRiego());
                           metadato_actual.setN(chequeo_metadatos.get(met).getN());
                           metadato_actual.setNpk(chequeo_metadatos.get(met).getNpk());
                           metadato_actual.setIdRangoEdades(chequeo_metadatos.get(met).getIdRangoEdades());
                           metadato_actual.setCorte(chequeo_metadatos.get(met).getCorte());
                           metadato_actual.setTecnolog(chequeo_metadatos.get(met).getTecnolog());
                           metadato_actual.setTratamiento(chequeo_metadatos.get(met).getTratamiento());
                           metadato_actual.setPresentation(chequeo_metadatos.get(met).getPresentation());
                           metadato_actual.setCalidad(chequeo_metadatos.get(met).getCalidad());
                           metadato_actual.setImport1(chequeo_metadatos.get(met).getImport1());
                           metadato_actual.setFertilizado(chequeo_metadatos.get(met).getFertilizado());
                           metadato_actual.setIdListadoTablaGeneradas(TablaCreada);

                            MetadatosAlimentosTabla metadatoAgregado = metadatosAlimentosTablaRepo.saveAndFlush(metadato_actual);

                            List<MetadatosAlimentosG> metadatosEvaluado = metadatosAlimentosRepo.metadatosAlimentosDeLaRegion(
                                                            chequeo_metadatos.get(met).getIdAlimento(), 
                                                            chequeo_metadatos.get(met).getIdRegion(), 
                                                            chequeo_metadatos.get(met).getIdEpoca(), 
                                                            chequeo_metadatos.get(met).getIdNivelFert(), 
                                                            chequeo_metadatos.get(met), 
                                                            chequeo_metadatos.get(met), 
                                                            chequeo_metadatos.get(met), 
                                                            chequeo_metadatos.get(met).getIdRangoEdades(), 
                                                            chequeo_metadatos.get(met), 
                                                            chequeo_metadatos.get(met),	
                                                            chequeo_metadatos.get(met),
                                                            chequeo_metadatos.get(met),
                                                            chequeo_metadatos.get(met).getCalidad(),
                                                            chequeo_metadatos.get(met).getImport1(),
                                                            chequeo_metadatos.get(met).getFertilizado()
                                                            );

                            GenerarTablaCasoActual(metadatosEvaluado, metadatoAgregado);
                        }
                    }
               }
           } 
        }
		
        alimentoEvaluadoRepo.deleteAll();
        
        map.put("mensaje", "Tabla generada con nombre: "+lis.getNombre());
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
    
    private void GenerarTablaCasoActual(List<MetadatosAlimentosG> chequeo_metadatos, MetadatosAlimentosTabla metadatoAgregado){
        AlimentoEvaluado MetEvaluado = new AlimentoEvaluado();
        if(chequeo_metadatos.size() == 1){

            //Agragar Id de metadato evaluado			
            MetEvaluado.setIdMetadatosEvaluado(chequeo_metadatos.get(0).getIdMetadatosAlimentosG());			
            alimentoEvaluadoRepo.saveAndFlush(MetEvaluado);

            List<TablaCnaGeneral> tabla_cna_general = cnaGeneralRepo.getTabla_cna_general(chequeo_metadatos.get(0));

            if(tabla_cna_general.size() > 0){

                for(int reg = 0; reg < tabla_cna_general.size(); reg++){

                    float valor = 0;
                    TablaCnaFinal tablaCnaFinal_tmp = new TablaCnaFinal(metadatoAgregado.getIdMetadatosAlimentosTabla(), tabla_cna_general.get(reg).getTablaCnaGeneralPK().getIdNutriente());
                    //tablaCnaFinal_tmp.TablaCnaFinal(metadatoAgregado.getIdMetadatosAlimentosTabla());
                    //tablaCnaFinal_tmp.setIdNutriente(tabla_cna_general.get(reg).getIdNutriente());				
                    tablaCnaFinal_tmp.setTotal(1);
                    tablaCnaFinal_tmp.setPromedio(tabla_cna_general.get(reg).getValor());
                    tablaCnaFinal_tmp.setMinimo(tabla_cna_general.get(reg).getValor());
                    tablaCnaFinal_tmp.setMaximo(tabla_cna_general.get(reg).getValor());
                    tablaCnaFinal_tmp.setDesvEst(valor);
                    tablaCnaFinal_tmp.setVarianza(valor);

                    cnaFinalRepo.saveAndFlush(tablaCnaFinal_tmp);
                }
            }
            /*
            hay que chequear cuando no tiene nutrientes if(tabla_cna_general.size() == 0) y cuando se muestre la tabla final
            generada el alimento va ha estar incompleto. En este caso se debe eliminar este alimento				
            */			
        }
        else{
            boolean ya_registrado_metadatos_evaluados = false; 
            List<Float> valores = null;
            for(int nut = 0; nut < ListaNutrientes.size(); nut++){
                System.out.println("Entro al primer FOR");
                valores.clear();
                for(int met = 0; met < chequeo_metadatos.size(); met++){
                    System.out.println("Entro al segundo FOR");
                    if (ya_registrado_metadatos_evaluados == false) {
                        //Agragar Id de metadato evaluado			
                        MetEvaluado.setIdMetadatosEvaluado(chequeo_metadatos.get(met).getIdMetadatosAlimentosG());			
                        alimentoEvaluadoRepo.saveAndFlush(MetEvaluado);
                        System.out.println("pase 1");
                    }
                    //El error puede ser aqui
                    TablaCnaGeneralPK cnaGeneralPK = new TablaCnaGeneralPK(chequeo_metadatos.get(met).getIdMetadatosAlimentosG(), ListaNutrientes.get(nut).getIdNutriente());
                    List<TablaCnaGeneral> tabla_cna_general = cnaGeneralRepo.getTabla_cna_general(cnaGeneralPK);
                    System.out.println("pase 2");
                    if(tabla_cna_general.size() > 0){
                        valores.add(tabla_cna_general.get(0).getValor());                        
                    }					
                }
                ya_registrado_metadatos_evaluados = true;//para que lo registre una sola vez

                int total = valores.size();

                if (total != 0) {
                    Estadistica estadistica = new Estadistica(valores);
                    double promedio = estadistica.media();
                    double minimo = estadistica.minimo();
                    double maximo = estadistica.maximo();
                    double desv_est = estadistica.desviacion_tipica();
                    double varianza = estadistica.varianza();
                    
                    TablaCnaFinal tablaCnaFinal_tmp = new TablaCnaFinal(metadatoAgregado.getIdMetadatosAlimentosTabla(), ListaNutrientes.get(nut).getIdNutriente());
                    //tablaCnaFinal_tmp.setIdMetadatosAlimentosTabla(metadatoAgregado.getIdMetadatosAlimentosTabla());
                    //tablaCnaFinal_tmp.setIdNutriente(ListaNutrientes.get(nut).getIdNutriente());				
                    tablaCnaFinal_tmp.setTotal(total);
                    tablaCnaFinal_tmp.setPromedio((float) promedio);
                    tablaCnaFinal_tmp.setMinimo((float) minimo);
                    tablaCnaFinal_tmp.setMaximo((float) maximo);

                    if (total == 1) {
                        float valor = 0;    
                        tablaCnaFinal_tmp.setDesvEst(valor);
                        tablaCnaFinal_tmp.setVarianza(valor);
                    }
                    else {
                        tablaCnaFinal_tmp.setDesvEst((float) desv_est);
                        tablaCnaFinal_tmp.setVarianza((float) varianza);
                    }					
                    cnaFinalRepo.saveAndFlush(tablaCnaFinal_tmp);
                }
            }			
        }
    }
    
    @Trazable(accion = "eliminar", eliminar = true, nombre = "eliminarTablaGenerada", timeLine = "", claseEntidad = "ListadoTablasGeneradas")
    @RequestMapping(value = "/tablasgeneradas/deleteTablasGeneradas/{id}", method = RequestMethod.DELETE)
    public ModelAndView deleteTablasGeneradas(@PathVariable Integer id, ModelMap map) {
        listadoTablaGeneradasRepo.delete(id);
        map.put("mensaje", "Tabla eliminada correctamente");
        return new ModelAndView(new MappingJackson2JsonView(), map);
    }
}
